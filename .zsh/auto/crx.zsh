crx-create-pem() {
  setopt err_return local_traps

  if [[ $# != 1 ]]; then
    echo "Usage: crx-create-pem <new pem path>" >&2
    return 1
  fi

  local pem="$1"
  if [[ -f "$pem" ]]; then
    echo "$pem already exists, aborting..." >&2
    return 1
  fi

  2> /dev/null openssl genrsa 2048 | openssl pkcs8 -topk8 -nocrypt -out "$pem"
  echo "Generated private key file '$pem'" >&2
  local pub_key="$(2> /dev/null openssl rsa -in "$pem" -pubout -outform DER | openssl base64 -A)"
  local extension_id="$(2> /dev/null openssl rsa -in "$pem" -pubout -outform DER | sha256sum | head -c32 | tr 0-9a-f a-p)"
  echo "Public key: $pub_key"
  echo "Extension id: $extension_id"
}

# Purpose: Pack a Chromium extension directory into crx format
crx-make() {
  setopt err_return local_traps

  if [[ $# != 2 ]]; then
    echo "Usage: crx-make <extension dir> <pem path>" >&2
    return 1
  fi

  local dir="$1"
  local key="$2"
  local name="$(basename "$dir")"
  local crx="$name.crx"
  local pub="$name.pub"
  local sig="$name.sig"
  local zip="$name.zip"
  trap "rm -f \"$pub\" \"$sig\" \"$zip\"" EXIT

  # zip up the crx dir
  local cwd="$(pwd -P)"
  (cd "$dir" && zip -qr -9 -X "$cwd/$zip" .)

  # signature
  openssl sha1 -sha1 -binary -sign "$key" < "$zip" > "$sig"

  # public key
  openssl rsa -pubout -outform DER < "$key" > "$pub" 2>/dev/null

  byte_swap () {
    # Take "abcdefgh" and return it as "ghefcdab"
    echo "${1:6:2}${1:4:2}${1:2:2}${1:0:2}"
  }

  local crmagic_hex="4372 3234" # Cr24
  local version_hex="0200 0000" # 2
  local pub_len_hex=$(byte_swap $(printf '%08x\n' $(ls -l "$pub" | awk '{print $5}')))
  local sig_len_hex=$(byte_swap $(printf '%08x\n' $(ls -l "$sig" | awk '{print $5}')))
  (
    echo "$crmagic_hex $version_hex $pub_len_hex $sig_len_hex" | xxd -r -p
    cat "$pub" "$sig" "$zip"
  ) > "$crx"
  echo "Wrote $crx" >&2
  return 0
}

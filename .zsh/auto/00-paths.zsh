+path() {
  [ -d "$1" ] && path=("$1" "${path[@]}")
}

path+() {
  [ -d "$d" ] && path+="$1"
}

cleanup-path() {
  local -a new_path
  local -A path_elements
  for d in "${path[@]}"; do
    if (( ! $+path_elements["$d"] )); then
      new_path+="$d"
      path_elements["$d"]=1
    fi
  done
  path=("${new_path[@]}")
}

+path ~/bin
path+ ~/bazel/output

cleanup-path

[ -x ~/nacl_sdk/naclsdk ] && alias naclsdk=~/nacl_sdk/naclsdk

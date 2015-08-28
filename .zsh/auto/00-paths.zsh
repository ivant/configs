+path() {
  [ -d "$1" ] && path=("$1" "${path[@]}")
}

path+() {
  [ -d "$1" ] && path+="$1"
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
path+ ~/chromium/depot_tools

NACL_SDK_ROOT="$(find $HOME/nacl_sdk -maxdepth 1 -type d -name 'pepper_*' | sort -r | head -n 1)"
[ -d "$NACL_SDK_ROOT" ] || unset NACL_SDK_ROOT
export NACL_SDK_ROOT

cleanup-path

[ -x ~/nacl_sdk/naclsdk ] && alias naclsdk=~/nacl_sdk/naclsdk

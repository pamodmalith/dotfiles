mkcd () {
  mkdir -p "$1"
  cd "$1"
}

# chpwd hook
chpwd(){
  ls
}

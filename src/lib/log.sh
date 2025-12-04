## usage: log <level> <message...>
log() {
  local level="$1"
  shift
  local msg="$*"
  local caller color_func rank_req rank_cur

  case "$level" in
    debug) rank_req=10 ;;
    info) rank_req=20 ;;
    warn) rank_req=30 ;;
    error) rank_req=40 ;;
    *) rank_req=20 ;;
  esac

  case "$REPLI_LOG_LEVEL" in
    debug) rank_cur=10 ;;
    info) rank_cur=20 ;;
    warn) rank_cur=30 ;;
    error) rank_cur=40 ;;
    *) rank_cur=20 ;;
  esac

  # filter by level
  [[ $rank_req -lt $rank_cur ]] && return 0

  # choose color function
  color_func="cyan"
  case "$level" in
    debug) color_func="magenta" ;;
    info) color_func="green" ;;
    warn) color_func="yellow_bold" ;;
    error) color_func="red_bold" ;;
  esac

  caller="${FUNCNAME[1]}"
  printf "$(green_bold "•") %s • %s $(green_bold →) %s\n" \
    "$("$color_func" "$level")" \
    "$caller" \
    "$msg" \
    >&2
}

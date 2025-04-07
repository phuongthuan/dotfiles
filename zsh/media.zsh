# mpd
alias mpd_start="mpd --no-daemon --verbose ~/.config/mpd/mpd.conf; echo ' Server was stopped 🔻';" # start mpd server
alias mpd_stop="mpd --kill ~/.config/mpd/mpd.conf; echo ' Stopped mpd server ✅';"                 # stop mpd server

# mpc
alias mpa='mpc add'
alias mpcl='mpc clear'
alias mpl='mpc clear && mpc load'
alias mps='mpc stop && mpc clear'

alias nls='npm ls --depth=0'
alias nd='npm run dev'

# Extract audio from a Youtube video
yt_dl() {
  if [ -z "$1" ]; then
    echo "Please provide a Youtube video URL 🔴"
    return 1
  fi
  yt-dlp --extract-audio --audio-format mp3 "$1"
}

# Play a playlist in mpd
mp() {
  if [ -z "$1" ]; then
    echo "Please provide a playlist 🔴"
    return 1
  fi
  mpc load "$1" && mpc play
}

# Show all songs in a playlist
mppl() {
  if [ -z "$1" ]; then
    mpc lsplaylists
    return 1
  else
    mpc playlist -f "%title%" "$1"
  fi
}

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

rename_last_recording_video() {
  # Get the latest recording video
  latest=$(ls -t ~/Pictures/screenshots/*.mov | head -n 1)

  if [[ -n "$latest" ]]; then
    mv "$latest" ~/Pictures/screenshots/$1.mov
    echo -e "\033[32mRenamed recoding video ❕ \033[0m"
  else
    echo -e "\033[31mNo recording video found ❌\033[0m"
    return 1
  fi
}

rename_last_screenshot() {
  # Get the latest recording video
  latest=$(ls -t ~/Pictures/screenshots/*.png | head -n 1)

  if [[ -n "$latest" ]]; then
    mv "$latest" ~/Pictures/screenshots/$1.png
    echo -e "\033[32mRenamed screenshot ❕ \033[0m"
  else
    echo -e "\033[31mNo screenshot found ❌\033[0m"
    return 1
  fi
}

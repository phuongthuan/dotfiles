# Extract audio from a Youtube video
function yt_dl() {
  if [ -z "$1" ]; then
    echo "Please provide a Youtube video URL 🔴"
    return 1
  fi
  yt-dlp --extract-audio --audio-format mp3 "$1"
}

# Play a playlist in mpd
function mp() {
  if [ -z "$1" ]; then
    echo "Please provide a playlist 🔴"
    return 1
  fi
  mpc load "$1" && mpc play
}

# Show all songs in a playlist
function mppl() {
  if [ -z "$1" ]; then
    mpc lsplaylists
    return 1
  else
    mpc playlist -f "%title%" "$1"
  fi
}

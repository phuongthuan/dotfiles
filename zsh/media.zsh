alias md='mpd'
alias mc='mpc'

# start mpd server
alias mds="mpd --no-daemon --verbose ~/.config/mpd/mpd.conf; echo ' Server was stopped 🔻';"

# kill mpd server
alias mdk="mpd --kill ~/.config/mpd/mpd.conf; echo ' Stopped mpd server ✅';"

# mpc
# alias mca='mpc add'
alias mcs='mpc status'
alias mcc='mpc clear'
alias mcn='mpc next'
alias mcp='mpc playlist'
alias mct='mpc toggle'
# alias mps='mpc stop && mpc clear'

# Extract audio(.mp3) from a Youtube video
ydl() {
  if [ -z "$1" ]; then
    echo "Please provide a Youtube video URL 🔴"
    return 1
  fi

  URL="$1"
  FILENAME="$2"
  OUTPUT=""

  if [ -n "$FILENAME" ]; then
    OUTPUT="$HOME/Music/$FILENAME.%(ext)s"
  else
    # Default to ~/Music/<video-title>.mp3
    OUTPUT="$HOME/Music/%(title)s.%(ext)s"
  fi

  echo -e "\n\033[32mExtracting audio from "$URL" ... \033[0m\n"

  yt-dlp \
    --extract-audio \
    --audio-format mp3 \
    --quiet \
    --no-warnings \
    --no-progres \
    -o "$OUTPUT" \
    "$URL"

  echo -e "\033[32mDownload $FILENAME.mp3 completed! \033[0m"

  echo -e "\033[32mUpdating mpd database ... \033[0m\n"
  # Update mpd database after downloading
  mpc update
}

music() {
  # Stop the current playlist
  if ! mpc clear; then
    echo "\n\033[31mFailed to clear the current playlist\033[0m"
    return 1
  fi

  # Load the specified playlist or the default playlist if none is provided
  if [ -z "$1" ]; then
    if ! mpc load "peace"; then
      echo "\n\033[31mFailed to load the default playlist 'peace'\033[0m"
      return 1
    fi
  else
    if ! mpc load "$1"; then
      echo "\n\033[31mFailed to load the playlist '$1'\033[0m"
      return 1
    fi
  fi

  mpc play

  echo "\n\033[32mStart playing music ... \033[0m\n"
}

mca() {
  if [ -z "$1" ]; then
    echo -e "\033[31mPlease provide song path❗\033[0m"
    return 1
  fi
  mpc add "$1"
}

# Play a song from the current mpc playlist: playsong <song_name>
playsong() {
  if [ -z "$1" ]; then
    echo -e "\033[31mPlease provide a song name❗\033[0m"
    return 1
  fi

  # fuzzy search song in the current playlist
  song_index="$(mpc playlist | rg -n "$1" | cut -d: -f1 | head -n1)"

  if [ -z "$song_index" ]; then
    echo -e "\033[31mSong not found in the current playlist ❌\033[0m"
    return 1
  fi

  echo -e "\n\033[32mPlaying song   \033[0m\n"
  mpc play $song_index
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

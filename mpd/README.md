# Setup mpd and mpc

https://www.musicpd.org/
https://www.musicpd.org/clients/mpc/

```bash
 brew install mpd mpc

 # Start mpd server
 pkill mpd # kills any running mpd process
 mpd ~/.config/mpd/mpd.conf

 # Update database
 mpc update
 ``` 

`zsh/media.zsh`

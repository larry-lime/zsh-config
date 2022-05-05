function startup {
    vdesk create:5
    vdesk on:1 run:brave "gmail.com" /new-window "linkedin.com" /new-window "https://brightspace.nyu.edu/d2l/home"
    vdesk on:1 run:Spotify.exe 
    vdesk on:1 run:WeChat.exe
}
startup

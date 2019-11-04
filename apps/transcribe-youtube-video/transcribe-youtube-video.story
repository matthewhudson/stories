
http server as server
  when server listen path:"/" method:"get" as req
    # NBC "Community" - Spanish Rap - HQ
    video = ytdl url:"https://www.youtube.com/watch?v=02dbxYYcE1c"
    audio = ffmpeg url:video
    res = gcloud storage url:audio bucket:"oms-hudson"
    text = gcloud speech-to-text url:res

    res writeJSON content: {"result":text}
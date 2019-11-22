http server as server
  when server listen path:"/" method:"get" as req
    # NBC "Community" - Spanish Rap - HQ
    # https://hub.storyscript.io/r/matthewhudson/oms-ytdl
    video = matthewhudson/oms-ytdl info url:"https://www.youtube.com/watch?v=02dbxYYcE1c"
    audio = matthewhudson/oms-ffmpeg transcode url:video.body.url format:"mp3"
    # GCloud Speech-to-Text API only accepts audio input from GCloud Storage, so lets upload first 
    res = matthewhudson/oms-gcloud-storage upload url:audio bucket:"oms-hudson"
    text = gcloud speech-to-text url:res

    res writeJSON content: {"result":text}
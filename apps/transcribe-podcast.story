# Story name should be accesible to the app and that can be an easy text/prefix we use scross the story accepted inputs
# How is error handling detected in Storyscript across transport protocols? HTTP 5xx? Stderr

[er, encoding] = encoding detect file:req.files[0]

[er, gsUri] = google-storage create file:req.files[0]

[er, transcriptResponse] = google-speech transcribe gsUri:gsUri encoding:encoding 

[er, grammarlyResponse] = grammarly text:transcriptResponse

email body:transcript recipients
upwork create &job 

`&job` inserts the value of a var named `job` from a config file

http server as server
  when server listen path:"/${path}" method:"post" as req

    http request method:"post"

when redis 
  send transcript to https://www.descript.com/ t
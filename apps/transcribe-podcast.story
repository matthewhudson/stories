# Story name should be accesible to the app and that can be an easy text/prefix we use scross the story accepted inputs
# How is error handling detected in Storyscript across transport protocols? HTTP 5xx? Stderr
http server as server
  when server listen path:"/" method:"post" as req
    encodingResponse = FileInfo inspect file:req.files[0]

    googleStorageResponse = GoogleStorage create url:audio bucket:"oms-ci"
   
    googleSpeechResponse = GoogleSpeech 
      gscUri: googleStorageResponse.gscUri
      encoding: encodingResponse.encoding
      sampleRateHertz: encodingResponse.sampleRateHertz
      languageCode: encodingResponse.languageCode

    grammarlyResponse = Grammarly text:googleSpeechResponse.transcript

    emailResponse body:transcript to:recipients 
    upwork create &job 


    res writeJSON content: {"result":text}


`&job` inserts the value of a var named `job` from a config file

http server as server
  when server listen path:"/${path}" method:"post" as req

    http request method:"post"

when redis 
  send transcript to https://www.descript.com/ t
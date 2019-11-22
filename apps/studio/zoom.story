when zoom events RecordingCompleted as recording
  transcript = ""
  foreach recording.files as file
    audioFile = http download url:file.download_url
    transcript += DeepSpeech process input:audioFile

  share_url = recording.share_url
  start_time = recording.start_time
  body = """Hi there,
Here is the transcript from your meeting that started at {start_time}.

{transcript}

Checkout the audio recording here: {share_url}
"""

  mailgun send to:recording.host_email
               from:"no-reply@example.com"
               subject:"Your Zoom Meeting Transcript"
               body:body

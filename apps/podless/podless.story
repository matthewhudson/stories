###
A story that downloads podcasts to an S3 bucket.
Inspiration: https://github.com/stilvoid/podless/blob/master/src/lambda.py
###

http server as server
  when server listen path:"/" method:"get" as req
    for feed in feeds
      handle_feed bucket:string name:feed.name url:feed.url

function handle_feed bucket:string name:string url:string returns null
  feed_entries = matthewhudson/parse-url-feed parse url:url

  foreach feed_entry in feed_entries
    skip = false

    foreach enclosure in feed_entry.enclosures:
      podcast_url = enclosure.href

      ###
      @TODO: 
      if podcast_url in keys
        skip = true
        break
      ###
      
      matthewhudson/oms-upload-url-to-s3 upload url:podcast_url
      # @TODO: How can I do error logging / retry.

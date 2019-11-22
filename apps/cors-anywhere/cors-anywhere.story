###
This is pseudo-Storyscript code. I'm intentionally writing it kinda-wacky as a little thought-experiment to find the tensions between what I know as a programmer, and what I think might feel more natural to a non-programmer. 
###
http server as server
  when server listen path:"/:url" method:"get" as req
    # Make proxy request
    proxyReq = http fetch url:url

    res set_header name:"access-control-allow-origin" value:"*"
    res set_header name:"access-control-max-age" value:(env get var:CORS_MAX_AGE)
    res set_header name:"access-control-allow-methods" value:"OPTIONS,GET"

    if proxyReq.contentType == "text/json" or proxyReq.contentType == "application/json"
      res writeJSON content:proxyReq.body
    else
      res write content:proxyReq.body

http server as server
  when server listen path:"/" method:"get" as req
    repo = req.headers["Referer"]
    log info msg:repo

    # Get the `oms.yml` contents
    file = http fetch method:"get" url:"https://raw.githubusercontent.com/oms-services/github/master/microservice.yml"
    log info msg:"HELLO"
    # Validate the yaml against the OMS microservice
    result = oms-validate validate file:file

    # Determine what color the badge should be.
    # @NOTE: It would be nice if the platform supported ternaries.
    # JS: color = result.length ? "red" : "green"
    # Coffee: color = if result.length then "red" else "green"
    # Rust: color = if result.length "red" else "green"
    if result.length() == 0
      badgeUrl = "https://img.shields.io/badge/Open%20Microservice%201.0-Valid-477bf3.svg"
    else
      badgeUrl = "https://img.shields.io/badge/Open%20Microservice%201.0-Invalid-red.svg"

    # Generate a SVG badge
    #badge = badge color:color title:"Open Microservice"

    # Send the raw SVG badge w/ the correct mime type
    #req write content:badge

    req redirect url:badgeUrl

http server as server
  when server listen path:"/" method:"get" as req
    repo = req.headers["referer"] 

    # Get the `oms.yml` contents
    file = github contents :repo path:"oms.yml"

    # Validate the yaml against the OMS microservice
    result = oms-validate validate file:file

    # Determine what color the badge should be.
    # @NOTE: It would be nice if the platform supported ternaries.
    # JS: color = result.length ? "red" : "green"
    # Coffee: color = if result.length then "red" else "green"
    # Rust: color = if result.length "red" else "green"
    if result.length == 0
      color = "green"
    else
      color = "red"

    # Generate a SVG badge
    badge = badge color:color title:"Open Microservice"

    # Send the badge w/ the correct mime type
    req write content:badge

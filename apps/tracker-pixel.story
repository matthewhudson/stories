# Simple HTTP 
http server as server
  when server listen path:"*" method:"get" as req

    mysql query query:"INSERT INTO requests: (
      uuid: req.body.uuid
      userAgent: req.body.userAgent
      ipAddress: : req.body.ipAddress
      date: req.body.date
      path: req.body.path
    )"

    # Do I need to send a valid body type? minimum png base64?
    res send statusCode:200 body:"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg==" contentType:"image/png"
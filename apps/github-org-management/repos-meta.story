###
A story that manages the meta data in all repos in an org.
Rather than attempt to make this generic, I should focus on making it specific to my current use-case. I don't even need an http server to invoke the runtime? I just want to run some basic tasks.
###

http server as server
  when server listen path:"/${path}" method:"get" as req
    # Make GitHub API requests
    repos = github api url:"/orgs/open-microservices" 
    foreach repos as repo
      handle_repo repo:repo

function handle_repo org:string repo:string returns null
  # PUT /repos/:owner/:repo/topics
  topicUrl = "/repos/" + org + "/" + repo + "/topics"
  repos = github api 
    url:topicUrl
    method:"put"
    data:{"names":[]}

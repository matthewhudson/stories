# GitHub Org Manager

1. Basic: Mass update the Topics, Description, URL of every repo in an
   organization.
2. Advanced: Mass update repo READMEs in the `oms-services` organization.

1) Fetch repo `oms.yml`
2) Parse repo `oms.yml`
3) Loop through each action and/or event
4) Send action/event to a formatter (along w/ arguments + env vars, and help
   text)
5) Open PR?
   http://www.levibotelho.com/development/commit-a-file-with-the-github-api/

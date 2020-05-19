# inspec_docker

Locally from A2 profiles:
- To check things locally, establish communication with your A2 instance: 
`inspec compliance login https://danflores.chef-demo.com --user=admin --token=YOUR_TOKEN`
- Run desired scan: `inspec exec compliance://admin/cis-docker-benchmark -t docker://e99f671a541a`

To report the data back into A2:
- Modify the kitchen.yml `client.rb` section to reflect your `server.url` and `token`
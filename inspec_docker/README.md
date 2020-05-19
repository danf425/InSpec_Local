# inspec_docker

Run A2 profiles locally against docker containers:
- First establish communication with your A2 to gain access to profiles: 
`inspec compliance login https://danflores.chef-demo.com --user=admin --token=YOUR_TOKEN`
- Run desired scan: `inspec exec compliance://admin/cis-centos7-level2-server -t docker://DOCKER_ID`
- Run desired scan and report it to A2 (Modify docker_id and config.json file w/ your url and token):
`inspec exec compliances://admin/cis-centos7-level2-server -t docker://DOCKER_ID --config ./config.json`


To run everything through Kitchen:
- Modify the kitchen.yml `client.rb` section to reflect your `server.url` and `token`

Running CIS Docker Benchmark:
- The CIS Docker Benchmark runs against the host. Just ssh to it:
`inspec exec compliance://admin/cis-docker-benchmark -t ssh://e99f671a541a`

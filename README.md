## Short TDD Exersice 

### Intent: Demonstrate the ease of using InSpec + Infra and test everything in a local box.

1. Generate chef cookbook (Creating a webserver) 
    `chef generate cookbook webserver_test`  
    `cd webserver_test`  
2. Look at it throw VSCode  
    `code .`  
4. Show the kitchen yaml... the structure of chef.... and converge the kitchen instance. 
   `kitchen converge centos`
5. Modify tests: `code test/integration/default/default_test.rb`
```
# is apache httpd installed?
describe package('httpd') do
  it { should be_installed }
end
# is the service enabled or running?
describe service('httpd') do
  # it { should be_enabled } https://github.com/chef/chef/issues/7119
  it { should be_running }
end
# what's the stdout of localhost?
describe command('curl localhost') do
  its('stdout') { should match /hello/ }
end
# is port 80 listening?
describe port(80) do
  it { should be_listening }
end
```   
Remove `, skip` in the example tests if you want
7. `kitchen verify centos`  
8. Add extra content and save:  `code recipes/default.rb`  
```
package 'httpd' do
    action :install
end
```   
10. `kitchen converge centos`
11. `kitchen verify centos`

12. Add content to default recipe again:  `code recipes/default.rb`   
```
# Start and enable the httpd service.
service 'httpd' do
  action [:enable, :start]
end

# Serve a custom home page.
file '/var/www/html/index.html' do
  content '<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>'
end
```


13. You can also do compliance from kitchen. Edit the `inspec_test` in `kitchen.yml` to :
```
suites:
  - name: default
    verifier:
      inspec_tests:
      #  - test/integration/default
         - name: dev-sec/linux-baseline
      #  - https://github.com/nathenharvey/tmp_compliance_profile   
      #  - name: ssh-hardening
      #    url: https://github.com/dev-sec/tests-ssh-hardening
      controls:
         - sshd-46
 
    attributes:
```
14. You can SSH into the kitchen instance to see that this isn't smoke and mirrors
 ``` kitchen ssh centos```


15. Add data collector to report data to automate 
```
provisioner:
  name: dokken
  always_update_cookbooks: true
  client_rb:
    data_collector.server_url: 'https://np-eh-a2.chef-demo.com/data-collector/v0/'
    data_collector.token: '61RpF2KmrtuNhqMnmH3jWUOsld0='
    verify_api_cert: false
    ssl_verify_mode: :verify_none
```

20. `kitchen destroy`  

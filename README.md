## TDD + Local Compliance Exercise  

##### Intent: Show value of "shifting left" both in terms of Compliance and Integration Testing. Demonstrate the ease of using InSpec + Infra locally through a simple exercise.

1. Generate chef cookbook (Creating a webserver)  
    `chef generate cookbook webserver_test`  
    `cd webserver_test`  
    
2. Look at the structure of it through VSCode  
    `code .`  
    
3. Show the kitchen yaml and explain how everything is functions. 
   Comment out the ubuntu line... Converge.
   `kitchen converge centos`  

4. Modify tests located in directory: `test/integration/default/default_test.rb`  
   Explain the resources you are using... below are some examples:  
  
```
# is apache httpd installed?
describe package('httpd') do
  it { should be_installed }
end

# is the service enabled or running?
describe service('httpd') do
  it { should be_enabled }
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

5. See that everything fails (it should because it's a brand new centos machine):  
  `kitchen verify centos`  
  
6. Add content to default.rb so that we can begin seeing chef infra in action:  `recipes/default.rb`  
```
package 'httpd' do
    action :install
end
```   
  
7. Apply changes to centos machine: `kitchen converge centos`  
  
8. One of the tests should pass now: `kitchen verify centos`  

9. Optional: add more content to default recipe if you want to get all the tests passing:  `recipes/default.rb`   
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
  
##### Cool, but what about local compliance?   
  
10. Edit the `inspec_test` in `kitchen.yml` to any of the below:
    Github integration is dope. Pulling compliance from a single source of truth. No excuses for shipping vulnerable infrastructure. Production ready as soon as it leaves your workstation. Buzzwords. blahblahblah.
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
```
  
11. Optional: You can SSH into the kitchen instance to see that this isn't smoke and mirrors
 ``` kitchen ssh centos```
  
12. Optional: Add data collector within `kitchen.yaml` to report data to automate: 
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
  
20. Destroy: `kitchen destroy`  

1. Generate chef repo  
    `chef generate repo test`  
    `cd test`  
2. Generate chef cookbook (Creating a webserver) 
    `chef generate cookbook cookbooks/webserver_test`  
    `cd cookbooks/webserver_test`  
3. Change chef version  
    `code .kitchen.yml`  
4. Change the `provisioner` line with below and save (Also, delete the ubuntu part):  
```
provisioner:
  name: chef_zero
  product_name: chef
  product_version: 14.12.3
```  
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


20. `kitchen destroy`  

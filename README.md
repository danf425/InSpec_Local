

1. Generate chef repo  
    `chef generate repo test`  
    `cd test`  
2. Generate chef cookbook  
    `chef generate cookbook cookbooks/webserver_test`  
    `cd cookbooks/webserver_test`  
3. Change chef version  
    `code .kitchen.yml`  
4. Change the `provisioner` line with below and save:  
```
provisioner:
  name: chef_zero
  product_name: chef
  product_version: 14.12.3
```  
5. Modify tests: `code test/integration/default/default_test.rb` 
```
describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  # it { should be_enabled } https://github.com/chef/chef/issues/7119
  it { should be_running }
end

describe command('curl localhost') do
  its('stdout') { should match /hello/ }
end

describe port(80) do
  it { should be_listening }
end
```   
Remove `, skip` if you want
7. `kitchen verify centos`  
8. Add extra content and save:  `code recipes/default.rb` 
```
package 'httpd'
```   
10. `kitchen converge centos`
11. `kitchen verify centos`
10. `kitchen destroy`  

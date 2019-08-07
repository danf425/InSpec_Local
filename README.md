

1. Generate chef repo  
    `chef generate repo test`  
    `cd test`  
2. Generate chef cookbook  
    `chef generate cookbook cookbooks/nginx`  
    `cd cookbooks/nginx`  
3. Change chef version  
    `code .kitchen.yml`  
4. Change the `provisioner` line with below and save:  
```
provisioner:
  name: chef_zero
  product_name: chef
  product_version: 14.12.3
  ```  
5. Remove `, skip` from tests:  
    `code test/integration/default/default_test.rb`  
6. `kitchen verify centos`  
7. Add extra content and save:  `code test/integration/default/default_test.rb` 
```
describe http('http://localhost', enable_remote_worker: true) do 
  its('status')  { should cmp 200 }  
  its('body')  { should cmp 'Inspec Jumpstart' }
  its('headers.Content-Type')  { should cmp 'text/html' }
end
```   
8. `kitchen verify centos`  
9. Fix it: `code ~/cookbooks/mynginx/recipes/default.rb`  
```
include_recipe 'nginx::repo'

package 'nginx' do
  action :install
end

remote_file '/usr/share/nginx/html/index.html' do
  source 'https://inspec-jumpstart-2019.s3.amazonaws.com/web01.html'
end

service 'nginx' do
  supports status:  true, restart: true, reload: true
  action [ :enable, :start ]
end
```
10. `kitchen converge centos`
11. `kitchen verify centos`
10. `kitchen destroy`  
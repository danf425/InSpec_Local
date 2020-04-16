describe user('root') do
    it { should exist }
end

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
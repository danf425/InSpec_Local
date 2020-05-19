# audit cookbook attributes:
default['audit']['reporter'] = 'chef-automate'
default['audit']['fetcher'] = 'chef-automate'
default['audit']['profiles'] = [
  {
    name: 'CIS Centos7 Level2 Server',
    compliance: 'admin/cis-centos7-level2-server',
  },
]

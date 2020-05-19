# audit cookbook attributes:
default['audit']['reporter'] = 'chef-automate'
default['audit']['fetcher'] = 'chef-automate'
default['audit']['profiles'] = [
  {
    name: 'CIS Docker Benchmark',
    compliance: 'admin/cis-docker-benchmark',
  },
]

case node['platform_family']
when 'rhel'
  # Install rhel apache2/httpd
  package 'httpd'
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
when 'debian'
  # Install debian apache2/httpd
  package 'apache2'
  # Start and enable apache service
  service 'apache2' do
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
end
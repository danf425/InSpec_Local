package { 'httpd':
  ensure => present,
}

service { 'httpd':
  ensure => running,
  enable => true,
}

file { "/var/www/html/index.html":
      content => "<html>
    <body>
      <h1>hello world</h1>
    </body>
  </html>",
}
class ssl::common {
  include ssl::variables
  package { 'openssl': ensure => present }

  group { 'ssl-cert':
    ensure => present,
    gid    => 361,
    system => true,
  }

  File {
    group => 'ssl-cert'
  }


  file { "${ssl::variables::ssl_root}/services" :
    ensure  => directory,
    mode    => 0644,
    purge   => true,
    require => Package['openssl']
  }

  file { $ssl::variables::ssl_local_certs:
    ensure  => directory,
    mode    => 2775,
    purge   => true,
    recurse => true,
    require => Package['openssl'],
  }
  
  file { $ssl::variables::ssl_chain:
    ensure  => directory,
    mode    => 2775,
    purge   => true,
    recurse => true,
    require => Package['openssl'],
  }
  
  exec { 'update-ca-certificates':
    command     => '/usr/sbin/update-ca-certificates',
    refreshonly => true,
    subscribe   => File[$ssl::variables::ssl_local_certs]
  }
}

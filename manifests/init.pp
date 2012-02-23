class ssl::common {
  include ssl::variables
  package { 'openssl': ensure => present }

  group { 'ssl-cert':
    ensure => present,
    gid    => 361,
    system => true,
  }

  File {
    require => Package['openssl'],
    group   => 'ssl-cert',
  }


  file { "${ssl::variables::ssl_root}/services" :
    ensure  => directory,
    mode    => '0644',
    purge   => true,
  }

  file { $ssl::variables::ssl_local_certs:
    ensure  => directory,
    mode    => '2775',
    purge   => true,
    recurse => true,
  }

  file { $ssl::variables::ssl_private:
    ensure  => directory,
    mode    => '0750',
    purge   => true,
    ignore  => 'ssl-cert-snakeoil.key',
    recurse => true,
  }

  exec { 'update-ca-certificates':
    command     => '/usr/sbin/update-ca-certificates',
    refreshonly => true,
    subscribe   => File[$ssl::variables::ssl_local_certs]
  }
}

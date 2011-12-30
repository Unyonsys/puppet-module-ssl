define ssl::key () {
  include ssl::variables
  include ssl::common

  file { "${ssl::variables::ssl_private}/key_${name}.key":
    ensure  => file,
    mode    => '0440',
    group   => 'ssl-cert',
    source  => "puppet:///files/ssl/key_${name}.key",
    require => Package['openssl']
  }
}

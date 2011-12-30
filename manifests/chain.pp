define ssl::chain (
  $source = "puppet:///files/ssl/chain_${name}.crt",
) {
  include ssl::variables
  include ssl::common

  file { "${ssl::variables::ssl_local_certs}/chain_${name}.crt" :
    ensure  => file,
    mode    => '0444',
    group   => 'ssl-cert',
    source  => $source,
    require => Package['openssl'],
    notify   => Exec['update-ca-certificates'],
  }
}

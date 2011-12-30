define ssl::config::cyrus (
    $tls_key,
    $tls_ca     = false,
    $tls_chain  = false,
    $link_to    = false
) {

  if ! ( $tls_ca ) and ! ( $tls_chain ) {
    fail ( 'You must provide either $tls_ca or $tls_chain' )
  }

  if $tls_ca {
    $tlscacertificatefile = "${ssl::variables::ssl_certs}/cert_${tls_ca}.crt"
    Ssl::Cert[$tls_ca] ~> Class['cyrus::service']
  }
  elsif $tls_chain {
    $tlscacertificatefile = "${ssl::variables::ssl_chain}/chain_${tls_chain}.crt"
    Ssl::Chain[$tls_chain] ~> Class['cyrus::service']
  }

  ssl::config { "cyrus_${name}":
    service => 'cyrus',
    cert    => $name,
    key     => $tls_key,
    ca      => $tls_ca,
    chain   => $tls_chain,
    link_to => $link_to,
    notify  => Class['cyrus::service']
  }

  if ! $link_to {
    Ssl::Key[$tls_key]  ~> Class['cyrus::service']
    Ssl::Cert[$name]    ~> Class['cyrus::service']
  }
}


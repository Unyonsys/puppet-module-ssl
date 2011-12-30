define ssl::config::apache2 (
    $tls_key    = false,
    $tls_ca     = false,
    $tls_chain  = false,
    $link_to    = false
  ) {

  ssl::config { "apache2_${name}":
    service => 'apache2',
    cert    => $name,
    key     => $tls_key,
    ca      => $tls_ca,
    chain   => $tls_chain,
    link_to => $link_to,
    notify  => Service['apache2']
  }

  if ! $link_to {
    Ssl::Key[$tls_key]              ~> Service['apache2']
    Ssl::Cert[$name]                ~> Service['apache2']
    if $tls_ca    { Ssl::Cert[$tls_ca]      ~> Service['apache2'] }
    if $tls_chain { Ssl::Chain[$tls_chain]  ~> Service['apache2'] }
  }
}

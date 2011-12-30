define ssl::config::openvpn (
    $tls_key,
    $tls_ca     = false,
    $tls_chain  = false,
    $link_to    = false
  ) {
  ssl::config { "openvpn_${name}":
    service => 'openvpn',
    cert    => $name,
    key     => $tls_key,
    ca      => $tls_ca,
    chain   => $tls_chain,
    link_to => $link_to,
    notify  => Service['openvpn']
  }
  if ! $link_to {
    Ssl::Key[$tls_key]              ~> Service['openvpn']
    Ssl::Cert[$name]                ~> Service['openvpn']
    if $tls_ca    { Ssl::Cert[$tls_ca]      ~> Service['openvpn'] }
    if $tls_chain { Ssl::Chain[$tls_chain]  ~> Service['openvpn'] }
  }
}


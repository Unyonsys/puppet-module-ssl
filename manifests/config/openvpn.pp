define ssl::config::openvpn (
    $key,
    $ca       = false,
    $chain    = false,
    $link_to  = false
  ) {
  ssl::config { "openvpn_${name}":
    service => 'openvpn',
    cert    => $name,
    key     => $key, 
    ca      => $ca,
    chain   => $chain,
    link_to => $link_to,
    notify  => Service['openvpn']
  }
}

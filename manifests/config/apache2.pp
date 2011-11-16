define ssl::config::apache2 (
    $key      = false,
    $ca       = false,
    $chain    = false,
    $link_to  = false
  ) {
    
  ssl::config { "apache2_${name}":
    service => 'apache2',
    cert    => $name,
    key     => $key, 
    ca      => $ca,
    chain   => $chain,
    link_to => $link_to,
    notify  => Service['apache2']
  }
}

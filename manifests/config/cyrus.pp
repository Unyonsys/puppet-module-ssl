define ssl::config::cyrus (
    $key,
    $ca       = false,
    $chain    = false,
    $link_to  = false
  ) {
  ssl::config { "cyrus_${name}":
    service => 'cyrus',
    cert    => $name,
    key     => $key, 
    ca      => $ca,
    chain   => $chain,
    link_to => $link_to,
    notify  => Service['cyrus']
  }
}


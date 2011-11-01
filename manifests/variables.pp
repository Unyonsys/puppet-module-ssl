class ssl::variables {  
  $ssl_root           = '/etc/ssl'
  $ssl_certs          = "${ssl_root}/certs"
  $ssl_private        = "${ssl_root}/private"
  $ssl_chain          = "${ssl_root}/chain"
  $ssl_local_certs    = '/usr/local/share/ca-certificates'
  $ssl_source_prefix  = 'puppet:///files/ssl'
}

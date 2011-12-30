class ssl::variables {
  $ssl_root           = '/etc/ssl'
  $ssl_certs          = "${ssl_root}/certs"
  $ssl_private        = "${ssl_root}/private"
  #Actually the same foder than cert, but it just makes it clearer in the code
  $ssl_chain          = "${ssl_root}/certs"
  $ssl_local_certs    = '/usr/local/share/ca-certificates'
}

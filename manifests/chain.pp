# $chain is a list of files that will be concatenated
define ssl::chain (
  $cert_list
  ) {
  include ssl::variables
  include ssl::common
  
  ### Bug 6710 - We would not need concacerte if this was working. Passing chain_name is only useful to declare the dependancy at each loop.
  #Ssl::Cert[$cert_list] -> Ssl::Chain[$title]
  
  concat { "${ssl::variables::ssl_chain}/chain_$name.crt":
    owner   => root,
    group   => root,
    mode    => 0644,
    require => Package['openssl'],
  }

  ssl::concatcerts { $cert_list:
    target     => "${ssl::variables::ssl_chain}/chain_$name.crt",
    base_path  => $ssl::variables::ssl_certs,
    chain_name => $name,
  }
}

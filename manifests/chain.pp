# $chain is a list of files that will be concatenated
define ssl::chain (
  $cert_hash
  ) {
  include ssl::variables
  include ssl::common
  
  ### Bug 6710 - We would not need concacerte if this was working. Passing chain_name is only useful to declare the dependancy at each loop.
  #Ssl::Cert[$cert_list] -> Ssl::Chain[$title]
  
  concat { "${ssl::variables::ssl_chain}/chain_$name.pem":
    owner   => root,
    group   => 'ssl-cert',
    mode    => 0644,
    require => Package['openssl'],
  }

  
  $keys = keys( $cert_hash )
  ssl::concatcerts { $keys:
    target     => "${ssl::variables::ssl_chain}/chain_$name.pem",
    base_path  => $ssl::variables::ssl_certs,
    chain_name => $name,
    hash       => $cert_hash,
  }
}


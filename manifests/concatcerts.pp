define ssl::concatcerts (
  $base_path,
  $target,
  $chain_name
  ) {
  include ssl::variables
  include ssl::common
  
  Ssl::Cert[$title] -> Ssl::Chain[$chain_name]
  
  concat::fragment{ "${target}_${title}": 
    target  => $target,
    source => "${base_path}/cert_${title}.pem",
  }
}

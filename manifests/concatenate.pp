define ssl::concatenate (
  $cert,
  $ca
  ) {
  include ssl::variables
  include ssl::common

  Ssl::Cert[$cert]  -> Ssl::Concatenate[$name]
  Ssl::Ca[$ca]      -> Ssl::Concatenate[$name]

  concat { "${ssl::variables::ssl_root}/certs/cert_${cert}_with_ca.crt":
    require => Ssl::Ca[$ca],
    mode    => '0444',
    group   => 'ssl-cert',
  }

  concat::fragment { $cert :
    target  => "${ssl::variables::ssl_root}/certs/cert_${cert}_with_ca.crt",
    order   => 05,
    source  => "puppet:///files/ssl/cert_${cert}.crt",
  }

  concat::fragment { $ca :
    target  => "${ssl::variables::ssl_root}/certs/cert_${cert}_with_ca.crt",
    order   => 10,
    source  => "puppet:///files/ssl/ca_${ca}.crt",
  }
}

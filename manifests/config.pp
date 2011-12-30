#This should not be called directly. Use service specific defines instead.
#The cert name is the name of the resource
define ssl::config (
  $service,
  $key,
  $cert,
  $ca       = false,
  $chain    = false,
  $link_to  = false
  ) {
  include ssl::variables
  include ssl::common

  if ! $key and ! $link_to {
    fail( 'You must pass either $key or $link_to')
  }

  if $link_to {
    file { "${ssl::variables::ssl_root}/services/${name}":
      ensure  => link,
      target  => "${ssl::variables::ssl_root}/services/${service}_${link_to}",
      require => Ssl::Config["${service}_${link_to}"],
    }
  }
  else {
    Ssl::Cert[$cert]         -> Ssl::Config[$name]

    if $key     { Ssl::Key[$key]      -> Ssl::Config[$name] }
    if $ca      { Ssl::Cert[$ca]      -> Ssl::Config[$name] }
    if $chain   { Ssl::Chain[$chain]  -> Ssl::Config[$name] }

    file { "${ssl::variables::ssl_root}/services/${name}" :
      ensure  => file,
      mode    => '0644',
      content => template("ssl/services/${service}_ssl.erb"),
    }
  }
}


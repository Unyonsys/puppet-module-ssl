class { 'ssl::common' : }

ssl::key  { 'unyonsys': }
ssl::cert { 'default.unyonsys.com': }
ssl::config::apache2 { 'default.unyonsys.com':  key => 'unyonsys' }
ssl::config::apache2 { 'nagios.unyonsys.com':  link_to => 'default.unyonsys.com' }


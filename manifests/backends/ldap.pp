# ldap backend for powerdns
class powerdns::backends::ldap inherits powerdns {

  # set the configuration variables
  powerdns::config { 'launch':
    ensure  => present,
    setting => 'launch',
    value   => 'ldap',
    type    => 'authoritative',
  }

  powerdns::config { 'ldap-host':
    ensure  => present,
    setting => 'ldap-host',
    value   => $::powerdns::db_host,
    type    => 'authoritative',
  }

  powerdns::config { 'ldap-binddn':
    ensure  => present,
    setting => 'ldap-binddn',
    value   => $::powerdns::db_username,
    type    => 'authoritative',
  }

  powerdns::config { 'ldap-secret':
    ensure  => present,
    setting => 'ldap-secret',
    value   => $::powerdns::db_password,
    type    => 'authoritative',
  }

  powerdns::config { 'ldap-basedn':
    ensure  => present,
    setting => 'ldap-basedn',
    value   => $::powerdns::db_name,
    type    => 'authoritative',
  }

  powerdns::config { 'ldap-method':
    ensure  => present,
    setting => 'ldap-method',
    value   => $::powerdns::ldap_method,
    type    => 'authoritative',
  }

  # set up the powerdns backend
  package { $::powerdns::params::ldap_backend_package_name:
    ensure  => installed,
    before  => Service[$::powerdns::params::authoritative_service],
    require => Package[$::powerdns::params::authoritative_package],
  }

  if $::powerdns::backend_install {
    fail('backend_install is not supported with ldap')
  }

  if $::powerdns::backend_create_tables {
    fail('backend_create_tables is not supported with ldap')
  }
}

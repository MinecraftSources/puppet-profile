class profile::base (
  $search,
  $nameservers
) {

  validate_string($search)
  validate_array($nameservers)

  # Manage resolve.conf
  file { '/etc/resolv.conf':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template('profile/resolv.conf.erb')
  }

}

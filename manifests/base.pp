class profile::base {

  # Manage DNS
  include ::dns
  
  case $operatingsystem {
    'RedHat', 'CentOS': {
      if $operatingsystemrelease =- /^7.*/ {
        # Remove firewalld
        package { 'firewalld':
          ensure => 'removed'
        }
      }
    }
  }
  

}

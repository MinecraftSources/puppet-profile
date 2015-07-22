class profile::base {

  # Manage DNS
  include ::dns
  
  case $operatingsystem {
    'RedHat', 'CentOS': {
      if $operatingsystemmajrelease == '7' {
        # Remove firewalld
        package { 'firewalld':
          ensure => 'purged'
        }
      }
    }
  }
  

}

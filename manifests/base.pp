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
  
  class { 'firewall': }

  firewallchain {'OUTPUT:filter:IPv4':
    purge => true,
  }
  
  firewall {'000 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
  firewall { "001 reject local traffic not on loopback interface":
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }
  firewall {'002 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
  firewall {"003 accpt ssh":
    proto  => 'tcp',
    port   => 22,
    state  => ['NEW'],
    action => 'accept',
  }
  firewall {"004 accept all from private network":
    source => '172.16.0.0/24'
    proto  => "all",
    state  => ['NEW'],
    action => "accept",
  }
  firewall {"999 drop all":
    proto  => "all",
    action => "drop",
  }
}

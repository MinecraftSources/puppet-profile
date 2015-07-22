class profile::nfs_server (
  $exports = {},
) {

  validate_hash($exports)
  
  include ::nfs::server
  
  create_resources('::nfs::server::export', $exports)

  $export_names = keys($exports)
  
  file { $export_names:
    ensure => 'directory'
  }
}

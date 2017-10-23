class profile::puppetboard {
  $ssl_dir = $::settings::ssldir
  $puppetboard_certname = $::certname
  class { 'puppetboard':
    groups              => 'puppet',
    manage_virtualenv   => true,
    puppetdb_host       => 'puppet.ericbisme.io',
    puppetdb_port       => '8082',
    puppetdb_key        => "${ssl_dir}/private_keys/${puppetboard_certname}.pem",
    puppetdb_ssl_verify => "${ssl_dir}/certs/ca.pem",
    puppetdb_cert       => "${ssl_dir}/certs/${puppetboard_certname}.pem",
  }
}

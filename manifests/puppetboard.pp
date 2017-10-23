class profile::puppetboard {
  $ssl_dir = $::settings::ssldir
  $puppetboard_certname = $::certname

  class { 'puppetboard':
    groups              => 'puppet',
    manage_virtualenv   => true,
    puppetdb_host       => 'puppet.ericbisme.io',
    puppetdb_port       => '8081',
    puppetdb_key        => "${ssl_dir}/private_keys/${puppetboard_certname}.pem",
    puppetdb_ssl_verify => "${ssl_dir}/certs/ca.pem",
    puppetdb_cert       => "${ssl_dir}/certs/${puppetboard_certname}.pem",
  }

	# Configure Apache
	# Ensure it does *not* purge configuration files
	class { 'apache':
		purge_configs => false,
		mpm_module    => 'prefork',
		default_vhost => true,
		default_mods  => false,
	}

	class { 'apache::mod::wsgi':
     wsgi_socket_prefix => "/var/run/wsgi",
  }

	# Access Puppetboard from example.com/puppetboard
	class { 'puppetboard::apache::conf': }
}

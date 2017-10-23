class profile::r10k {

  class { 'r10k':
    provider   => 'puppet_gem',
    configfile => '/etc/puppetlabs/r10k/r10k.yaml',
    sources   => {
      'puppet'  => {
        'remote'     => 'https://github.com/ericbisme/puppet-control.git',
        'basedir'    => "/etc/puppetlabs/code/environments",
        'prefix'     => false,
      },
    },
  }

  class { 'r10k::mcollective':
    ensure => false,
  }

  class {'r10k::webhook::config':
    use_mcollective => false,
    public_key_path  => "/etc/puppetlabs/puppet/ssl/ca/signed/${facts['fqdn']}.pem",
    private_key_path => "/etc/puppetlabs/puppet/ssl/private_keys/${facts['fqdn']}.pem",
    notify           => Service['webhook'],
  }

  class {'r10k::webhook':
    use_mcollective => false,
    user            => 'puppet',
    group           => 'puppet',
    require         => Class['r10k::webhook::config'],
  }
}

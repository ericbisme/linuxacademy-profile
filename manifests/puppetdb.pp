class profile::puppetdb {
  class { 'puppetdb':
    listen_address => 'puppet.ericbisme.io'
  }

  include puppetdb::master::config
}

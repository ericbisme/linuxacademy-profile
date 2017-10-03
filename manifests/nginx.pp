class profile::nginx(
  Array $vhosts,
) {
  include ::nginx
  notify { "testdata":
    message => $vhosts;
  }
  $vhosts.each |$vhost| {
    ::nginx::vhost { $vhost['fqdn']:
      port            => $vhost['port'],
      server_aliases  => $vhost['server_aliases']
    }
  }
}

$wildfly_version = '13.0.0.Final'
$wildfly_package = "wildfly-${wildfly_version}.tar.gz"
$wildfly_url_download = "http://download.jboss.org/wildfly/${wildfly_version}/${wildfly_package}"
$wildfly_dir = '/opt/wildfly'
$wildfly_user = 'vagrant'
$wildfly_group = 'vagrant'

exec {'install_wildfly':
  command => "true;
     cd /tmp;
     wget ${wildfly_url_download};
     tar xzf /tmp/${wildfly_package} -C ${wildfly_dir};
     /bin/chown -R ${wildfly_user}:${wildfly_group} ${wildfly_dir};
     /bin/chmod -R 755 ${wildfly_dir};
     /opt/wildfly/wildfly-13.0.0.Final/bin/standalone.sh -b 0.0.0.0 &;",
  provider => 'shell',
  path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin'],
  timeout => '14400',
  require => [Package['wget'],File[$wildfly_dir],],
}

package {'wget':
   ensure => present,
}

file {$wildfly_dir:
  ensure => 'directory',
  mode => '755',
  owner => $wildfly_user,
  group => $wildfly_group,
  require => User[$wildfly_user],
}

user {$wildfly_user:
  ensure => present,
}

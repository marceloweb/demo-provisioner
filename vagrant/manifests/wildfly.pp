$wildfly_version = '13.0.0.Final'
$wildfly_package = "wildfly-${wildfly_version}.tar.gz"
$wildfly_url_download = "http://download.jboss.org/wildfly/${wildfly_version}/${wildfly_package}"
$wildfly_dir = '/opt/wildfly'
$wildfly_user = 'wildfly'

exec {'install_wildfly':
  command => "true;
     cd /tmp;
     wget ${wildfly_url_download};
     tar xzf /tmp/${wildfly_package} -C ${wildfly_dir};",
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
  group => root,
  require => User[$wildfly_user],
}

user {$wildfly_user:
  ensure => present,
}

$tomcat_version = '8.5.15'
$tomcat_package = "apache-tomcat-${tomcat_version}.tar.gz"
$tomcat_url_download = "http://archive.apache.org/dist/tomcat/tomcat-8/v${tomcat_version}/bin/${tomcat_package}"
$tomcat_dir = '/opt/tomcat'
$tomcat_user = 'vagrant'
$tomcat_group = 'vagrant'

exec {'install_tomcat':
  command => "true;
     cd /tmp;
     wget ${tomcat_url_download};
     tar xzf /tmp/${tomcat_package} -C ${tomcat_dir};
     /bin/chown -R ${tomcat_user}:${tomcat_group} ${tomcat_dir};
     /bin/chmod -R 755 ${tomcat_dir};
     /opt/tomcat/apache-tomcat-8.5.15/bin/startup.sh start;",
  provider => 'shell',
  path => ['/usr/local/sbin','/usr/local/bin','/usr/sbin','/usr/bin','/sbin','/bin'],
  timeout => '14400',
  require => [Package['wget'],File[$tomcat_dir],],
}

package {'wget':
   ensure => present,
}

file {$tomcat_dir:
  ensure => 'directory',
  mode => '755',
  owner => $tomcat_user,
  group => vagrant,
  require => User[$tomcat_user],
}

user {$tomcat_user:
  ensure => present,
}


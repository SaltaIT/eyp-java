#
class java(
            $version=8,
            $srcdir='/usr/local/src',
            $basedir='/opt',
            $java_package=undef,
            $java_devel_package=undef,
          ) inherits java::params {

  Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
	}

  if(defined(Class['tomcat']))
  {
    $before_tomcat=Class['tomcat']
  }

  if($java_package!=undef)
  {
    package { $java_package:
      ensure => 'installed',
      before => $before_tomcat,
    }

    if($java_devel_package!=undef)
    {
      package { $java_devel_package:
        ensure => 'installed',
        before => $before_tomcat,
      }
    }
  }
  else
  {
    if($java::params::jre_download_command[$version]==undef)
    {
      fail('unsupported')
    }
    else
    {
      exec { "java $version download":
        command => "${java::params::jre_download_command[$version]} -O ${srcdir}/jre-${version}.tgz",
        creates => "${srcdir}/jre-${version}.tgz",
        require => Package['wget'],
        before => $before_tomcat,
      }

      file { "${basedir}/jre-${version}":
        ensure => 'directory',
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
      }

      exec { "targz java $version":
        command => "tar xzf ${srcdir}/jre-${version}.tgz -C ${basedir}/jre-${version} --strip-components=1",
        require => [ File["${basedir}/jre-${version}"], Exec["java $version download"] ],
        creates => "${basedir}/jre-${version}/bin/java",
      }

      exec { "update alternatives ${basedir}/jre-$version":
        command => "alternatives --install /usr/bin/java java ${basedir}/jre-${version}/bin/java 1",
        require => Exec["targz java $version"],
        unless  => "${unless_update_alternatives} | grep ${basedir}/jre-${version}/bin/java",
      }

      file { '/etc/profile.d/java.sh':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => "export JAVA_HOME=${basedir}/jre-${version}\n",
        require => Exec["update alternatives ${basedir}/jre-$version"],
      }
    }
  }
}

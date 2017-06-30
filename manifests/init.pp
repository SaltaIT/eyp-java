#
            # $version            = '8',
            # $srcdir             = '/usr/local/src',
            # $basedir            = '/opt',
class java(
            $java_package       = undef,
            $java_devel_package = undef,
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
  # else
  # {
  #   if($java::params::jre_download_command[$version]==undef)
  #   {
  #     fail('unsupported JRE version')
  #   }
  #   else
  #   {
  #     exec { 'which wget eyp-java':
  #       command => 'which wget',
  #       unless  => 'which wget',
  #     }
  #
  #     exec { "java ${version} download":
  #       command => "${java::params::jre_download_command[$version]} -O ${srcdir}/jre-${version}.tgz",
  #       creates => "${srcdir}/jre-${version}.tgz",
  #       require => Exec['which wget eyp-java'],
  #       before  => $before_tomcat,
  #     }
  #
  #     file { "${basedir}/jre-${version}":
  #       ensure => 'directory',
  #       owner  => 'root',
  #       group  => 'root',
  #       mode   => '0755',
  #     }
  #
  #     exec { "targz java ${version}":
  #       command => "tar xzf ${srcdir}/jre-${version}.tgz -C ${basedir}/jre-${version} --strip-components=1",
  #       require => [ File["${basedir}/jre-${version}"], Exec["java $version download"] ],
  #       creates => "${basedir}/jre-${version}/bin/java",
  #     }
  #
  #     exec { "update alternatives ${basedir}/jre-${version}":
  #       command => "alternatives --install /usr/bin/java java ${basedir}/jre-${version}/bin/java 1",
  #       require => Exec["targz java $version"],
  #       unless  => "${unless_update_alternatives} | grep ${basedir}/jre-${version}/bin/java",
  #     }
  #
  #     file { '/etc/profile.d/java.sh':
  #       ensure  => 'present',
  #       owner   => 'root',
  #       group   => 'root',
  #       mode    => '0755',
  #       content => "export JAVA_HOME=${basedir}/jre-${version}\n",
  #       require => Exec["update alternatives ${basedir}/jre-$version"],
  #     }
  #
  #     # [root@ar-prod-por01 tomcat8180]# alternatives --set java /opt/jre-7/bin/java
  #     # [root@ar-prod-por01 tomcat8180]# alternatives --list | grep java
  #     # java_sdk_openjdk	auto	/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64
  #     # java_sdk_1.7.0_openjdk	auto	/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.111-2.6.7.2.el7_2.x86_64
  #     # java_sdk_1.7.0	auto	/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.111-2.6.7.2.el7_2.x86_64
  #     # jre_1.8.0	auto	/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64/jre
  #     # jre_openjdk	auto	/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64/jre
  #     # jre_1.7.0	auto	/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.111-2.6.7.2.el7_2.x86_64/jre
  #     # java_sdk_1.8.0_openjdk	auto	/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64
  #     # java	manual	/opt/jre-7/bin/java
  #     # javac	auto	/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64/bin/javac
  #     # java_sdk_1.8.0	auto	/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64
  #     # [root@ar-prod-por01 tomcat8180]#
  #
  #     #TODO: canviar el unless per:
  #     # [root@ldapm src]# ls -la /etc/alternatives/java
  #     # lrwxrwxrwx 1 root root 19 Nov  4 15:08 /etc/alternatives/java -> /opt/jre-7/bin/java
  #     exec { "set java alternatives ${basedir}/jre-${version}":
  #       command => "alternatives --set java ${basedir}/jre-${version}/bin/java",
  #       require => Exec["update alternatives ${basedir}/jre-${version}"],
  #       unless  => "ls -la /etc/alternatives/java | grep ${basedir}/jre-${version}/bin/java",
  #     }
  #
  #
  #   }
  # }
}

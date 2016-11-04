#
class java::jce (
                  $version            = '8',
                  $srcdir             = '/usr/local/src',
                  $basedir            = '/opt',
                ) inherits java::params {
  Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
	}

  if(defined(Class['tomcat']))
  {
    $before_tomcat=Class['tomcat']
  }

  if($java::params::jce_download_command[$version]==undef)
  {
    fail('unsupported JCE version')
  }
  else
  {
    exec { 'which unzip eyp-java':
      command => 'which unzip',
      unless  => 'which unzip'
      require => Class['java'],
    }

    exec { "java ${version} download":
      command => "${java::params::jce_download_command[$version]} -O ${srcdir}/jce-${version}.zip",
      creates => "${srcdir}/jre-${version}.zip",
      require => Exec['which unzip eyp-java'],
      before  => $before_tomcat,
    }
  }
}

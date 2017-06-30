#
class java::jce (
                  $version            = $java::version,
                  $srcdir             = '/usr/local/src',
                  $basedir            = '/opt',
                  $download_source    = undef,
                ) inherits java::params {
  Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
	}

  fail('no longer working')

  if($java::params::jce_download_command[$version]==undef)
  {
    fail('unsupported JCE version')
  }
  else
  {
    exec { 'which unzip eyp-java':
      command => 'which unzip',
      unless  => 'which unzip',
      require => Class['java'],
    }

    if($download_source==undef)
    {
      exec { "java jce ${version} download":
        command => "${java::params::jce_download_command[$version]} -O ${srcdir}/jce-${version}.zip",
        creates => "${srcdir}/jce-${version}.zip",
        require => Exec['which unzip eyp-java'],
        before  => $before_tomcat,
      }
    }
    else
    {
      exec { "java jce ${version} download":
        command => "wget ${download_source} -O ${srcdir}/jce-${version}.zip",
        creates => "${srcdir}/jce-${version}.zip",
        require => Exec['which unzip eyp-java'],
        # before  => $before_tomcat,
      }
    }

    file { "${srcdir}/jce-${version}":
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Exec['which unzip eyp-java'],
    }

    exec { "java jce ${version} unzip":
      command => "unzip ${srcdir}/jce-${version}.zip -d ${srcdir}/jce-${version}",
      creates => "${srcdir}/jce-${version}/${jce_dir[$version]}",
      require => [ Exec["java jce ${version} download"], File["${srcdir}/jce-${version}"] ],
    }

    #$JAVA_HOME/jre/lib/security
    exec { "jce copy libraries ${version}":
      command => "cp -f ${srcdir}/jce-${version}/${jce_dir[$version]}/* ${java::basedir}/jre-${version}/lib/security",
      unless  => "md5sum ${srcdir}/jce-${version}/${jce_dir[$version]}/US_export_policy.jar ${srcdir}/jce-${version}/${jce_dir[$version]}/local_policy.jar ${java::basedir}/jre-${version}/lib/security/US_export_policy.jar ${java::basedir}/jre-${version}/lib/security/local_policy.jar | awk '{ print \$1 }' | sort | uniq | wc -l | grep 2",
      require => Exec["java jce ${version} unzip"],
    }
  }
}

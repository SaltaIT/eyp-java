define java::jre(
                  $version,
                  $jre_url,
                  $srcdir        = '/usr/local/src',
                  $basedir       = '/opt',
                  $set_java_home = false,
                ) {
  #
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  case $::osfamily
  {
    'redhat' :
    {
      $unless_update_alternatives='echo | alternatives --config java'
    }
    'Debian':
    {
      $unless_update_alternatives='alternatives --list'
    }
    default  : { fail('Unsupported OS!') }
  }

  exec { "which wget eyp-java ${jre_url} ${basedir}/jre-${version}":
    command => 'which wget',
    unless  => 'which wget',
  }

  exec { "java ${version} download":
    command => "wget ${jre_url} -O ${srcdir}/jre-${version}.tgz",
    creates => "${srcdir}/jre-${version}.tgz",
    require => Exec["which wget eyp-java ${jre_url} ${basedir}/jre-${version}"],
    # before  => $before_tomcat,
  }

  file { "${basedir}/jre-${version}":
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  exec { "targz jre ${version}":
    command => "tar xzf ${srcdir}/jre-${version}.tgz -C ${basedir}/jre-${version} --strip-components=1",
    require => [ File["${basedir}/jre-${version}"], Exec["java ${version} download"] ],
    creates => "${basedir}/jre-${version}/bin/java",
  }

  exec { "update alternatives ${basedir}/jre-${version}":
    command => "alternatives --install /usr/bin/java java ${basedir}/jre-${version}/bin/java 1",
    require => Exec["targz jre $version"],
    unless  => "${unless_update_alternatives} | grep ${basedir}/jre-${version}/bin/java",
  }

  exec { "set java alternatives ${basedir}/jre-${version}":
    command => "alternatives --set java ${basedir}/jre-${version}/bin/java",
    require => Exec["update alternatives ${basedir}/jre-${version}"],
    unless  => "ls -la /etc/alternatives/java | grep ${basedir}/jre-${version}/bin/java",
  }

  if($set_java_home)
  {
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

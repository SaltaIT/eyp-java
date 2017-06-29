define java::jre(
                  $version,
                  $jre_url,
                  $srcdir  = '/usr/local/src',
                  $basedir = '/opt',
                ) {
  #
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { "which wget eyp-java ${jre_url} ${basedir}/jre-${version}":
    command => 'which wget',
    unless  => 'which wget',
  }

  #(...)

}

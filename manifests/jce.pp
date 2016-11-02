#
class java::jce (
                  $version            = '8',
                  $srcdir             = '/usr/local/src',
                  $basedir            = '/opt',
                ) inherits java::params {
  Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
	}

  if($java::params::jce_download_command[$version]==undef)
  {
    fail('unsupported JCE version')
  }
  else
  {
  }
}

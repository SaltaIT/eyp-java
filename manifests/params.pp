class java::params {

  $jre_download_command= {
    8 => 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jre-8u40-linux-x64.tar.gz"',
  }

  case $::osfamily
  {
    'redhat' :
    {
      $unless_update_alternatives='echo | alternatives --config java'
      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
        }
        /^7.*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version!")  }
      }
    }
    'Debian':
    {
      $unless_update_alternatives='alternatives --list'
    }
    default  : { fail('Unsupported OS!') }
  }
}

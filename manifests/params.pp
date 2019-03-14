class java::params {

  case $::osfamily
  {
    'redhat' :
    {
      $default_java='java'
      case $::operatingsystemrelease
      {
        /^5.*$/:
        {
        }
        /^6.*$/:
        {
        }
        /^7.*$/:
        {
        }
        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    'Debian':
    {
      $default_java='default-jdk'
    }
    default  : { fail('Unsupported OS!') }
  }
}

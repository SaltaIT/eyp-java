class java::params {

  case $::osfamily
  {
    'redhat' :
    {
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
    }
    default  : { fail('Unsupported OS!') }
  }
}

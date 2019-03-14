# placeholder
class java(
            $install_default_java = true,
            $package_ensure       = 'installed',
            $master_jre_url       = undef,
          ) inherits java::params {
  if($install_default_java)
  {
    package { $java::params::default_java:
      ensure => $package_ensure,
    }
  }
  else
  {
    if($master_jre_url!=undef)
    {
      java::jre { 'default':
        jre_url => $master_jre_url,
      }
    }
  }
}

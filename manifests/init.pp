# placeholder
class java(
            $install_default_java = true,
            $package_ensure       = 'installed',
            $master_jre_url       = undef,
            $master_jre_name      = 'default',
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
      java::jre { $master_jre_name:
        jre_url => $master_jre_url,
      }
    }
  }
}

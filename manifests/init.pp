# placeholder
class java(
            $install_default_java = true,
            $package_ensure       = 'installed',
            $master_jre_url       = undef,
            $master_jre_name      = 'default',
            $java_package         = undef,
            $java_devel_package   = undef,
          ) inherits java::params {
  if($install_default_java)
  {
    if($java_package!=undef)
    {
      package { $java_package:
        ensure => $package_ensure,
      }
    }
    else
    {
      package { $java::params::default_java:
        ensure => $package_ensure,
      }
    }

    if($java_devel_package!=undef)
    {
      package { $java_devel_package:
        ensure => $package_ensure,
      }
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

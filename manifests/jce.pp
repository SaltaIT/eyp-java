#JCE 8
# curl 'http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip?AuthParam=1478085979_af1953e8644671c8bc4694ab4a2e780f' -H 'Host: download.oracle.com'
# -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0'
# -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
# -H 'Accept-Language: en-US,en;q=0.7,ca;q=0.3'
# --compressed
# -H 'Referer: http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html'
# -H 'Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjce8-download-2133166.html; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; oraclelicense=accept-securebackup-cookie'
# -H 'Connection: keep-alive'
# -H 'Upgrade-Insecure-Requests: 1'

# JCE 7
# curl 'http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip?AuthParam=1478105084_b0d1a919bfc834971a055ea485fde052' -H 'Host: download.oracle.com' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.7,ca;q=0.3' --compressed -H 'Referer: http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html'
# -H 'Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjce-7-download-432124.html; oraclelicense=accept-securebackup-cookie'
# -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1'

# $jce_download_command = {
#   '7' => 'wget --no-cookies --no-check-certificate --header "Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjce-7-download-432124.html; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip"',
#   '8' => 'wget --no-cookies --no-check-certificate --header "Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjce8-download-2133166.html; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"',
# }

define java::jce(
                  $jce_url,
                  $version = $name,
                  $srcdir  = '/usr/local/src',
                  $basedir = '/opt',
                ) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  $jce_dir = {
    '7' => 'UnlimitedJCEPolicy',
    '8' => 'UnlimitedJCEPolicyJDK8',
  }

  exec { "which unzip eyp-java jce-${version} ${name}":
    command => 'which unzip',
    unless  => 'which unzip',
    require => Java::Jre[$version],
  }

  exec { "which wget eyp-java jce-${version} ${name}":
    command => 'which wget',
    unless  => 'which wget',
  }

  exec { "java jce ${version} download":
    command => "wget ${jce_url} -O ${srcdir}/jce-${version}.zip",
    creates => "${srcdir}/jce-${version}.zip",
    require => Exec["which wget eyp-java jce-${version} ${name}"],
  }

  file { "${srcdir}/jce-${version}":
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Exec["java jce ${version} download"],
  }

  exec { "java jce ${version} unzip":
    command => "unzip ${srcdir}/jce-${version}.zip -d ${srcdir}/jce-${version}",
    creates => "${srcdir}/jce-${version}/${jce_dir[$version]}",
    require => [ Exec["which unzip eyp-java jce-${version} ${name}"], File["${srcdir}/jce-${version}"] ],
  }

  #$JAVA_HOME/jre/lib/security
  exec { "jce copy libraries ${version}":
    command => "cp -f ${srcdir}/jce-${version}/${jce_dir[$version]}/* ${java::basedir}/jre-${version}/lib/security",
    unless  => "md5sum ${srcdir}/jce-${version}/${jce_dir[$version]}/US_export_policy.jar ${srcdir}/jce-${version}/${jce_dir[$version]}/local_policy.jar ${java::basedir}/jre-${version}/lib/security/US_export_policy.jar ${java::basedir}/jre-${version}/lib/security/local_policy.jar | awk '{ print \$1 }' | sort | uniq | wc -l | grep 2",
    require => Exec["java jce ${version} unzip"],
  }
}
#
# #
# # TODO: change class to define?
# class java::jce (
#                   $version            = $java::version,
#                   $srcdir             = '/usr/local/src',
#                   $basedir            = '/opt',
#                   $download_source    = undef,
#                 ) inherits java::params {
#   # Exec {
#   #   path => '/bin:/sbin:/usr/bin:/usr/sbin',
#   # }
#   #
#   fail('no longer working')
#   #
#   # if($java::params::jce_download_command[$version]==undef)
#   # {
#   #   fail('unsupported JCE version')
#   # }
#   # else
#   # {
#   #   exec { 'which unzip eyp-java':
#   #     command => 'which unzip',
#   #     unless  => 'which unzip',
#   #     require => Class['java'],
#   #   }
#   #
#   #   if($download_source==undef)
#   #   {
#   #     exec { "java jce ${version} download":
#   #       command => "${java::params::jce_download_command[$version]} -O ${srcdir}/jce-${version}.zip",
#   #       creates => "${srcdir}/jce-${version}.zip",
#   #       require => Exec['which unzip eyp-java'],
#   #     }
#   #   }
#   #   else
#   #   {
#   #     exec { "java jce ${version} download":
#   #       command => "wget ${download_source} -O ${srcdir}/jce-${version}.zip",
#   #       creates => "${srcdir}/jce-${version}.zip",
#   #       require => Exec['which unzip eyp-java'],
#   #     }
#   #   }
#   #
#   #   file { "${srcdir}/jce-${version}":
#   #     ensure  => 'directory',
#   #     owner   => 'root',
#   #     group   => 'root',
#   #     mode    => '0755',
#   #     require => Exec['which unzip eyp-java'],
#   #   }
#   #
#   #   exec { "java jce ${version} unzip":
#   #     command => "unzip ${srcdir}/jce-${version}.zip -d ${srcdir}/jce-${version}",
#   #     creates => "${srcdir}/jce-${version}/${jce_dir[$version]}",
#   #     require => [ Exec["java jce ${version} download"], File["${srcdir}/jce-${version}"] ],
#   #   }
#   #
#   #   #$JAVA_HOME/jre/lib/security
#   #   exec { "jce copy libraries ${version}":
#   #     command => "cp -f ${srcdir}/jce-${version}/${jce_dir[$version]}/* ${java::basedir}/jre-${version}/lib/security",
#   #     unless  => "md5sum ${srcdir}/jce-${version}/${jce_dir[$version]}/US_export_policy.jar ${srcdir}/jce-${version}/${jce_dir[$version]}/local_policy.jar ${java::basedir}/jre-${version}/lib/security/US_export_policy.jar ${java::basedir}/jre-${version}/lib/security/local_policy.jar | awk '{ print \$1 }' | sort | uniq | wc -l | grep 2",
#   #     require => Exec["java jce ${version} unzip"],
#   #   }
#   # }
# }

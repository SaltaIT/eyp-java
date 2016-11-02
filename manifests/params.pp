class java::params {

  # java 7
  # curl 'http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jre-7u79-linux-x64.tar.gz?AuthParam=1478102091_2224974aa9de1f856a3645fdf6d5186b' -H 'Host: download.oracle.com' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:49.0) Gecko/20100101 Firefox/49.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.7,ca;q=0.3' --compressed -H 'Referer: http://www.oracle.com/technetwork/java/javase/downloads/jre7-downloads-1880261.html'
  # -H 'Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjre7-downloads-1880261.html; oraclelicense=accept-securebackup-cookie' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1'


  $jre_download_command = {
    '7' => 'wget --no-cookies --no-check-certificate --header "Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjre7-downloads-1880261.html; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jre-7u79-linux-x64.tar.gz"',
    '8' => 'wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u40-b25/jre-8u40-linux-x64.tar.gz"',
  }

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

  $jce_download_command = {
    '7' => 'wget --no-cookies --no-check-certificate --header "Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjce-7-download-432124.html; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip"',
    '8' => 'wget --no-cookies --no-check-certificate --header "Cookie: s_cc=true; s_nr=1477490926025; s_sq=%5B%5BB%5D%5D; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjce8-download-2133166.html; ELOQUA=GUID=16F41EDAA12E43639FABA7188286B4A8; notice_preferences=2:cb8350a2759273dccf1e483791e6f8fd; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"',
  }

  case $::osfamily
  {
    'redhat' :
    {
      $unless_update_alternatives='echo | alternatives --config java'
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
      fail('work in progress')
      $unless_update_alternatives='alternatives --list'
    }
    default  : { fail('Unsupported OS!') }
  }
}

# CentOS Continuous Release - The continuous release ( CR )
# repository contains packages from the next point release
# of CentOS, which isn't itself released as yet.
class repo_centos::cr  (
  $enable_cr = false
) inherits repo_centos::params {

  if $enable_cr {
    $enabled = 1
  } else {
    $enabled = 0
  }

  yumrepo { 'centos-cr':
    baseurl  => "${url}/${urlbit}/cr/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} Continuous Release - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    priority => '1',
  }

}

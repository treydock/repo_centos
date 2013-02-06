# CentOS Extras - This repository contains items that provide additional
# functionality to CentOS without breaking upstream compatibility or
# updating base components. The CentOS development team have tested
# every item in this repository and they all work with CentOS.
# They have not been tested by the upstream provider and are not available
# in the upstream products.
# This repository is shipped with CentOS and is enabled by default
class repo_centos::extras  (
  $enable_extras = false
) inherits repo_centos::params {

  if $enable_extras {
    $enabled = 1
  } else {
    $enabled = 0
  }

  yumrepo { 'centos-extras':
    baseurl  => "${url}/${urlbit}/extras/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} Extras - ${::architecture}",
    enabled  => "${enabled}",
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    priority => '2',
  }

}

# Base includes the CentOS base files from the initial release
class repo_centos::base inherits repo_centos::params {
  
  file { "/etc/yum.repos.d/centos${::os_maj_version}.repo": ensure => absent, }
  file { "/etc/yum.repos.d/CentOS-Base.repo": ensure => absent, }
  file { "/etc/yum.repos.d/CentOS-Debuginfo.repo": ensure => absent, }
  file { "/etc/yum.repos.d/CentOS-Media.repo": ensure => absent, }
  
  yumrepo { 'centos-base':
    baseurl  => "${url}/${urlbit}/os/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} OS Base - ${::architecture}",
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    priority => '1',
  }

}
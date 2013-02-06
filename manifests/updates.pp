# The CentOS Updates repository
class repo_centos::updates inherits repo_centos::params {

  yumrepo { 'centos-updates':
    baseurl  => "${url}/${urlbit}/updates/${::architecture}",
    descr    => "${operatingsystem} ${::os_maj_version} Updates - ${::architecture}",
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    priority => '1',
  }

}
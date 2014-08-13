# SRPM repos for CentOS
class repo_centos::source {

  include repo_centos

  if $repo_centos::enable_source {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  yumrepo { 'centos-base-source':
    baseurl  => "${repo_centos::source_repourl}/${::operatingsystemrelease}/os/Source",
    descr    => "CentOS-${::operatingsystemrelease} - Base Source",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::repo_centos::releasever}",
  }

  yumrepo { 'centos-updates-source':
    baseurl  => "${repo_centos::source_repourl}/${::operatingsystemrelease}/updates/Source",
    descr    => "CentOS-${::operatingsystemrelease} - Updates Source",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::repo_centos::releasever}",
  }

}

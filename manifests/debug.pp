# CentOS debug - Debuginfo packages
# This repository is shipped with CentOS and is disabled by default
class repo_centos::debug {

  include repo_centos

  if $repo_centos::enable_debug {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  yumrepo { 'centos-debug':
    baseurl  => "${repo_centos::debug_repourl}/${repo_centos::releasever}/${::architecture}",
    descr    => "CentOS-${repo_centos::releasever} - Debuginfo",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${repo_centos::releasever}",
  }

}

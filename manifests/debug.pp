# CentOS debug - Debuginfo packages
# This repository is shipped with CentOS and is disabled by default
class repo_centos::debug {

  include repo_centos

  if $repo_centos::enable_debug {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  if $repo_centos::releasever != '5' {
    $_gpgkey = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${repo_centos::releasever}"
  } else {
    $_gpgkey = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}"
  }

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'CentOS-Debuginfo' |> { ensure => $repo_centos::ensure_debug }
  }

  yumrepo { 'CentOS-Debuginfo':
    name     => 'base-debuginfo',
    target   => '/etc/yum.repos.d/CentOS-Debug.repo',
    baseurl  => "${repo_centos::debug_repourl}/${repo_centos::releasever}/\$basearch/",
    descr    => "CentOS-${repo_centos::releasever} - Debuginfo",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => $_gpgkey,
  }

}

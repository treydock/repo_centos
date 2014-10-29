# The CentOS Updates repository
class repo_centos::updates {

  include repo_centos

  if $repo_centos::enable_updates {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
  #baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'centos-updates' |> { ensure => $repo_centos::ensure_updates }
  }

  yumrepo { 'centos-updates':
    baseurl  => "${repo_centos::repourl}/${repo_centos::urlbit}/updates/${::architecture}",
    descr    => "${::operatingsystem} ${repo_centos::releasever} Updates - ${::architecture}",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
    #priority => '1',
  }

}

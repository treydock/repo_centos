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

  yumrepo { 'centos-updates':
    baseurl  => "${repo_centos::repourl}/${repo_centos::urlbit}/updates/${::architecture}",
    descr    => "${::operatingsystem} ${repo_centos::releasever} Updates - ${::architecture}",
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${repo_centos::releasever}",
    #priority => '1',
  }

}

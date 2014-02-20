# Optional parameters in setting up CentOS Yum repository
class repo_centos::params {
  #                               http://mirror.centos.org/centos/$releasever/os/$basearch/
  #                               baseurl  => "${repourl}/${urlbit}/os/${::architecture}",
  $repourl                     = 'http://mirror.centos.org/centos'
  $enable_base                 = true
  $enable_contrib              = false
  $enable_cr                   = false
  $enable_extras               = true
  $enable_plus                 = false
  $enable_scl                  = false
  $enable_updates              = true
  $ostype = 'CentOS'
  $urlbit = "${::os_maj_version}"
}

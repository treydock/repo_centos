# == Class: repo_centos::clean
#
class repo_centos::clean {

  file { "/etc/yum.repos.d/centos${repo_centos::releasever}.repo": ensure => absent }

}

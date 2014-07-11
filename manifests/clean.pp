# == Class: repo_centos::clean
#
class repo_centos::clean {

  include repo_centos

  file { "/etc/yum.repos.d/centos${repo_centos::releasever}.repo": ensure => absent }
  file { '/etc/yum.repos.d/CentOS-Base.repo': ensure => absent }
  file { '/etc/yum.repos.d/CentOS-Vault.repo': ensure => absent }
  file { '/etc/yum.repos.d/CentOS-Debuginfo.repo': ensure => absent }
  file { '/etc/yum.repos.d/CentOS-Media.repo': ensure => absent }
  file { '/etc/yum.repos.d/CentOS-Sources.repo': ensure => absent }
  file { '/etc/yum.repos.d/CentOS-SCL.repo': ensure => absent }

}

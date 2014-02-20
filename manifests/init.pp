# == Class: repo_centos
#
# Configure the CentOS 5 or 6 repositories and import GPG keys
#
# === Parameters:
#
# $repourl::                       The base repo URL, if not specified defaults to the
#                                  CentOS Mirror
#                                  
# $enable_base::                   Enable the CentOS Base Repo
#                                  type:boolean
#
# $enable_contrib::                Enable the CentOS User Contrib Repo
#                                  type:boolean
#
# $enable_cr::                     Enable the CentOS Continuous Release Repo
#                                  type:boolean
#
# $enable_extras::                 Enable the CentOS Extras Repo
#                                  type:boolean
#
# $enable_plus::                   Enable the CentOS Plus Repo
#                                  type:boolean
#
# $enable_scl::                    Enable the CentOS SCL Repo
#                                  type:boolean
#
# $enable_updates::                Enable the CentOS Updates Repo
#                                  type:boolean
#
# === Usage:
# * Simple usage:
#
#  include repo_centos
#
# * Advanced usage:
#
#   class {'repo_centos':
#     repourl       => 'http://myrepo/centos',
#     enable_scl    => true,
#   }
#
# * Alternate usage via hiera YAML:
#
#   repo_centos::repourl: 'http://myrepo/centos'
#   repo_centos::enable_scl: true
#
class repo_centos (
    $repourl                     = $repo_centos::params::repourl,
    $enable_base                 = $repo_centos::params::enable_base,
    $enable_contrib              = $repo_centos::params::enable_contrib,
    $enable_cr                   = $repo_centos::params::enable_cr,
    $enable_extras               = $repo_centos::params::enable_extras,
    $enable_plus                 = $repo_centos::params::enable_plus,
    $enable_scl                  = $repo_centos::params::enable_scl,
    $enable_updates              = $repo_centos::params::enable_updates,
  ) inherits repo_centos::params {

  validate_string($repourl)
  validate_bool($enable_base)
  validate_bool($enable_contrib)
  validate_bool($enable_cr)
  validate_bool($enable_extras)
  validate_bool($enable_plus)
  validate_bool($enable_scl)
  validate_bool($enable_updates)
  
  if $::operatingsystem == 'CentOS' {
    include repo_centos::base
    include repo_centos::contrib
    include repo_centos::cr
    include repo_centos::extras
    include repo_centos::plus
    include repo_centos::scl
    include repo_centos::updates
    
    file { "/etc/yum.repos.d/centos${::os_maj_version}.repo": ensure => absent, }
	  file { "/etc/yum.repos.d/CentOS-Base.repo": ensure => absent, }
	  file { "/etc/yum.repos.d/CentOS-Debuginfo.repo": ensure => absent, }
	  file { "/etc/yum.repos.d/CentOS-Media.repo": ensure => absent, }
	  
    repo_centos::rpm_gpg_key{ "RPM-GPG-KEY-CentOS-${::os_maj_version}":
      path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    }

    file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::os_maj_version}":
      ensure => present,
      owner  => 0,
      group  => 0,
      mode   => '0644',
      source => "puppet:///modules/repo_centos/RPM-GPG-KEY-CentOS-${::os_maj_version}",
    }

  } else {
      notice ("Your operating system ${::operatingsystem} does not need CentOS repositories")
  }

}

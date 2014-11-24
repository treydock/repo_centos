# == Class: repo_centos
#
# Configure the CentOS 5 or 6 repositories and import GPG keys
#
# === Parameters:
#
# $enable_mirrorlist::             Enables the yumrepo mirrorlist parameter and
#                                  disables the baseurl
#                                  type:boolean
#
# $repourl::                       The base repo URL, if not specified defaults to the
#                                  CentOS Mirror
#
# $mirrorlisturl::                 The mirrorlist repo URL, if not specified
#                                  defaults to the CentOS Mirror
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
    $enable_mirrorlist           = $repo_centos::params::enable_mirrorlist,
    $repourl                     = $repo_centos::params::repourl,
    $debug_repourl               = $repo_centos::params::debug_repourl,
    $source_repourl              = $repo_centos::params::source_repourl,
    $mirrorlisturl               = $repo_centos::params::mirrorlisturl,
    $enable_base                 = $repo_centos::params::enable_base,
    $enable_contrib              = $repo_centos::params::enable_contrib,
    $enable_cr                   = $repo_centos::params::enable_cr,
    $enable_extras               = $repo_centos::params::enable_extras,
    $enable_plus                 = $repo_centos::params::enable_plus,
    $enable_scl                  = $repo_centos::params::enable_scl,
    $enable_updates              = $repo_centos::params::enable_updates,
    $enable_source               = $repo_centos::params::enable_source,
    $enable_debug                = $repo_centos::params::enable_debug,
    $ensure_base                 = $repo_centos::params::ensure_base,
    $ensure_contrib              = $repo_centos::params::ensure_contrib,
    $ensure_cr                   = $repo_centos::params::ensure_cr,
    $ensure_extras               = $repo_centos::params::ensure_extras,
    $ensure_plus                 = $repo_centos::params::ensure_plus,
    $ensure_scl                  = $repo_centos::params::ensure_scl,
    $ensure_updates              = $repo_centos::params::ensure_updates,
    $ensure_source               = $repo_centos::params::ensure_source,
    $ensure_debug                = $repo_centos::params::ensure_debug,
  ) inherits repo_centos::params {

  validate_bool($enable_mirrorlist)
  validate_string($repourl)
  validate_string($debug_repourl)
  validate_string($source_repourl)
  validate_string($mirrorlisturl)
  validate_bool($enable_base)
  validate_bool($enable_contrib)
  validate_bool($enable_cr)
  validate_bool($enable_extras)
  validate_bool($enable_plus)
  validate_bool($enable_scl)
  validate_bool($enable_updates)
  validate_bool($enable_source)
  validate_bool($enable_debug)

  if $::operatingsystem == 'CentOS' {
    $releasever = $repo_centos::params::releasever

    stage { 'repo_centos_clean':
      before  => Stage['main'],
    }

    class { 'repo_centos::clean':
      stage => repo_centos_clean,
    }

    include repo_centos::base
    include repo_centos::contrib
    include repo_centos::cr
    include repo_centos::extras
    include repo_centos::plus
    include repo_centos::scl
    include repo_centos::updates
    include repo_centos::source
    include repo_centos::debug

    anchor { 'repo_centos::start': }->
    Class['repo_centos::base']->
    Class['repo_centos::contrib']->
    Class['repo_centos::cr']->
    Class['repo_centos::extras']->
    Class['repo_centos::plus']->
    Class['repo_centos::scl']->
    Class['repo_centos::updates']->
    Class['repo_centos::source']->
    Class['repo_centos::debug']->
    anchor { 'repo_centos::end': }->
    Package<| |>

    gpg_key { "RPM-GPG-KEY-CentOS-${releasever}":
      path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${releasever}",
      before => Anchor['repo_centos::start'],
    }

    gpg_key { "RPM-GPG-KEY-CentOS-Debug-${releasever}":
      path   => "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${releasever}",
      before => Anchor['repo_centos::start'],
    }
  } else {
      notice ("Your operating system ${::operatingsystem} does not need CentOS repositories")
  }

}

# Optional parameters in setting up CentOS Yum repository
class repo_centos::params {

  if $::operatingsystemmajrelease {
    $releasever = $::operatingsystemmajrelease
  } elsif $::os_maj_version {
    $releasever = $::os_maj_version
  } else {
    $releasever = inline_template('<%= @operatingsystemrelease.split(".").first %>')
  }

  $enable_mirrorlist           = true
  $repourl                     = 'http://mirror.centos.org/centos'
  $debug_repourl               = 'http://debuginfo.centos.org'
  $source_repourl              = 'http://vault.centos.org/centos'
  $mirrorlisturl               = 'http://mirrorlist.centos.org'
  $enable_base                 = true
  $enable_contrib              = false
  $enable_cr                   = false
  $enable_extras               = true
  $enable_plus                 = false
  $enable_scl                  = false
  $enable_updates              = true
  $enable_source               = false
  $enable_debug                = false
  $ostype                      = 'CentOS'
  $ensure_base                 = 'present'
  $ensure_cr                   = 'present'
  $ensure_extras               = 'present'
  $ensure_plus                 = 'present'
  $ensure_updates              = 'present'
  $ensure_source               = 'present'
  $ensure_debug                = 'present'

  case $releasever {
    '7': {
      $ensure_contrib          = 'absent'
      $ensure_scl              = 'absent'
      $mirrorlist_tail         = '&infra=$infra'
    }
    '6': {
      $ensure_contrib          = 'present'
      $ensure_scl              = 'present'
      $mirrorlist_tail         = '&infra=$infra'
    }
    '5': {
      $ensure_contrib          = 'present'
      $ensure_scl              = 'absent'
      $mirrorlist_tail         = ''
    }
    default: { }
  }
}

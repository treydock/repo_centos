# Default parameters in setting up CentOS Yum repository
class repo_centos::params {

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
  $enable_fasttrack            = false
  $enable_source               = false
  $enable_debug                = false
  $ensure_scl                  = 'absent'
  $ensure_source               = 'absent'

  case $::operatingsystemmajrelease {
    '7': {
      $support_contrib         = false
      $support_scl             = false
      $ensure_cr               = 'present'
      $mirrorlist_tail         = '&infra=$infra'
      $debuginfo_gpgkey        = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${::operatingsystemmajrelease}"
    }
    '6': {
      $support_contrib         = true
      $support_scl             = true
      $ensure_cr               = 'absent'
      $mirrorlist_tail         = '&infra=$infra'
      $debuginfo_gpgkey        = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-${::operatingsystemmajrelease}"
    }
    '5': {
      $support_contrib         = true
      $support_scl             = false
      $ensure_cr               = 'absent'
      $mirrorlist_tail         = ''
      $debuginfo_gpgkey        = "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::operatingsystemmajrelease}"
    }
    default: {
      $support_contrib         = undef
      $support_scl             = undef
      $ensure_cr               = undef
      $mirrorlist_tail         = undef
      $debuginfo_gpgkey        = undef
    }
  }
}

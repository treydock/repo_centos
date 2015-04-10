# See README.md for more details.
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
  $enable_fasttrack            = $repo_centos::params::enable_fasttrack,
  $enable_source               = $repo_centos::params::enable_source,
  $enable_debug                = $repo_centos::params::enable_debug,
  $ensure_cr                   = undef,
  $ensure_scl                  = undef,
  $ensure_source               = $repo_centos::params::ensure_source,
  $attempt_compatibility_mode  = false,
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
  validate_bool($enable_fasttrack)
  validate_bool($enable_source)
  validate_bool($enable_debug)

  if $ensure_cr {
    validate_re($ensure_cr, ['^present$', '^absent$'])
    $_ensure_cr = $ensure_cr
  } else {
    if $enable_cr {
      $_ensure_cr = 'present'
    } else {
      $_ensure_cr = $repo_centos::params::ensure_cr
    }
  }

  if $ensure_scl {
    validate_re($ensure_scl, ['^present$', '^absent$'])
    $_ensure_scl = $ensure_scl
  } else {
    if $enable_scl {
      $_ensure_scl = 'present'
    } else {
      $_ensure_scl = $repo_centos::params::ensure_scl
    }
  }

  validate_re($ensure_source, ['^present$', '^absent$'])

  validate_bool($attempt_compatibility_mode)

  if $::operatingsystem == 'CentOS' {
    if versioncmp($::puppetversion, '3.5.0') >= 0 {
      $support_ensure = true
    } else {
      $support_ensure = false
    }

    include repo_centos::base
    include repo_centos::contrib
    include repo_centos::cr
    include repo_centos::extras
    include repo_centos::plus
    include repo_centos::scl
    include repo_centos::updates
    include repo_centos::fasttrack
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
    Class['repo_centos::fasttrack']->
    Class['repo_centos::source']->
    Class['repo_centos::debug']->
    anchor { 'repo_centos::end': }->
    Package<| |>

    if $attempt_compatibility_mode {
      include repo_centos::compat::start
      Class['repo_centos::compat::start'] -> Anchor['repo_centos::start']
      stage { 'repo_centos::compat::end': }
      Stage['main'] -> Stage['repo_centos::compat::end']
      class { 'repo_centos::compat::end': stage => 'repo_centos::compat::end' }
    }
  } else {
      notice("Your operating system ${::operatingsystem} does not need CentOS repositories")
  }

}

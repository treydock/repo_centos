# Private class.
class repo_centos::debug {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_centos::enable_debug {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  augeas { 'centos-base-debuginfo':
    context => '/files/etc/yum.repos.d/CentOS-Debuginfo.repo/base-debuginfo',
    changes => [
      "set name 'CentOS-${::operatingsystemmajrelease} - Debuginfo'",
      "set baseurl '${repo_centos::debug_repourl}/${::operatingsystemmajrelease}/\$basearch/'",
      "set enabled ${enabled}",
      'set gpgcheck 1',
      "set gpgkey ${repo_centos::debuginfo_gpgkey}",
    ],
    lens    => 'Yum.lns',
    incl    => '/etc/yum.repos.d/CentOS-Debuginfo.repo',
  }

}

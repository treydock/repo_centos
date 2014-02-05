# Class repo_centos
#
# Actions:
#   Configure the proper repositories and import GPG keys
#
# Reqiures:
#   CentOS 5 or 6
#
# Sample Usage:
#  include repo_centos
#
class repo_centos (
  $enable_plus = false,
  $enable_cr = false,
  $enable_extras = false,
  $enable_scl = false,
) inherits repo_centos::params {

  if $::operatingsystem == 'CentOS' {
    include repo_centos::base
    include repo_centos::updates
    class { "repo_centos::cr":
      enable_cr       => $enable_cr,
    }
    class { "repo_centos::plus":
      enable_plus     => $enable_plus,
    }
    class { "repo_centos::extras":
      enable_extras   => $enable_extras,
    }
    class { "repo_centos::scl":
      enable_scl      => $enable_scl,
    }
    
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

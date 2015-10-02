# puppet-repo_centos

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/repo_centos.svg)](https://forge.puppetlabs.com/treydock/repo_centos)
[![Build Status](https://travis-ci.org/treydock/repo_centos.svg?branch=master)](https://travis-ci.org/treydock/repo_centos)

####Table of Contents

1. [Overview](#overview)
2. [Backwards Compatibility - 4.x](#backwards-compatibility)
3. [Usage - Configuration options](#usage)
4. [Reference - Parameter and detailed reference to all options](#reference)
5. [Development - Guide for contributing to the module](#development)

## Overview

This is a puppet module that manages the CentOS repositories on CentOS clients.

Originally based off of https://github.com/flakrat/repo_centos

Default states for each operating system of the repositories managed by this module:

| Repository            | CentOS 5      | CentOS 6      | CentOS 7      |
|:----------------------|:-------------:|:-------------:|:-------------:|
| base                  | enabled       | enabled       | enabled       |
| updates               | enabled       | enabled       | enabled       |
| extras                | enabled       | enabled       | enabled       |
| cr                    | absent        | absent        | disabled      |
| contrib               | disabled      | disabled      | not supported |
| fasttrack             | disabled      | disabled      | disabled      |
| plus                  | disabled      | disabled      | disabled      |
| debug                 | disabled      | disabled      | disabled      |
| scl                   | not supported | absent        | not supported |
| centos-base-source    | absent        | absent        | absent        |
| centos-updates-source | absent        | absent        | absent        |

## Backwards Compatibility

The `4.x` release of this module drastically changes the behavior of this module from previous releases.  The module now attempts to manage the repo files shipped with CentOS and as such extra steps must be taken to ensure a smooth transition from a release prior to `4.x`.  Two things must be done.

1) The original repo files must be re-installed.  Previous versions of this module removed the files.
2) This module applied with the `attempt_compatibility_mode` parameter set to `true`

Step #1 can not be done during the same Puppet run as #2.  Something like this can be done for #1:

```
exec { 'reinstall centos-release':
  path    => '/usr/bin:/bin:/usr/sbin:/sbin',
  command => 'yum -y reinstall centos-release || yum -y update centos-release',
  creates => '/etc/yum.repos.d/CentOS-Base.repo',
}
```

Tools like mcollective will allow for this exec to be applied to all systems before step #2 is performed.

## Usage

### Class: `repo_centos`

By default, the module configures the repo files to use http://mirror.centos.org/centos as the package source.

    class { 'repo_centos': }

A custom repository can be used by setting the `repourl` parameter and disabling the use of mirrorlist by setting `enable_mirrorlist` to `false`:

    class { 'repo_centos':
      repourl           => 'http://myrepo/centos',
      enable_mirrorlist => false,
    }

Alternate usage via hiera YAML:

    repo_centos::repourl: 'http://myrepo/centos'
    repo_centos::enable_mirrorlist: false

To enable SCL (**CentOS 6 only**)

    class { 'repo_centos':
      enable_scl => true,
    }

To install the SCL repo but leave it disabled (**CentOS 6 only**)

    class { 'repo_centos':
      ensure_scl => 'present',
    }

The same method of enable/ensure can be used with the CR repo via `enable_cr` and `ensure_cr`.

To install the CentOS base and updates source repos

    class { 'repo_centos':
      ensure_source => 'present',
    }

## Reference

### Classes

#### Public classes

* `repo_centos`: Configs all the managed CentOS yumrepo resources.

#### Private classes

* `repo_centos::base`: Configures base yumrepo.
* `repo_centos::contrib`: Configures contrib yumrepo.
* `repo_centos::cr`: Configures cr yumrepo.
* `repo_centos::debug`: Configures debug yumrepo.
* `repo_centos::extras`: Configures extras yumrepo.
* `repo_centos::fasttrack`: Configures fasttrack yumrepo.
* `repo_centos::params`: Defines default parameter values.
* `repo_centos::plus`: Configures centosplus yumrepo.
* `repo_centos::scl`: Configures scl yumrepo.
* `repo_centos::source`: Configures source yumrepos.
* `repo_centos::updates`: Configures updates yumrepo.
* `repo_centos::compat::start`: Removes yumrepo resources previously managed by this module
* `repo_centos::compat::end`: Removes the repo files previously managed by this module

### Parameters

#### repo_centos

#####`enable_mirrorlist`

Boolean to decide if the yumrepo mirrorlist or the baseurl are used (defaults to `true`).

#####`repourl`

The base repo URL.  Defaults to `http://mirror.centos.org/centos`.

#####`debug_repourl`

The base repo URL for centos-debug.  Defaults to `http://debuginfo.centos.org`

#####`source_repourl`

The base repo URL for source repos. Defaults to `http://vault.centos.org/centos`

#####`mirrorlisturl`

The mirrorlist URL.  Defaults to 'http://mirrorlist.centos.org'

#####`enable_base`

Boolean to decide if the CentOS Base Repo should be enabled (defaults to `true`).

#####`enable_contrib`

Boolean to decide if the CentOS User Contrib Repo should be enabled (defaults to `false`).

#####`enable_cr`

Boolean to decide if the CentOS Continuous Release Repo should be enabled (defaults to `false`).

#####`enable_extras`

Boolean to decide if the CentOS Extras Repo should be enabled (defaults to `true`).

#####`enable_plus`

Boolean to decide if the CentOS Plus Repo should be enabled (defaults to `false`).

#####`enable_scl`

Boolean to decide if the CentOS SCL Repo should be enabled (defaults to `false`).

This only affects to CentOS 6.

#####`enable_updates`

Boolean to decide if the CentOS Updates Repo should be enabled (defaults to `true`).

#####`enable_fasttrack`

Boolean to decide if the CentOS Fasttrack Repo should be enabled (defaults to `false`).

#####`enable_source`

Boolean to decide if the CentOS source repos should be enabled (defaults to `false`).

#####`enable_debug`

Boolean to decide if the CentOS debug repo should be enabled (defaults to `false`).

#####`ensure_cr`

Ensure parameter for the CR repo (defaults to `undef`).  By default only CentOS 7 has the CR repo present.

#####`ensure_scl`

Ensure parameter for the SCL repo (defaults to `undef`).  By default the repo is absent.

This only affects CentOS 6.

#####`ensure_source`

Ensure parameter for the source repos (defaults to `absent`).

#####`attempt_compatibility_mode`

Boolean to decide if compatibility classes should be included that are intended to help transition to version 4.x of this module (defaults to `false`).

## Development

### Testing

Make sure you have:

* rake
* bundler

Install the necessary gems:

    bundle install

Run the tests from root of the source code:

    bundle exec rake test

You can also run acceptance tests:

    bundle exec rake beaker

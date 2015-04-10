# puppet-repo_centos

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/repo_centos.svg)](https://forge.puppetlabs.com/treydock/repo_centos)
[![Build Status](https://travis-ci.org/treydock/repo_centos.svg?branch=master)](https://travis-ci.org/treydock/repo_centos)

####Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Development - Guide for contributing to the module](#development)

## Overview

This is a puppet module that manages the CentOS repositories on CentOS clients.

Originally based off of https://github.com/flakrat/repo_centos

**NOTE**: The current behavior of this module is to remove the repo files shipped with CentOS and to define all CentOS repos using names that differ from the stock operating system.  The `4.x` release will remove this behavior.

## Usage

### Class: `repo_centos`

By default, the module configures the repo files to use http://mirror.centos.org/centos as the package source.

    class { 'repo_centos': }

A custom repository can be used by setting the `repourl` parameter and disabling the use of mirrorlist by setting `enable_mirrorlist` to `false` (also demonstrates how to enable the SCL repo):

    class { 'repo_centos':
      repourl           => 'http://myrepo/centos',
      enable_mirrorlist => false,
      enable_scl        => true,
    }

Alternate usage via hiera YAML:

    repo_centos::repourl: 'http://myrepo/centos'
    repo_centos::enable_mirrorlist: false
    repo_centos::enable_scl: true

The following Repos will be setup and enabled by default:

  * centos-base
  * centos-extras
  * centos-updates

Other repositories that will setup but disabled

  * centos-contrib **CentOS 5 and CentOS 6 only**
  * centos-cr
  * centos-fasttrack
  * centos-plus
  * centos-scl **CentOS 6 only**
  * centos-base-source
  * centos-updates-source
  * centos-debug


## Reference

### Classes

#### Public classes

* `repo_centos`: Configs all the managed CentOS yumrepo resources.

#### Private classes

* `repo_centos::base`: Configures base yumrepo.
* `repo_centos::clean`: Removes the stock yum repo files.
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

This only affects to CentOS 6 clients.

#####`enable_updates`

Boolean to decide if the CentOS Updates Repo should be enabled (defaults to `true`).

#####`enable_fasttrack`

Boolean to decide if the CentOS Fasttrack Repo should be enabled (defaults to `false`).

#####`enable_source`

Boolean to decide if the CentOS source repos should be enabled (defaults to `false`).

#####`enable_debug`

Boolean to decide if the CentOS debug repo should be enabled (defaults to `false`).

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

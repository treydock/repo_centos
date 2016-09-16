## treydock-repo_centos changelog

Release notes for the treydock-repo_centos module.

#### 4.0.0 - 2016/09/16

This release is a major refactor of this module to use the repo files shipped with CentOS.

* Rename all yumrepo resources (except source repos) to match the names used by CentOS
* Do not remove yum repo files that are installed by the OS packages
* Remove management of CentOS GPG keys
* The source repos are no longer present by default
* The SCL repo on CentOS 6 is no longer present by default
* The CR repo is only present by default for CentOS 7
* Remove 'ensure' parameters for all repos except cr, scl and source
* Do not set 'enable' parameters for base, extras and updates if they are enabled (maintain CentOS defaults)
* Use augeas to define all repos
* Use stages to ensure CentOS repositories come before other resources
* Module requires presence of operatingsystemmajrelease fact
* Add compat classes to attempt a "smooth" upgrade from 3.x to 4.x of this module

------------------------------------------

#### 3.0.2 - 2015/12/17

* Fix gpgkey used for debug repositories on CentOS 5

------------------------------------------

#### 3.0.1 - 2015/04/10

* Add treydock/gpg_key module dependency back as it was accidentally removed

------------------------------------------

#### 3.0.0 - 2015/04/10

This release is the first under new author that contains backwards incompatible changes.

Backwards incompatible changes:

* By default mirrorlist is now set for repos but can be overridden using `enable_mirrorlist` parameter.  Default mirrorlist values are that of stock CentOS repo files shipped with the operating system

Features:

* Manage fasttrack repo
* Manage source repos
* Manage debuginfo repo
* Remove management of the contents for CentOS GPG keys
* Updates to development dependencies, rake tasks and travis-ci test coverage

------------------------------------------

#### 2.0.0 - 2014/04/01

This major release

Detailed Changes:

* Use the Anchor pattern to order the classes so existing repo files are removed before new repos added.
* Use Package resource collector to ensure this module runs before any managed Package resources
* Add dependency treydock-gpg_key to manage GPG keys replacing the repo_centos::rpm_gpg_key defined type
* Remove CentOS-Vault.repo and CentOS-SCL.repo files
* Add newline to GPG keys so they aren't unnecessarily replaced
* Remove os_maj_version fact in favor of using external facts in the following order:
  * facter's operatingsystemmajrelease
  * another module's os_maj_version
  * inline template parsing facter's operatingsystemrelease fact
* Cleanup code to pass puppet-lint tests (proper variable scopes, spacing ,etc)
* Add rspec-puppet unit testing
* Add beaker-rspec system tests
  * NOTE: The `should_not` matchers do not work despite the module correctly disabling yumrepo resources and removing repo files.

------------------------------------------

#### New in 0.1.0 - 2013/02/06

Initial release.

This module is based on the following puppetlabs module: http://github.com/stahnma/puppet-module-puppetlabs_yum

require 'spec_helper_acceptance'

describe 'repo_centos class' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        package { 'httpd': ensure => present }
        class { 'repo_centos': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    it_behaves_like 'repo_centos-default'
  end
end

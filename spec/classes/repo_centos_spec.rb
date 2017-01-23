require 'spec_helper'

describe 'repo_centos' do
  on_supported_os.each do |os, default_facts|
    context "on #{os}" do
      let(:facts) do
        default_facts.merge({
          :puppetversion => PUPPET_VERSION,
        })
      end
      if default_facts[:operatingsystemmajrelease] == '5'
        let(:mirrorlist_tail) { '' }
      else
        let(:mirrorlist_tail) { '&infra=$infra' }
      end
      let(:pre_condition) { "package { 'httpd': ensure => present }" }

      it { should contain_package('httpd').with_ensure('present') }

      it { should create_class('repo_centos') }
      it { should contain_class('repo_centos::params') }

      it { should contain_stage('repo_centos').that_comes_before('Stage[main]') }
      it { should contain_class('repo_centos::base').with_stage('repo_centos') }
      it { should contain_class('repo_centos::contrib').with_stage('repo_centos') }
      it { should contain_class('repo_centos::cr').with_stage('repo_centos') }
      it { should contain_class('repo_centos::extras').with_stage('repo_centos') }
      it { should contain_class('repo_centos::plus').with_stage('repo_centos') }
      it { should contain_class('repo_centos::scl').with_stage('repo_centos') }
      it { should contain_class('repo_centos::updates').with_stage('repo_centos') }
      it { should contain_class('repo_centos::fasttrack').with_stage('repo_centos') }
      it { should contain_class('repo_centos::source').with_stage('repo_centos') }
      it { should contain_class('repo_centos::debug').with_stage('repo_centos') }

      it { should_not contain_class('repo_centos::compat::start') }
      it { should_not contain_class('repo_centos::compat::end') }

      context 'when attempt_compatibility_mode => true' do
        let(:params) {{ :attempt_compatibility_mode => true }}
        it { should contain_stage('repo_centos::compat::start').with_before('Stage[repo_centos]') }
        it { should contain_stage('repo_centos::compat::end') }
        it { should contain_stage('main').that_comes_before('Stage[repo_centos::compat::end]') }
        it { should contain_class('repo_centos::compat::start').with_stage('repo_centos::compat::start') }
        it { should contain_class('repo_centos::compat::end').with_stage('repo_centos::compat::end') }
        it_behaves_like 'repo_centos::compat::start'
        it_behaves_like 'repo_centos::compat::end'
      end

      #it_behaves_like 'repo_centos::clean', default_facts
      it_behaves_like 'repo_centos::base', default_facts
      it_behaves_like 'repo_centos::contrib', default_facts
      it_behaves_like 'repo_centos::cr', default_facts
      it_behaves_like 'repo_centos::extras', default_facts
      it_behaves_like 'repo_centos::plus', default_facts
      it_behaves_like 'repo_centos::scl', default_facts
      it_behaves_like 'repo_centos::updates', default_facts
      it_behaves_like 'repo_centos::fasttrack', default_facts
      it_behaves_like 'repo_centos::debug', default_facts
      it_behaves_like 'repo_centos::source', default_facts
    end
  end

  context 'when operatingsystem => "Fedora"' do
    let :facts do
      {
        :operatingsystem           => 'Fedora',
        :os_maj_version            => '20',
        :operatingsystemmajrelease => '20',
        :architecture              => 'x86_64',
      }
    end

    it { should have_class_count(2) }

    it { should_not contain_class('repo_centos::base') }
    it { should_not contain_class('repo_centos::contrib') }
    it { should_not contain_class('repo_centos::cr') }
    it { should_not contain_class('repo_centos::extras') }
    it { should_not contain_class('repo_centos::plus') }
    it { should_not contain_class('repo_centos::scl') }
    it { should_not contain_class('repo_centos::updates') }
    it { should_not contain_class('repo_centos::fasttrack') }
    it { should_not contain_class('repo_centos::source') }
    it { should_not contain_class('repo_centos::debug') }
  end
end

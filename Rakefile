require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

task :default do
  sh %{rake -T}
end

desc "Run syntax, lint and spec tasks."
task :test => [:syntax, :lint, :spec]

desc 'Run beaker compatibility acceptance tests'
RSpec::Core::RakeTask.new(:beaker_compat) do |t|
  t.rspec_opts = ['--color']
  t.pattern = 'spec/acceptance_compat'
end

exclude_paths = [
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
]

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.ignore_paths = exclude_paths
  config.fail_on_warnings = true
  config.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
  config.disable_checks = ["140chars", "class_inherits_from_params_class"]
  #config.relative = true
end
PuppetLint.configuration.relative = true

PuppetSyntax.exclude_paths = exclude_paths

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -I lib -r mla_active_duty_status.rb'
end

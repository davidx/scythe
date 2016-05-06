require "bundler/gem_tasks"


task :default => [:test]

task :build do
  ruby '-S gem build scythe.gemspec'
end
task :deploy do
  ruby '-S gem install scythe'

end
task :install => [:build, :deploy]

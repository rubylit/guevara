require "bundler/gem_tasks"

task :test do
  exec "cutest -r ./test/helper.rb ./test/test_*.rb"
end

task :default => :test

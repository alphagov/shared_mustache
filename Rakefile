require "gem_publisher"

desc "Publish gem to RubyGems.org"
task :publish_gem do |t|
  gem = GemPublisher.publish_if_updated("shared_mustache.gemspec", :rubygems)
  puts "Published #{gem}" if gem
end

task :test do |t|
  true
end

task :default => :test

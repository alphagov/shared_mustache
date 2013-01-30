require 'shared_mustache/config'
require 'shared_mustache/hogan'

namespace :shared_mustache do
  desc 'Compiles all mustache templates down for production use'
  task :compile do
    file_list = SharedMustache.file_list

    javascript = []
    javascript << 'window.templates = {};'

    file_list.each do |file|
      template_id = SharedMustache.file_name_to_id(file)
      compiled_template = SharedMustache::Hogan.compile(File.read(file))
      javascript << "window.templates['#{template_id}'] = new Hogan.Template(#{compiled_template});"
    end

    File.open(SharedMustache::Config.template_file, 'w') { |f| f.write javascript.join("\n") }
  end

  desc 'Cleans up the mustache template file used in production'
  task :clean do
    File.open(SharedMustache::Config.template_file, 'w') {}
  end
end

require 'shared_mustache/config'
require 'shared_mustache/engine'
require 'shared_mustache/railtie' if defined?(Rails)
require 'shared_mustache/version'

module SharedMustache
  def self.view_dir
    File.join(Rails.root, 'app', 'views')
  end

  def self.file_list
    Dir[File.join(view_dir, '**', '*.mustache')].sort
  end

  def self.file_name_to_id(filename)
    filename.gsub('.mustache', '').gsub("#{view_dir}/", '')
  end

  def self.find_template_path(filename, controller)
    directory = File.dirname(filename)
    if directory == '.'
      directory = controller
    end
    File.join(directory, "_#{File.basename(filename)}")
  end
end

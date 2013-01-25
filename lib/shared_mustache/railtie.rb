require 'shared_mustache/view_helpers'

module SharedMustache
  class Railtie < Rails::Railtie
    initializer "shared_mustache.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
    rake_tasks do
      Dir[File.expand_path('../tasks/*.rake', File.dirname(__FILE__))].each { |f| load f }
    end
  end
end

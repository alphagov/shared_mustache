require 'shared_mustache/view_helpers'

module SharedMustache
  class Railtie < Rails::Railtie
    initializer "shared_mustache.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
    initializer "shared_mustache.assets.precompile" do |app|
      app.config.assets.precompile += %w(
        hogan-2.0.0-hotfix.js
      )
    end
    rake_tasks do
      load 'tasks/shared_mustache.rake'
    end
  end
end

module SharedMustache
  # Change config options in an initializer:
  #
  # SharedMustache::Config.template_file = 'app/assets/javascriopt/mustache_templates.js'
  #
  module Config
    extend self
    
    attr_writer :template_file

    def template_file
      @template_file ||= File.join(Rails.root, 'app', 'assets', 'javascripts', 'templates.js')
    end
  end
end

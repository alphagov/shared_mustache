require 'mustache'

module SharedMustache
  module ViewHelpers
    def render_mustache_templates
      file_list = SharedMustache.file_list

      script_tags = file_list.map do |file|
        content_tag(:script, File.read(file), id: SharedMustache.file_name_to_id(file), type: 'text/mustache')
      end
      script_tags << javascript_include_tag("hogan-2.0.0.js")
      script_tags.join('').html_safe
    end

    def render_mustache(template, options={})
      view = Mustache.new
      view.template = File.read(SharedMustache.find_template_path(template, params[:controller]))
      view.render(options)
    end
  end
end

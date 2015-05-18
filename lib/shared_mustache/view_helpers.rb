require 'shared_mustache/mustache_view'

module SharedMustache
  module ViewHelpers
    def render_mustache_templates
      file_list = SharedMustache.file_list

      script_tags = file_list.map do |file|
        content_tag(:script, File.read(file), id: SharedMustache.file_name_to_id(file), type: 'text/mustache')
      end
      script_tags << javascript_include_tag("hogan-2.0.0-hotfix.js")
      script_tags.join('').html_safe
    end

    def render_mustache(template, options={})
      view = MustacheView.new
      view.template_name = SharedMustache.find_template_path(template, params[:controller])
      view.template_path = SharedMustache.view_dir
      view.render(options).html_safe
    end
  end
end

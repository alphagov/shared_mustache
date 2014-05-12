require 'mustache'

class MustacheView < Mustache
  def partial(name)
    File.read("#{template_path}/#{name}.#{template_extension}")
  end
end

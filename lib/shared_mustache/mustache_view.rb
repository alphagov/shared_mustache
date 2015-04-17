require 'mustache'

class MustacheView < Mustache

  def initialize
    super
    @partial_cache = {}
  end

  def partial(name)
    @partial_cache[name] ||= File.read("#{template_path}/#{name}.#{template_extension}")
  end
end

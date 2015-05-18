require 'execjs'

module SharedMustache
  module Hogan
    def self.compile(source)
      context.eval("(typeof exports !== 'undefined' ? exports : Hogan).compile(#{source.inspect}, {asString: true})")
    end

    private

    def self.context
      @context ||= ExecJS.compile(hogan_source)
    end

    def self.hogan_source
      hogan_path = File.expand_path('../../vendor/assets/javascripts/hogan-2.0.0-hotfix.js', File.dirname(__FILE__))
      File.read(hogan_path)
    end
  end
end

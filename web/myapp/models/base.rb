require "bundler/setup"

module Models
  class Base
    def self.attr_accessor(*attrs)
      @@attributes ||= attrs
      super
    end
  end
end

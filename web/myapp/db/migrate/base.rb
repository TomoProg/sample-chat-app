require "bundler/setup"
require_relative "../../common/db_accessor"

module Migrate
  class Base
    def initialize
      @db_name = ENV["DB_NAME"]
      @db_accessor = Common::DBAccessor.new
    end

    def up
      raise NotImplementedError
    end

    def down
      raise NotImplementedError
    end
  end
end
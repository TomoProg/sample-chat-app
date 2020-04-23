require "bundler/setup"
require "../common/db_accessor"
require "pry"

module Models
  class User
    class << self
      def properties
        [
          :id,
          :email,
          :password,
          :name,
          :created_at,
          :updated_at
        ]
      end
    end

    attr_accessor *properties

    def initialize(**kwargs)
      kwargs.each do |k, v|
        eval <<~TEXT
          @#{k} = v
        TEXT
      end
    end

    def create
      columns = filled_properties.keys
      values = filled_properties.values.map do |v|
        if v.is_a?(String)
          "'#{v}'"
        elsif v.is_a?(Time)
          "'#{v.strftime("%Y-%m-%d %H:%M:%S")}'"
        else
          v
        end
      end

      accessor = Common::DBAccessor.new
      sql = <<~SQL
        INSERT INTO #{ENV["DB_NAME"]}.users (
          #{columns.join(",")}
        ) VALUES (
          #{values.join(",")}
        )
      SQL
      accessor.execute sql
    end

    def save
    end

    private
    def filled_properties
      self.class.properties.inject({}) do |result, p|
        eval <<~TEXT
          result[:#{p}] = @#{p} if @#{p}
        TEXT
        result
      end
    end

  end
end

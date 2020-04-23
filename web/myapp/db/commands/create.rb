require "bundler/setup"
require_relative "../../common/db_accessor"

module Commands
  class Create
    def initialize
      @db_name = ENV["DB_NAME"]
    end

    def execute
      accessor = Common::DBAccessor.new

      # DB作成
      accessor.execute <<~SQL
        CREATE DATABASE IF NOT EXISTS #{@db_name}
      SQL

      # マイグレーションテーブル作成
      accessor.execute <<~SQL
        CREATE TABLE IF NOT EXISTS #{@db_name}.migrations
        (
          version CHAR(14) NOT NULL,
          PRIMARY KEY (version)
        )
      SQL

      <<~MSG
        Database created.
        Name:[#{@db_name}]
      MSG
    end
  end
end

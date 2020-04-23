require "bundler/setup"
require_relative "./base"

module Migrate
  class CreateUsersTable < Base
    def up
      @db_accessor.execute(<<~SQL
        CREATE TABLE #{@db_name}.users
        (
          id INT NOT NULL AUTO_INCREMENT,
          name VARCHAR(20),
          PRIMARY KEY (id)
        )
        SQL
      )
    end
    
    def down
      @db_accessor.execute(<<~SQL
        DROP TABLE #{@db_name}.users
        SQL
      )
    end
  end
end
require "bundler/setup"
require_relative "./base"

module Migrate
  class CreateUsersTable < Base
    def up
      @db_accessor.execute(<<~SQL
        CREATE TABLE #{@db_name}.users
        (
          id INT NOT NULL AUTO_INCREMENT,
          email VARCHAR(200) NOT NULL,
          password VARCHAR(20) NOT NULL,
          name VARCHAR(20) NOT NULL,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
          PRIMARY KEY (id),
          UNIQUE (email)
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
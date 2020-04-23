require "bundler/setup"
require_relative "./base"

module Migrate
  class CreateSampleTable < Base
    def up
      @db_accessor.execute(<<~SQL
        CREATE TABLE #{@db_name}.sample
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
        DROP TABLE #{@db_name}.sample
        SQL
      )
    end
  end
end
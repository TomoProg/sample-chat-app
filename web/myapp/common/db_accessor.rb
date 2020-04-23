require "bundler/setup"
require "mysql2"

module Common
  class DBAccessor
    attr_reader :host, :username, :password
    def initialize(**kwargs)
      @host = kwargs[:host] || ENV["DB_HOST"]
      @username = kwargs[:username] || ENV["DB_USER"]
      @password = kwargs[:password] || ENV["DB_PASS"]
      @client = Mysql2::Client.new(host: host, username: username, password: password)
    end

    def execute(sql)
      @client.query(sql)
    end
  end
end

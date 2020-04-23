require "bundler/setup"
require "mysql2"
require_relative "./create"
require_relative "./up"
require_relative "./down"

module Commands
  class Factory
    def self.create(command_name, *args)
      case command_name
        when "create"
          Commands::Create.new
        when "up"
          steps = args.empty? ? -1 : Integer(args[0])
          Commands::Up.new(steps)
        when "down"
          steps = args.empty? ? 1 : Integer(args[0])
          Commands::Down.new(steps)
        else
          nil
      end
    end
  end
end

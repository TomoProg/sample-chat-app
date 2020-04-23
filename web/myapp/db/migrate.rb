require "bundler/setup"
require_relative "commands/factory"

def usage
  <<~STR
  Usage: 
      migrate.rb create [database_name]
      migrate.rb up [steps]
      migrate.rb down [steps]
  STR
end

def main
  if ARGV.length < 1
    puts "invalid parameters ..."
    puts usage
    return
  end

  command = Commands::Factory.create(ARGV[0], *ARGV[1..])
  if !command
    puts "invalid command ..."
    puts usage
    return
  end

  puts command.execute
end

main
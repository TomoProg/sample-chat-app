require "bundler/setup"

module Commands
  module Util
    def migration_file_names
      Dir.each_child(migration_file_dir_path)
        .filter {|f| f != "base.rb"}
    end

    def migration_file_dir_path
      "#{File.dirname(__FILE__)}/../migrate"
    end

    def version_to_time(version)
      year = version[0..3].to_i
      month = version[4..5].to_i
      day = version[6..7].to_i
      hour = version[8..9].to_i
      min = version[10..11].to_i
      sec = version[12..13].to_i 
      Time.new(year, month, day, hour, min, sec)
    end
  end
end

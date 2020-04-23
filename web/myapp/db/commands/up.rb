require "bundler/setup"
require_relative "../../common/db_accessor"
require_relative "./util"

module Commands
  class Up
    include Commands::Util

    def initialize(steps)
      @steps = steps
    end

    def execute
      accessor = Common::DBAccessor.new
      rows = accessor.execute <<~SQL
        SELECT version FROM #{ENV["DB_NAME"]}.migrations ORDER BY version DESC
      SQL

      targets = migration_file_names
      if rows.count > 0
        latest_version = rows.first["version"]
        time = version_to_time(latest_version)
        targets.filter! { |f| f >= (time + 1).strftime("%Y%m%d%H%M%S") }
      end
      targets.sort!
      targets = targets[0...@steps] if @steps > 0

      return "Already migrated." if targets.empty?

      targets.each do |target|
        require_relative "#{migration_file_dir_path}/#{target}"
        version = target.split("_")[0]
        class_name = File.basename(target.split("_")[1..].map(&:capitalize).join(""), ".rb")
        eval("Migrate::#{class_name}.new.up")
        accessor.execute <<~SQL
          INSERT INTO #{ENV["DB_NAME"]}.migrations VALUES (#{version})
        SQL
      end

      <<~MSG
        Success!!
        -----
        #{targets.join("\n")}
      MSG
    end
  end
end

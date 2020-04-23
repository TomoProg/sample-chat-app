require "bundler/setup"
require_relative "../../common/db_accessor"
require_relative "./util"

module Commands
  class Down
    include Commands::Util

    def initialize(steps)
      @steps = steps
    end

    def execute
      accessor = Common::DBAccessor.new
      rows = accessor.execute <<~SQL
        SELECT version FROM #{ENV["DB_NAME"]}.migrations ORDER BY version DESC
      SQL

      return "Can't rollback any more." if rows.count < 1

      versions = rows.map { |row| row["version"] }[0...@steps]
      file_names = versions.map do |version|
        file_path = Dir.glob("#{migration_file_dir_path}/#{version}*").first
        class_name = File.basename(file_path, ".rb").split("_")[1..].map(&:capitalize).join("")
        require_relative file_path
        eval("Migrate::#{class_name}.new.down")
        accessor.execute <<~SQL
          DELETE FROM #{ENV["DB_NAME"]}.migrations WHERE version = #{version}
        SQL
        File.basename(file_path)
      end

      <<~MSG
        Success!!
        -----
        #{file_names.join("\n")}
      MSG
    end
  end
end
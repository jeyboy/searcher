class Dumper
  require 'yaml'

  class << self
    #def model(table_name)
    #  @links ||= ActiveRecord::Base.descendants.each_with_object({}){|c, ret| ret.update(c.table_name => c.name)}
    #  @links[table_name]
    #end

    def dump(connections, include_schema = false)
      file = File.open(file_path, 'w')

      if connections.is_a? Array
        connections.each {|connection| dump_connection(connection, file, include_schema) }
      else
        dump_connection(connections, file, include_schema)
      end

      file.close
    end

    def restore(path = nil)
      YAML.load_stream(open(path || file_path)).each do |document|
        ActiveRecord::Base.transaction {
          table = document.first.first
          hashes = document.first.last
          hashes.each do |hash|
            ActiveRecord::Base.connection.execute(
                "INSERT INTO '#{table}' (\"#{hash.keys.join('","')}\") VALUES (\"#{hash.values.join('","')}\")"
            )
          end
        }
      end
    end

    def file_path
      Rails.root.join('public', 'dump.yml')
    end

    protected
      def dump_connection(connection, file, include_schema)
        connection.tables.each do |table|
          if table != 'schema_migrations' || (table == 'schema_migrations' && include_schema)
            dump_table(connection, table, file)
          end
        end
      end

      def dump_table(connection, table, file, offset = 100)
        count = connection.execute(count_request(table)).to_a.first.first.last.to_i
        iter = - offset

        while iter < count
          res = connection.execute(request(table, iter += offset, offset))
          if res.present?
            file << {table => res.to_a}.to_yaml
            sleep(1)
          end
        end
      end

      def count_request(table)
        "SELECT COUNT(*) FROM #{table}"
      end

      def request(table, offset, limit)
        "SELECT * FROM #{table} LIMIT #{limit} OFFSET #{offset}"
      end
  end
end
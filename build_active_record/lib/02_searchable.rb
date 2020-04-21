require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_str = params.keys.map {|attr| "#{attr} = ?"}.join(' AND ')
    
    data = DBConnection.execute(<<-SQL, params.values)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        #{where_str}
    SQL
    
    self.parse_all(data)
  end
end

class SQLObject
  extend Searchable
  # Mixin Searchable here...
end

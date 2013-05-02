require 'active_record'
ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => ':memory:')

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:people      ) {|t| t.string :name}
    create_table(:entries     ) {|t| t.integer :person_id; t.string :name }
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up


class Person < ActiveRecord::Base
  has_many :entries
end

class Entry < ActiveRecord::Base
  belongs_to :person
end

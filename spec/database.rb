require 'active_record'
require 'cymbalize'

# Include Cymbalize manually, since Railtie hook won't fire.
ActiveRecord::Base.send(:include, Cymbalize)

# Create our database.
ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
    t.string :gender
    t.string :status
    t.string :mood

    t.timestamps
  end
end

def create_user_class
  Class.new(ActiveRecord::Base) do

    def self.name
      'User'
    end

    self.table_name = 'users'
  end
end

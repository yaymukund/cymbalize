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

class User < ActiveRecord::Base
  symbolize :name, :gender, :status, :mood
end

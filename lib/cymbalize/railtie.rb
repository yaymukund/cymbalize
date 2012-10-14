require 'cymbalize'

module Cymbalize
  require 'rails'

  class Railtie < Rails::Railtie
    initializer 'cymbalize.insert_into_active_record' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:include, Cymbalize)
      end
    end
  end
end

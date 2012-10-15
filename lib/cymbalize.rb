require 'cymbalize/railtie'
require 'active_support/concern'

module Cymbalize
  extend ActiveSupport::Concern

  module ClassMethods
    @@symbolized_options = {}

    def symbolize(*attribute_names)
      options = attribute_names.extract_options!

      attribute_names.each do |attribute_name|
        symbolize_attribute(attribute_name, options)
      end
    end

    def symbolize_attribute(attribute_name, options)
      define_method attribute_name do
        read_symbolized_attribute(attribute_name)
      end

      if options[:in].present?
        validates_inclusion_of attribute_name,
                               :in => options[:in],
                               :allow_blank => !!options[:allow_blank]

        @@symbolized_options[attribute_name] = options[:in]

        if !!options[:methods]
          options[:in].each do |valid_type|
            define_method "#{valid_type}?" do
              read_symbolized_attribute(attribute_name) == valid_type
            end
          end
        end

        if !!options[:scopes]
          options[:in].each do |valid_type|
            scope valid_type, where(attribute_name => valid_type)
          end
        end
      end
    end

    def options_for(attribute_name)
      @@symbolized_options[attribute_name]
    end
  end

  def read_symbolized_attribute(attribute_name)
    value = read_attribute(attribute_name)

    if value.present?
      value.to_sym
    else
      nil
    end
  end
end

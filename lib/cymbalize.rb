require 'cymbalize/railtie'
require 'active_support/concern'

module Cymbalize
  extend ActiveSupport::Concern

  module ClassMethods
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
                               :allow_nil => !!options[:allow_nil],
                               :allow_blank => !!options[:allow_blank]
      end
    end
  end

  def read_symbolized_attribute(attr)
    read_attribute(attr).try(:to_sym)
  end
end

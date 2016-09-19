require 'active_model'
require 'virtus'

module CommonService
  class FormObject
    include ActiveModel::Validations
    include Virtus.model

    def initialize(attributes)
      @raw_attributes = attributes.to_h.symbolize_keys!
      super
    end

    def attributes
      # compact attributes with nil value unless attribute was provided at instantiation
      super.select do |attr, value|
        value != nil ||  @raw_attributes.keys.include?(attr)
      end
    end

    def to_h
      attributes
    end

    def validate!
      raise ErrorObject.new(errors.messages) unless valid?
    end

    private
    attr_reader :raw_attributes
  end
end

module CommonService
  class ErrorObject < ArgumentError
    def initialize(attribute_errors)
      assert_arguments!(attribute_errors)
      @attribute_errors = attribute_errors
      super message
    end

    def message
      @message ||= attribute_errors.flat_map do |attribute, errors|
        [*errors].map { |e| "#{attribute} #{e}" }
      end.join(', ')
    end

    def to_h
      attribute_errors
    end

    private
    attr_reader :attribute_errors

    def assert_arguments!(arguments)
      unless arguments.is_a?(Hash) &&  arguments.values.all? { |errs| errs.is_a?(Array) }
        raise ArgumentError, 'errors must be a hash of arrays'
      end
    end
  end
end
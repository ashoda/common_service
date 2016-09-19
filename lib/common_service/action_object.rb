module CommonService
  class ActionObject
    def initialize(attributes = {})
      @form_object = self.class.form.new(attributes)
    end

    def result
      raise NotImplementedError
    end

    def meta
      raise NotImplementedError
    end

    def call
      raise NotImplementedError
    end

    class << self
      def call(*args)
        new(*args).tap(&:call)
      end

      def form(&block)
        @form_class ||= begin
          const_set('Form', Class.new(FormObject::Base))
        end
        @form_class.class_eval(&block) if block_given?
        @form_class
      end

      def form=(form_klass)
        @form_class = const_set('Form', Class.new(form_klass))
      end
    end

    private
    attr_reader :form_object, :options
  end
end
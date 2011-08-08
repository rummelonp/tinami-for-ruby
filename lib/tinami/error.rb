module TINAMI
  # Custom error class for rescuing from all TINAMI errors
  class Error < StandardError
    attr_reader :response

    def initialize(msg, response = nil)
      super(msg)
      @response = response
    end
  end
end

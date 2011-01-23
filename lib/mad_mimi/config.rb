module MadMimi #:nodoc
  class Config #:nodoc
    include Singleton
    attr_accessor :username, :api_key

    def initialize;end
  end
end
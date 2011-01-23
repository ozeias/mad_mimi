require "singleton"

require "mad_mimi/audience"
require "mad_mimi/config"

module MadMimi #:nodoc
  class << self
    # Sets the MadMimi configuration options. Best used by passing a block.
    #
    # Example:
    #
    #   MadMimi.configure do |config|
    #     config.username = "emailaddress"
    #     config.api_key  = "api_key"
    #   end
    #
    # Returns:
    #
    # The MadMimi +Config+ singleton instance.
    def configure
      config = MadMimi::Config.instance
      block_given? ? yield(config) : config
    end
    alias :config :configure

    # Authentication hash
    #
    # return [Hash]
    def authentication
      {
        :username => configure.username,
        :api_key => configure.api_key
      }
    end

    def api_url
      'http://api.madmimi.com'
    end

    def audience
      MadMimi::Audience.new
    end
  end
end
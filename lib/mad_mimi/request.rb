require 'faraday'
require 'faraday_middleware'

module MadMimi
  # Defines HTTP request methods
  module Request
    def get(path, options={}, raw = false)
      request(:get, path, options, raw)
    end

    def post(path, options={}, raw = false, ssl = false)
      request(:post, path, options, raw, ssl)
    end

    private
      def request(method, path, options, raw = false, ssl = false)
        response = connection(raw, ssl).send(method) do |request|
          options = options.merge(MadMimi.authentication)
          case method
          when :get
            request.url(path, options)
          when :post
            request.path = path
            request.body = options unless options.empty?
          end
        end
        raw ? response : response.body
      end

      def connection(raw = false, ssl = false)
        options = {
          :headers => {'Accept' => "application/xml", 'User-Agent' => 'MadMimi Gem'},
          :ssl => { :verify => false },
          :url => MadMimi.api_url(ssl)
        }

        Faraday::Connection.new(options) do |builder|
          builder.adapter Faraday.default_adapter
          unless raw
            builder.use Faraday::Response::ParseXml
          end
        end
      end
  end
end
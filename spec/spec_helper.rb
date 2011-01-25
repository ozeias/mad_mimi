require File.expand_path('../../lib/mad_mimi', __FILE__)

require 'rspec'
require 'webmock/rspec'
include WebMock::API

def a_post(path)
  a_request(:post, MadMimi.api_url + path)
end

def stub_get(path, options = {})
  path = path + '?' + parameterize(options.merge(MadMimi.authentication))
  stub_request(:get, MadMimi.api_url + path)
end

def stub_post(path)
  stub_request(:post, MadMimi.api_url + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def parameterize(params)
  URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))
end
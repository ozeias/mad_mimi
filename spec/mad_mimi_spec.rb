require 'spec/spec_helper'

describe MadMimi do
  describe ".configure" do
    ['username', 'api_key'].each do |key|
      it "should set the #{key}" do
        MadMimi.configure do |config|
          config.send("#{key}=", key)
          MadMimi.configure.send(key).should == key
        end
      end
    end
  end

  describe ".authentication" do
    before do
      MadMimi.configure do |config|
        config.username = "email@example.com"
        config.api_key  = "api_key"
      end
    end

    it "should return the authentication hash" do
      MadMimi.authentication.should == { :api_key => "api_key", :username => "email@example.com" }
    end
  end

  describe ".api_url" do
    it "should return the default api_url" do
      MadMimi.api_url.should == 'http://api.madmimi.com'
    end
  end

  describe ".audience" do
    it "should be a MadMimi::Audience" do
      MadMimi.audience.should be_a MadMimi::Audience
    end
  end
end
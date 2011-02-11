require 'spec/spec_helper'

describe MadMimi::Mailer do
  before (:all) do
    MadMimi.configure do |config|
      config.username = "email@example.com"
      config.api_key  = "api_key"
    end
  end

  describe ".mail" do
    before do
      stub_post('/mailer', true).
        with(:headers => {'Accept'=>'application/xml', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => "2875078090", :headers => {:content_type => "text/html; charset=utf-8"})
    end

    it "should remove audience list membership" do
      MadMimi.mailer.mail({ :promotion_name => "Welcome to Acme Widgets", :recipients => "Ozéias Sant'Ana <oz.santana@gmail.com>" })

      a_post('/mailer', true).
        with(:body => 'username=email%40example.com&promotion_name=Welcome+to+Acme+Widgets&recipients=Oz%C3%A9ias+Sant%27Ana+%3Coz.santana%40gmail.com%3E&api_key=api_key&check_suppressed=true').
        with(:headers => {'Accept'=>'application/xml', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'MadMimi Gem'}).
        should have_been_made
    end
  end
end
require 'spec/spec_helper'

describe MadMimi::Audience do
  before (:all) do
    MadMimi.configure do |config|
      config.username = "email@example.com"
      config.api_key  = "api_key"
    end
  end

  it "should connect using the api_url configuration" do
    audience    = MadMimi::Audience.new
    connection  = audience.send(:connection).build_url(nil).to_s
    connection.should == "http://api.madmimi.com/"
  end

  describe ".search" do
    before do
      stub_get('/audience_members/search.xml').
        with(:headers => {'Accept'=>'application/xml', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => fixture("audience_search.xml"), :headers => {:content_type => "application/xml; charset=utf-8"})

      stub_get('/audience_members/search.xml', { :query => 'oz.santana@gmail.com'}).
        with(:headers => {'Accept'=>'application/xml', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => fixture("audience_search_query.xml"), :headers => {:content_type => "application/xml; charset=utf-8"})
    end

    it "should get all audience members" do
      MadMimi.audience.search.should == [
        { "created_at"=>"Tue Jan 24 11:05:25 -0400 2011", "confirmed"=>nil, "country"=>"BR", "title"=>"Mrs", "suppressed"=>"false", "lists"=>{"list"=>"dev"}, "friend_name"=>"Oz", "last_name"=>"Sant'ana", "twitter"=>"@ozeias", "email"=>"oz.santana@gmail.com", "first_name"=>"Ozéias" },
        { "address"=>nil, "company"=>"Mad Mimi", "city"=>nil, "zip"=>nil, "created_at"=>"Tue Apr 20 14:30:25 -0400 2010", "confirmed"=>nil, "country"=>"US", "title"=>"Mrs", "suppressed"=>"false", "lists"=>{"list"=>"test"}, "friend_name"=>"Marc", "birthday"=>nil, "phone"=>nil, "last_name"=>"Mimi", "categories"=>nil, "state"=>nil, "email"=>"support@madmimi.com", "first_name"=>"Mad" }
      ]
    end

    it "should set the query" do
      MadMimi.audience.search({:query => 'oz.santana@gmail.com'}).should == { "created_at"=>"Tue Jan 24 11:05:25 -0400 2011", "confirmed"=>nil, "country"=>"BR", "title"=>"Mrs", "suppressed"=>"false", "lists"=>{"list"=>"dev"}, "friend_name"=>"Oz", "last_name"=>"Sant'ana", "twitter"=>"@ozeias", "email"=>"oz.santana@gmail.com", "first_name"=>"Ozéias" }
    end
  end

  describe ".members" do
    before do
      stub_get('/audience_members').
        with(:headers => {'Accept'=>'application/xml', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => fixture("audience_members.xml"), :headers => {:content_type => "application/xml; charset=utf-8"})
    end

    it "should get the audience members" do
      MadMimi.audience.members.should == {"city"=>nil, "created_at"=>"Fri Dec 10 18:09:50 -0500 2010", "suppressed"=>"false", "lists"=>nil, "last_name"=>"Sant'ana", "email"=>"oz.santana@gmail.com", "first_name"=>"Ozéias"}
    end
  end

  describe ".lists" do
    before do
      stub_get('/audience_lists/lists.xml').
        with(:headers => {'Accept'=>'application/xml', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => fixture("audience_lists.xml"), :headers => {:content_type => "application/xml; charset=utf-8"})
    end

    it "should get the audience members" do
      MadMimi.audience.lists.should == [{"name"=>"Friends", "subscriber_count"=>"1", "id"=>"102938", "display_name"=>""}, {"name"=>"Clients", "subscriber_count"=>"1", "id"=>"102939", "display_name"=>""}]
    end
  end

  describe ".add_to_list" do
    before do
      stub_post('/audience_lists/Clients/add').
        with(:headers => {'Accept'=>'application/xml', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => " ", :headers => {:content_type => "text/html; charset=utf-8"})
    end

    it "should add audience list membership" do
      client = {:first_name => 'Denise', :last_name => 'T. Guillen', :email => 'denise.t@example.com'}
      MadMimi.audience.add_to_list('Clients', client)

      a_post('/audience_lists/Clients/add').
        with(:body => client.merge(MadMimi.authentication)).
        with(:headers => {'Accept'=>'application/xml', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'MadMimi Gem'}).
        should have_been_made
    end
  end

  describe ".remove_from_list" do
    before do
      stub_post('/audience_lists/Clients/remove').
        with(:headers => {'Accept'=>'application/xml', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => " ", :headers => {:content_type => "text/html; charset=utf-8"})
    end

    it "should remove audience list membership" do
      MadMimi.audience.remove_from_list('Clients', 'denise.t@example.com')

      a_post('/audience_lists/Clients/remove').
        with(:body => {:email => 'denise.t@example.com'}.merge(MadMimi.authentication)).
        with(:headers => {'Accept'=>'application/xml', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'MadMimi Gem'}).
        should have_been_made
    end
  end

  describe ".suppress" do
    before do
      stub_post('/audience_members/denise.t@example.com/suppress_email').
        with(:headers => {'Accept'=>'application/xml', 'User-Agent'=>'MadMimi Gem'}).
        to_return(:status => 200, :body => " ", :headers => {:content_type => "text/html; charset=utf-8"})
    end

    it "should suppress an audience member" do
      MadMimi.audience.suppress('denise.t@example.com')

      a_post('/audience_members/denise.t@example.com/suppress_email').
        with(:body => MadMimi.authentication).
        with(:headers => {'Accept'=>'application/xml', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'MadMimi Gem'}).
        should have_been_made
    end
  end
end
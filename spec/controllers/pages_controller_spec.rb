require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "ramples.com"
  end
  
  describe "Get 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector('title', 
                                    :content => "#{@base_title} | Home")
    end
  end
  
  describe "Get 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector('title', 
                                    :content => "#{@base_title} | Contact Us")
    end
  end
  
  describe "Get 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_selector('title', 
                                    :content => "#{@base_title} | About Us")
    end
  end
  
  describe "Get 'faq'" do
    it "should be successful" do
      get 'faq'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'faq'
      response.should have_selector('title', 
                                    :content => "#{@base_title} | FAQ")
    end
  end
end
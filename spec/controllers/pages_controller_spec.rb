require 'spec_helper'

describe PagesController do
  
  describe "Get 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    #it "should have the right title" do
    #  response.should have_selector('title', :content => "StormDispatch.Com | Home")
    #end
  end
  
  describe "Get 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
    
    #it "should have the right title" do
    #  response.should have_selector('title', :content => "StormDispatch.Com | Contact Us")
    #end
  end
  
  describe "Get 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    #it "should have the right title" do
    #  response.should have_selector('title', :content => "StormDispatch.Com | About Us")
    #end
  end
end
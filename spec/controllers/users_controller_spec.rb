require 'spec_helper'

describe UsersController do
  
  describe "Get 'new'" do
      it "should be successful" do
        get 'new'  
        response.should be_success
      end
  end
end

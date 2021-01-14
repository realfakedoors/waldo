require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get photos#index" do
    get '/api/v1/photos/'
    
    assert_includes(response.body, "Where's Waldo")
    assert_includes(response.body, "Skateboarding")
  end
  
  test "should get photos#show" do
    get '/api/v1/photos/' + photos(:waldo).id.to_s
    
    assert_includes(response.body, "Where's Waldo")
    assert_includes(response.body, "Wenda")
    assert_includes(response.body, "The Wizard")
  end
end
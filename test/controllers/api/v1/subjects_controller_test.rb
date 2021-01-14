require 'test_helper'

class SubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photo = photos(:waldo)
  end
  
  test "should get subjects#index" do
    get '/api/v1/photos/' + @photo.id.to_s + '/subjects'
    
    assert_includes(response.body, "Wenda")
    assert_includes(response.body, "The Wizard")
  end
end
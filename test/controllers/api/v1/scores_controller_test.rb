require 'test_helper'

class ScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photo = photos(:waldo)
  end
  
  test "should get scores#index" do
    get '/api/v1/photos/' + @photo.id.to_s + '/scores'
    
    assert_includes(response.body, "QQQ")
    assert_includes(response.body, "XYZ")
  end
  
  test "should post scores#create" do
    post '/api/v1/photos/' + @photo.id.to_s + '/scores',
      params: { score: { time: 222, initials: "AAA"}}
    
    assert_includes(response.body, "222")
    assert_includes(response.body, "AAA")
  end
end
require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get photos_upload_url
    assert_response :success
  end

end

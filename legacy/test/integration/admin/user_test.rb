require 'test_helper'

class AdminUserTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users('admin_user')
  end

  # TODO: Add tests

  test 'Unauthorized requests' do
    get '/admin/users'
    assert_response 401
    get "/admin/users/#{@admin.id}"
    assert_response 401
    post '/admin/users'
    assert_response 401
    put "/admin/users/#{@admin.id}"
    assert_response 401
    delete "/admin/users/#{@admin.id}"
    assert_response 401
  end
end

require 'test_helper'

class PaperstocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paperstock = paperstocks(:one)
  end

  test "should get index" do
    get paperstocks_url
    assert_response :success
  end

  test "should get new" do
    get new_paperstock_url
    assert_response :success
  end

  test "should create paperstock" do
    assert_difference('Paperstock.count') do
      post paperstocks_url, params: { paperstock: {  } }
    end

    assert_redirected_to paperstock_url(Paperstock.last)
  end

  test "should show paperstock" do
    get paperstock_url(@paperstock)
    assert_response :success
  end

  test "should get edit" do
    get edit_paperstock_url(@paperstock)
    assert_response :success
  end

  test "should update paperstock" do
    patch paperstock_url(@paperstock), params: { paperstock: {  } }
    assert_redirected_to paperstock_url(@paperstock)
  end

  test "should destroy paperstock" do
    assert_difference('Paperstock.count', -1) do
      delete paperstock_url(@paperstock)
    end

    assert_redirected_to paperstocks_url
  end
end

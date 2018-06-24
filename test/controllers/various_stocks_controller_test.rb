require 'test_helper'

class VariousStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @various_stock = various_stocks(:one)
  end

  test "should get index" do
    get various_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_various_stock_url
    assert_response :success
  end

  test "should create various_stock" do
    assert_difference('VariousStock.count') do
      post various_stocks_url, params: { various_stock: {  } }
    end

    assert_redirected_to various_stock_url(VariousStock.last)
  end

  test "should show various_stock" do
    get various_stock_url(@various_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_various_stock_url(@various_stock)
    assert_response :success
  end

  test "should update various_stock" do
    patch various_stock_url(@various_stock), params: { various_stock: {  } }
    assert_redirected_to various_stock_url(@various_stock)
  end

  test "should destroy various_stock" do
    assert_difference('VariousStock.count', -1) do
      delete various_stock_url(@various_stock)
    end

    assert_redirected_to various_stocks_url
  end
end

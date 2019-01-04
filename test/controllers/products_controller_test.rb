require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @book_ruby = products(:ruby)
    @update = {
       title: 'The New Test Book',
       description: 'This books content is about testing',
       image_url: 'ruby.jpg',
       price: 9.99
    }
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert_select '#main .list_line_odd', 2
    assert_select '#main .list_line_odd .list_image', 2
    assert_select '#main .list_line_odd .list_description', 2
    assert_select '#main .list_line_odd .list_actions', 2
    assert_select '#main .list_line_odd .list_actions a', minimum: 3
    assert_select '#main .list_line_odd .list_description dt', 'Programming Ruby 1.9 & 2.0'

    assert_select '#main .list_line_even', 1
    assert_select '#main .list_line_even .list_image', 1
    assert_select '#main .list_line_even .list_description', 1
    assert_select '#main .list_line_even .list_actions', 1
    assert_select '#main .list_line_even .list_actions a', minimum: 3
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      # post products_url, params: { product: { title: @update[:title], description: @update[:description], image_url: @update[:image_url], price: @update[:price] } }
      post products_url, params: { product: @update }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: @update }
    assert_redirected_to product_url(@product)
  end

  test "should delete product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "can't delete product in cart" do
    # @cart = Cart.create
    # @cart.add_product(@book_ruby.id).save!
    # assert_difference('Product.count', 0) do
    #   delete product_url(@book_ruby)
    # end
    # assert_redirected_to products_url
  end

end

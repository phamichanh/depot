require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  fixtures :payment_types
  include ActiveJob::TestHelper

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
    check_payment = payment_types(:check)

    get "/"
    assert_response :success
    assert_template "index"

    post '/line_items', params: { product_id: ruby_book.id }, xhr: true
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    perform_enqueued_jobs do
      post "/orders", params: {
                        order: {
                            name: "Ich Anh",
                            address: "OSAKA",
                            email: "anh.pi270390@gmail.com",
                            payment_type_id: check_payment.id
                        }
                    }
    end

    follow_redirect!

    assert_response :success
    #assert_template "/store/index"
    assert_select 'h1', "Your Book Catalog"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Ich Anh"                , order.name
    assert_equal "OSAKA"                  , order.address
    assert_equal "anh.pi270390@gmail.com" , order.email
    assert_equal check_payment.id         , order.payment_type_id

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["anh.pi270390@gmail.com"], mail.to
    assert_equal 'Ich Anh <anh.pi.japan@gmail.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
  end

end

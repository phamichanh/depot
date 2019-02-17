require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @order = orders(:one)
  end

  test "received" do
    mail = OrderMailer.received(@order)
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["anh.pi270390@gmail.com"], mail.to
    assert_equal ["anh.pi.japan@gmail.com"], mail.from
    assert_match /1 x Programming Ruby 1.9 &amp; 2.0/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(@order)
    assert_equal "Pragmatic Store Order has shipped", mail.subject
    assert_equal ["anh.pi270390@gmail.com"], mail.to
    assert_equal ["anh.pi.japan@gmail.com"], mail.from
    assert_match /<td>1 &times;<\/td>\s*<td>Programming Ruby 1.9 &amp; 2.0<\/td>/, mail.body.encoded
  end

end

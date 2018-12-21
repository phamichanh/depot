require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end
  test "product price must be positive" do
    product = Product.new(title: "My test book",
                          description: "This is test book description",
                          image_url: "test.jpg")

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(p_image_url)
    Product.new(title: "My test book",
                description: "This book content is about test",
                price: 9.99,
                image_url: p_image_url)
  end

  test "product image url must be valid" do
    ok_image_url = %w{ fred.jpg fred.JPG fred.Jpg fred.jPg fred.jpG fred.JPg fred.jPG fred.JpG FRED.jpg
                       fred.gif fred.GIF
                       fred.png fred.PNG
                       https://a.b.c/x/y/z/fred.jpg https://a.b.c/x/y/z/fred.gif https://a.b.c/x/y/z/fred.png  }
    ng_image_url = %w{ fred.jpg.more fred.gif.more fred.png.more fred.tiff fred.psd}

    ok_image_url.each do |item_image_url|
      assert new_product(item_image_url).valid?, "#{item_image_url} should be valid"
    end

    ng_image_url.each do |item_image_url|
      product = new_product(item_image_url)
      assert product.invalid?, "#{item_image_url} shouldn't be valid"
      assert_equal ["must be a URL for GIF, JPG or PNG image."], product.errors[:image_url]
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: "test unique title",
                          image_url: "ruby.jpg",
                          price: 9.99)
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title,
                          description: "test unique title",
                          image_url: "ruby.jpg",
                          price: 9.99)
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

end

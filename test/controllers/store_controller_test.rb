require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9 & 2.0'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "markup needed for store.js.coffee in this place" do
    get store_path
    assert_select '.store .entry > img', 3
    assert_select '.entry input[type=submit]', 3
  end

end

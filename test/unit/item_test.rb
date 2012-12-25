require File.dirname(__FILE__) + '/../../lib/item.rb'

require "test/unit"


# This is the test Class for Item Class
# containing unit test cases for the same.

class ItemTest < Test::Unit::TestCase
  
  def test_error_when_item_name_not_given
    assert_raise Error::ItemError do 
      Item.new("", "24.99")
    end
  end
  
  def test_error_when_unit_price_not_given
    assert_raise Error::ItemError do 
      Item.new("Ball", "")
    end
  end
  
  def test_item_created_without_error
    assert_nothing_raised Error::ItemError do
      item = Item.new("Ball", "24.99")
    end
    item = Item.new("Ball", "24.99")
    assert_not_nil item.name
    assert_not_nil item.unit_price
  end
  
  def test_unit_price_has_a_precision_of_2
    item = Item.new("Ball", "23.5657567576")
    assert_equal(item.unit_price, 23.57)
    assert_not_equal(item.unit_price, 23.56)
  end
  
  def test_default_stock_of_an_item
    item = Item.new("Ball", "23.89")
    assert_equal item.stock, 100
    assert !item.out_of_stock?
  end
  
  def test_item_is_out_of_stock
    item = Item.new("Ball", "23.89", 0)
    assert item.out_of_stock?
  end
end

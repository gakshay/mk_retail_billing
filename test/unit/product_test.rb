require File.dirname(__FILE__) + '/../test_helper'


# This is the test Class for Product Class
# containing unit test cases for the same.

class ProductTest < Test::Unit::TestCase
  
  def test_error_when_product_name_not_given
    assert_raise Error::ProductError do 
      Product.new("", "24.99")
    end
  end
  
  def test_error_when_unit_price_not_given
    assert_raise Error::ProductError do 
      Product.new("Ball", "")
    end
  end
  
  def test_product_created_without_error
    assert_nothing_raised Error::ProductError do
      product = Product.new("Ball", "24.99")
    end
    product = Product.new("Ball", "24.99")
    assert_not_nil product.name
    assert_not_nil product.unit_price
  end
  
  def test_unit_price_has_a_precision_of_2
    product = Product.new("Ball", "23.5657567576")
    assert_equal(product.unit_price, 23.57)
    assert_not_equal(product.unit_price, 23.56)
  end
  
  def test_default_stock_of_an_product
    product = Product.new("Ball", "23.89")
    assert_equal product.stock, 100
    assert !product.out_of_stock?
  end
  
  def test_product_is_out_of_stock
    product = Product.new("Ball", "23.89", 0)
    assert product.out_of_stock?
  end
end

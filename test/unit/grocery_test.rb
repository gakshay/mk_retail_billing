require File.dirname(__FILE__) + '/../test_helper'

# This is the test Class for Grocery class
# containing unit test cases for the same.

class GroceryTest < Test::Unit::TestCase
  
  def test_grocery_is_inherited_from_product
    grocery = Grocery.new("Milk", "24.99")
    assert_equal grocery.class.superclass.name, "Product"
  end
end

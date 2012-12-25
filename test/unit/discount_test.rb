require File.dirname(__FILE__) + '/../../lib/discount.rb'

require "test/unit"


# This is the test Class for Discount module
# containing unit test cases for the same.

class DiscountTest < Test::Unit::TestCase
  
  def test_staff_discount_percentage
    assert_equal(Discount::STAFF_DISCOUNT, 30)
  end
  
  def test_affiliate_discount_percentage
    assert_equal(Discount::AFFILIATE_DISCOUNT, 10)
  end
  
  def test_loyality_discount_percentage
    assert_equal(Discount::LOYALITY_DISCOUNT, 5)
  end
  
  def test_minimum_gross_discount_value
    assert_equal(Discount::MIN_GROSS_BILL_DISCOUNT, 5)
  end
  
  def test_minimum_discountable_bill_amount
    assert_equal(Discount::MIN_DISCOUNTABLE_AMOUNT, 100)
  end
  
  def test_percentage_discount_for_staff_user
    discount = Discount.calculate_percentage_discount(587.95, Role::STAFF)
    assert_equal(discount, 176.39)
    assert_not_equal(discount, 176.4)
  end
  
  def test_percentage_discount_for_affiliate_user
    discount = Discount.calculate_percentage_discount(587.95, Role::AFFILIATE)
    assert_equal(discount, 58.80)
    assert_not_equal(discount, 58.79)
  end
  
  def test_percentage_discount_for_loyal_user
    discount = Discount.calculate_percentage_discount(587.95, Role::LOYAL)
    assert_equal(discount, 29.4)
    assert_not_equal(discount, 29.39)
  end
  
  def test_zero_percentage_discount_for_general_user
    discount = Discount.calculate_percentage_discount(587.95, Role::GENERAL)
    assert_equal(discount, 0.0)
    assert_not_equal(discount, 29.39)
  end
  
  def test_gross_discount_on_total_amount
    discount1 = Discount.calculate_gross_bill_discount(990)
    discount2 = Discount.calculate_gross_bill_discount(90)
    discount3 = Discount.calculate_gross_bill_discount(499)
    assert_equal(discount1, 45)
    assert_not_equal(discount1, 50)
    assert_equal(discount2, 0.0)
    assert_not_equal(discount2, 5)
    assert_equal(discount3, 20)
    assert_not_equal(discount3, 25)
  end
end
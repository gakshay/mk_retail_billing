require File.dirname(__FILE__) + '/../test_helper'

# This is the test Class for Grocery class
# containing unit test cases for the same.

class BillTest < Test::Unit::TestCase
  def setup
    @staff_user = User.new({ :name => "Mr Kamal", :mobile => "9090909090", :role => Role::STAFF, :doj => (Time.now - 1*365*24*60*60)})
    @affiliate_user = User.new({ :name => "Mr Roshan", :mobile => "9191919191", :role => Role::AFFILIATE, :doj => (Time.now - 1*365*24*60*60)})
    @loyal_user = User.new({:name => "Mrs Roshini Agg", :mobile => "9292929292", :doj => (Time.now - 3*365*24*60*60)})
    @user = User.new({:name => "Miss Kalpana", :mobile => "9393939393"})

    # seed some inventory items based on grocery and non-grocery items
    @items = []
    @items << Grocery.new("ButterMilk", "3.99")
    @items << Grocery.new("FreshBread", "8.99")
    @items << Grocery.new("WheatFlour", "110")
    @items << NonGrocery.new("WoddenChair", "229")
    @items << NonGrocery.new("PlasticBalls", "39.29")
    @items << Grocery.new("DozenEggs", "29.45")
    @items << NonGrocery.new("Mobile", "214.89")
    @items << Product.new("CottonShirt", "35.99")
    @items << Grocery.new("RiceBag", "74.99")
    @items <<  NonGrocery.new("GiftItem", "47.89")
  end
  
  def test_bill_is_initialized_when_user_is_registered
    bill = Bill.new(@staff_user)
    assert_equal(bill.user.role, Role::STAFF)
    bill = Bill.new(@affiliate_user)
    assert_equal(bill.user.role, Role::AFFILIATE)
    bill = Bill.new(@loyal_user)
    assert_equal(bill.user.role, Role::LOYAL)
    bill = Bill.new(@user)
    assert_equal(bill.user.role, Role::GENERAL)
  end
  
  def test_bill_is_also_initialized_with_guest_user
    bill = Bill.new()
    assert_equal(bill.user.role, Role::GENERAL)
    assert_equal(bill.user.name, "Guest")
  end
  
  def test_grocery_item_not_applicable_for_discounts
    bill = Bill.new(@user)
    bill.add_to_cart(@items[5], 1)
    assert_equal(bill.cart_items[0][:price], 29.45)
    assert_equal(bill.total_amount, 29.45)
    assert_equal(bill.discountable_amount, 0.0)
    bill.add_to_cart(@items[3], 2)
    assert_equal(bill.cart_items[1][:price], 458.0)
    assert_equal(bill.total_amount, 487.45)
    assert_equal(bill.discountable_amount, 458.0)
    assert_not_equal(bill.discountable_amount, 487.45)
  end
  
  def test_total_amount_when_bill_is_generated
    sample_bill(@user)
    assert_equal(@bill.total_amount, 595.42)
  end
  
  def test_discountable_amount_when_bill_is_generated
    sample_bill(@user)
    assert_equal(@bill.discountable_amount, 565.97)
  end
  
  def test_discounts_and_payable_amount_for_staff_user
    sample_bill(@staff_user)
    @bill.generate_bill
    assert_equal(@bill.percentage_discount, 169.79)
    assert_equal(@bill.gross_discount, 25)
    assert_equal(@bill.discount, 194.79)
    assert_equal(@bill.net_amount, 400.63)
  end
  
  def test_discounts_and_payable_amount_for_affiliate_user
    sample_bill(@affiliate_user)
    @bill.generate_bill
    assert_equal(@bill.percentage_discount, 56.6)
    assert_equal(@bill.gross_discount, 25)
    assert_equal(@bill.discount, 81.6)
    assert_equal(@bill.net_amount, 513.82)
  end
  
  def test_discounts_and_payable_amount_for_loyal_user
    sample_bill(@loyal_user)
    @bill.generate_bill
    assert_equal(@bill.percentage_discount, 28.3)
    assert_equal(@bill.gross_discount, 25)
    assert_equal(@bill.discount, 53.3)
    assert_equal(@bill.net_amount, 542.12)
  end
  
  def test_discounts_and_payable_amount_for_general_user
    sample_bill(@user)
    @bill.generate_bill
    assert_equal(@bill.percentage_discount, 0.0)
    assert_equal(@bill.gross_discount, 25)
    assert_equal(@bill.discount, 25.0)
    assert_equal(@bill.net_amount, 570.42)
  end
  
  private
  
  def sample_bill(user)
    @bill = Bill.new(user)
    @bill.add_to_cart(@items[5], 1)
    @bill.add_to_cart(@items[3], 2)
    @bill.add_to_cart(@items[7], 3)
  end
end
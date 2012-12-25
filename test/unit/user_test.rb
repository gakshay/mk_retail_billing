require File.dirname(__FILE__) + '/../../lib/user.rb'

require "test/unit"


# This is the test Class for User class
# containing unit test cases for the same.

class UserTest < Test::Unit::TestCase
  
  def test_minimum_years_required_to_be_loyal_user
    assert_equal(User::LOYALITY_YEARS, 2)
  end
  
  def test_user_name_is_required
    assert_raise Error::UserError do 
      User.new({:mobile => "9090909090"})
    end
  end
  
  def test_user_mobile_is_required
    assert_raise Error::UserError do 
      User.new({:name => "Kamal"})
    end
  end
  
  def test_zero_errors_when_both_name_and_mobile_are_provided
    assert_nothing_raised Error::UserError do
      user = User.new({:name => "Kamal", :mobile => "9090909090"})
    end
  end
  
  def test_user_is_created_with_given_name_and_mobile
    user = User.new({:name => "Kamal", :mobile => "9090909090"})
    assert_equal(user.name, "Kamal")
    assert_equal(user.mobile, "9090909090")
    
  end
  
  def test_new_user_default_role_is_general
    user = User.new({:name => "Kamal", :mobile => "9090909090"})
    assert_equal(user.role, "general")
    assert_equal(user.role, Role::GENERAL)
    assert_not_equal(user.role, Role::STAFF)
    assert_not_equal(user.role, Role::AFFILIATE)
    assert_not_equal(user.role, Role::LOYAL)
  end
  
  def test_given_user_is_loyal
    user = User.new({:name => "Kamal", :mobile => "9090909090", :doj => (Time.now - 3*365*24*60*60)})
    assert user.loyal?
  end
  
  def test_given_user_is_not_loyal
    user = User.new({:name => "Kamal", :mobile => "9090909090", :doj => (Time.now - 1.9*365*24*60*60)})
    assert !user.loyal?
  end
  
end

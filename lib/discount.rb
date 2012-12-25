#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/role.rb'


# Discount module: it defines the discount constants and calculates discount in different scenerios

module Discount
  
  STAFF_DISCOUNT = 30
  AFFILIATE_DISCOUNT = 10
  LOYALITY_DISCOUNT = 5
  GROSS_BILL_DISCOUNT = 5
  MIN_DISCOUNTABLE_AMOUNT = 100
  ZERO_DISCOUNT = 0
  
  class << self
    
    # calculates one of the applicable percentage discount based on user role
    def calculate_percentage_discount(amount, role)
      case role
      when Role::STAFF
        calculate_staff_discount(amount)
      when Role::AFFILIATE
        calculate_affiliate_discount(amount)
      when Role::LOYAL 
        calculate_loyality_discount(amount)
      else
        Discount::ZERO_DISCOUNT
      end
    end
    
    # calculates the staff discount if the user is retailers employee
    def calculate_staff_discount(amount)
      (amount * Discount::STAFF_DISCOUNT / 100).to_f.round(2)
    end
    
    # calculates the affiliate discount for retailer affiliates 
    def calculate_affiliate_discount(amount)
      (amount * Discount::AFFILIATE_DISCOUNT / 100).to_f.round(2)
    end
    
    # calculates the loyality discount for the loyal user
    def calculate_loyality_discount(amount)
      (amount * Discount::LOYALITY_DISCOUNT / 100).to_f.round(2)
    end
    
    # responsible for gross bill discount if amount is greather than min_discountable_amount
    # independent on the type of user and is just applicable on min_discountable_amount
    def calculate_gross_bill_discount(amount)
      if amount > Discount::MIN_DISCOUNTABLE_AMOUNT
        ((amount.to_i / Discount::MIN_DISCOUNTABLE_AMOUNT) * Discount::GROSS_BILL_DISCOUNT).round(2)
      else
        Discount::ZERO_DISCOUNT
      end
    end
    
  end # << self
end # module discount
#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/role.rb'


# Discount module: it defines the discount constants and calculates discount in different scenerios

module Discount
  
  STAFF_DISCOUNT = 30
  AFFILIATE_DISCOUNT = 10
  LOYALITY_DISCOUNT = 5
  MIN_GROSS_BILL_DISCOUNT = 5
  MIN_DISCOUNTABLE_AMOUNT = 100
  ZERO_DISCOUNT = 0
  
  class << self
    
    # calculates one of the applicable percentage discount based on user role
    # Input
    # discountable_amount: amount(excluding grocery prices)
    # role: Role 
    def calculate_percentage_discount(discountable_amount, role)
      @discountable_amount = discountable_amount
      case role
      when Role::STAFF
        calculate_staff_discount
      when Role::AFFILIATE
        calculate_affiliate_discount
      when Role::LOYAL 
        calculate_loyality_discount
      else
        Discount::ZERO_DISCOUNT
      end
    end
    
    # calculates the staff discount if the user is retailers employee
    def calculate_staff_discount
      (@discountable_amount * STAFF_DISCOUNT / 100).to_f.round(2)
    end
    
    # calculates the affiliate discount for retailer affiliates 
    def calculate_affiliate_discount
      (@discountable_amount * AFFILIATE_DISCOUNT / 100).to_f.round(2)
    end
    
    # calculates the loyality discount for the loyal user
    def calculate_loyality_discount
      (@discountable_amount * LOYALITY_DISCOUNT / 100).to_f.round(2)
    end
    
    # responsible for gross bill discount if amount is greather than min_discountable_amount
    # independent on the type of user and is just applicable on min_discountable_amount
    # here amount should be total amount of the bill
    def calculate_gross_bill_discount(total_amount)
      @total_amount = total_amount
      if @total_amount > Discount::MIN_DISCOUNTABLE_AMOUNT
        ((@total_amount.to_i / Discount::MIN_DISCOUNTABLE_AMOUNT) * Discount::MIN_GROSS_BILL_DISCOUNT).round(2)
      else
        Discount::ZERO_DISCOUNT
      end
    end
    
  end # << self
end # module discount
#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require "date"
require File.dirname(__FILE__) + '/user.rb'
require File.dirname(__FILE__) + '/role.rb'
require File.dirname(__FILE__) + '/error.rb'
require File.dirname(__FILE__) + '/discount.rb'

class Bill
  attr_accessor :bill_number, :bill_date, :cart_items, :role, :total_amount, :discountable_amount
  attr_accessor :percentage_discount, :gross_discount, :discount, :net_amount
  
  def initialize(user=nil)
    @bill_number = Time.now.strftime("%Y%m%d%H%M%S")
    @bill_date = Date.today
    @user = user.nil? ? User.guest_user : user # creates a guest user if no registered user is associated with the bill
    @role = user.role
    @total_amount = 0.0
    @discountable_amount = 0.0
    @cart_items = []
  end
  
  # add an item to the cart with quantity for billing
  def add_item(item, quantity = 1)
    nil if quantity <= 0
    # TODO: check the stock availability
    @cart_items << {:name => item.name, :quantity => quantity, :type => item.class, :unit_price => item.unit_price, :price => (item.unit_price * quantity).round(2)}
    @total_amount += (item.unit_price * quantity).round(2)
    @discountable_amount += (item.unit_price * quantity).round(2) if (item.class.name != "Grocery")
    # TODO: code to subtract item quantity from the inventory
  end
  
  # remove an item to the cart with quantity for billing
  def remove_item(item, quantity = 1)
    nil if quantity <= 0
    @cart_items << {:name => item.name, :quantity => quantity, :type => item.class, :unit_price => item.unit_price, :price => (item.unit_price * quantity).round(2), :remove => true}
    @total_amount -= (item.unit_price * quantity).round(2)
    @discountable_amount -= (item.unit_price * quantity).round(2) if (item.class.name != "Grocery")
    # TODO: code to add the item back to stock
  end
  
  # generate the final bill with discounts and net amount to be paid
  def generate_bill
    raise Error::BillError, "There are no items in the cart"  if @cart_items.empty?
    calculate_discount
    @net_amount = (@total_amount - @discount).round(2)
  end
  
  # calculates the percentage and gross bill discount 
  def calculate_discount
    @role = Role::LOYAL if @user.loyal?
    @percentage_discount = Discount.calculate_percentage_discount(@discountable_amount, @role)
    @gross_discount = Discount.calculate_gross_bill_discount(@total_amount)
    @discount = @percentage_discount + @gross_discount
  end
  
  def print_bill
    puts "----------------------------------------------------------------------------"
    puts "McKinsey: Retail Bill Reciept".rjust(50)
    puts "----------------------------------------------------------------------------"
    print "Bill no: #{@bill_number} \t Bill date: #{@bill_date}\n"
    puts "Customer Name: #{@user.name} \t Mobile: #{@user.mobile} \t Type: #{@user.role}"
    puts "----------------------------------------------------------------------------"
    puts "S.No \t Item Name\t Item Type \t Unit Price \t Quant \t Price \n"
    @cart_items.each_with_index do |item, i|
      puts " #{i+1} \t #{item[:name].to_s.ljust(10)} \t #{item[:type].to_s.ljust(10)} \t #{item[:unit_price].to_s.ljust(10)} \t #{item[:quantity].to_s.ljust(5)} \t #{item[:price].to_s.rjust(5)} "
    end
    puts "----------------------------------------------------------------------------"
    puts "Total Amount: #{@total_amount.round(2)}".rjust(70)
    puts "Discountable Amount: #{@discountable_amount.to_f.round(2)}".rjust(70)
    puts "Discount: #{@percentage_discount.to_f.round(2)} + #{@gross_discount.to_f.round(2)}".rjust(70)
    puts "Discount: #{@discount.to_f.round(2)}".rjust(70)
    puts "Net Payable Amount: #{@net_amount.to_f.round(2)}".rjust(70)
    puts "----------------------------------------------------------------------------\n"
  end
end

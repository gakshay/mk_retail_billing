#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require "date"
require File.dirname(__FILE__) + '/user.rb'
require File.dirname(__FILE__) + '/role.rb'
require File.dirname(__FILE__) + '/error.rb'
require File.dirname(__FILE__) + '/discount.rb'

class Bill
  attr_accessor :bill_number, :bill_date, :cart_items, :user, :total_amount, :discountable_amount
  attr_accessor :percentage_discount, :gross_discount, :discount, :net_amount
  
  # initialzes a bill object 
  # params: User object or a Guest user is created
  def initialize(user=nil)
    @bill_number = Time.now.strftime("%Y%m%d%H%M%S")
    @bill_date = Date.today
    @user = user.nil? ? User.guest_user : user # creates a guest user if no registered user is associated with the bill
    @total_amount = 0.0
    @discountable_amount = 0.0
    @cart_items = []
    @user.loyal? # checks and mark user role as loyal
  end
  
  # add an item to the cart with quantity for billing
  # params: 
  # item: Product, Grocery, NonGrocery object
  # quantity: number of units
  def add_to_cart(item, quantity = 1)
    nil if quantity <= 0
    # TODO: check the stock availability
    unit_price, type = item.unit_price, item.class.name
    price = (unit_price * quantity).round(2)
    @cart_items << {:name => item.name, :quantity => quantity, :type => type, :unit_price => unit_price, :price => price}
    @total_amount += price
    @discountable_amount += price if (type != "Grocery") # discountable only if item is not a grocery item
    # TODO: code to subtract item quantity from the inventory
  end
  
  # remove an item from the cart with quantity for billing
  # params: 
  # item: Product, Grocery, NonGrocery object
  # quantity: number of units
  def remove_from_cart(item, quantity = 1)
    nil if quantity <= 0
    unit_price, type = item.unit_price, item.class.name
    price = (unit_price * quantity).round(2)
    @cart_items << {:name => item.name, :quantity => quantity, :type => type, :unit_price => unit_price, :price => price, :remove => true}
    @total_amount -= price
    @discountable_amount -= price if (type != "Grocery") # discountable only if item is not a grocery item
    # TODO: code to add the item back to stock
  end
  
  
  # generate the final bill with discounts and net amount to be paid
  def generate_bill
    raise Error::BillError, "There are no items in the cart"  if @cart_items.empty?
    calculate_discount
    @net_amount = (@total_amount - @discount).round(2)
  end
  
  def print_bill
    print_header
    @cart_items.each_with_index do |item, index|
      puts " #{index+1} \t #{item[:name].to_s.ljust(10)} \t #{item[:type].to_s.ljust(10)} \t #{item[:unit_price].to_s.ljust(10)} \t #{item[:quantity].to_s.ljust(5)} \t #{item[:price].to_s.rjust(5)} "
    end
    line = "----------------------------------------------------------------------------"
    puts line
    puts "Total Amount: $ #{@total_amount.round(2)}".rjust(70)
    puts "Discountable Amount: $ #{@discountable_amount.to_f.round(2)}".rjust(70)
    puts "Percentage Discount: $ #{@percentage_discount.to_f.round(2)}".rjust(70)
    puts "Gross Discount: $ #{@gross_discount.to_f.round(2)}".rjust(70)
    puts "Total Discount: $ #{@discount.to_f.round(2)}".rjust(70)
    puts "Net Payable Amount: $ #{@net_amount.to_f.round(2)}".rjust(70)
    puts line
  end
  
  private 
  
  # calculates the percentage and gross bill discount 
  def calculate_discount
    @percentage_discount = Discount.calculate_percentage_discount(@discountable_amount, @user.role)
    @gross_discount = Discount.calculate_gross_bill_discount(@total_amount)
    @discount = @percentage_discount + @gross_discount
  end
  
  
  def print_header
    line = "----------------------------------------------------------------------------"
    puts line
    puts "McKinsey: Retail Bill Reciept".rjust(50)
    puts line
    print "Bill no: #{@bill_number} \t Bill date: #{@bill_date}\n"
    puts "Customer Name: #{@user.name} \t Mobile: #{@user.mobile} \t Type: #{@user.role}"
    puts line
    puts "S.No \t  Item Name\t Item Type \t Unit Price \t Quant \t Price \n"
  end
end

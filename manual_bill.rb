#!/usr/bin/env ruby -wKU
require File.dirname(__FILE__) + '/seed_data.rb'

# select a user from user list
  puts "Select a user: "
  puts "ID \t Name\t\t Role \t\t Mobile"
  @users.each_with_index do |user, index|
    puts "#{index+1}. \t #{user.name.ljust(10)} \t #{user.role.ljust(10)} \t #{user.mobile.ljust(10)}"
  end
  user = Integer(gets.chomp)
  @user = @users[user - 1] 

# select the number of items in the cart
  puts "Enter number of items to buy > 1: "
  number_of_items = Integer(gets.chomp)

# add number_of_items to cart
  bill = Bill.new(@user)
  number_of_items.times.each do |number|
    quantity = rand(5) + 1
    item = @items[rand(@items.length)]
    bill.add_to_cart(item, quantity)
  end

# generate the final bill
  bill.generate_bill
  bill.print_bill



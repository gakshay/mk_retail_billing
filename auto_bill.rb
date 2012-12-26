#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/seed_data.rb'

# Create a bill for a random user 
user = @users[rand(@users.length)] # select a random user
bill = Bill.new(user) 

# add random number of items to the cart with random quantity <= 5
(rand(15) + 1).times.each do |number|
  quantity = rand(5) + 1
  item = @items[rand(@items.length)]
  bill.add_to_cart(item, quantity)
end

# generate the final bill
bill.generate_bill
bill.print_bill



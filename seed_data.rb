#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/lib/product.rb'
require File.dirname(__FILE__) + '/lib/grocery.rb'
require File.dirname(__FILE__) + '/lib/non_grocery.rb'
require File.dirname(__FILE__) + '/lib/bill.rb'
require File.dirname(__FILE__) + '/lib/user.rb'
require File.dirname(__FILE__) + '/lib/role.rb'


# seed users having different roles
@users = []
# guest user
@users << User.guest_user
# staff user
@users << User.new({ :name => "Mr Kamal", :mobile => "9090909090", :role => Role::STAFF, :doj => (Time.now - 1*365*24*60*60)})
# affiliate user
@users << User.new({ :name => "Mr Roshan", :mobile => "9191919191", :role => Role::AFFILIATE, :doj => (Time.now - 1*365*24*60*60)})
# old loyal user
@users << User.new({:name => "Mrs Roshini", :mobile => "9292929292", :role => Role::LOYAL , :doj => (Time.now - 3*365*24*60*60)})
# general user
@users << User.new({:name => "Miss Kalpana", :mobile => "9393939393"})

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
@items <<  Product.new("TeddyBear", "47.79")
@items <<  Grocery.new("FrozenPear", "23.45")
@items <<  NonGrocery.new("LaptopTable", "179.99")
@items <<  Product.new("EarPhone", "27.99")
@items <<  Grocery.new("UradPulses", "44.85")


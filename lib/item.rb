#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/error.rb'

# base class Item which stores name, stock and unit price, it can be extended by type of item we have in a retail shop
class Item
  attr_accessor :name, :unit_price, :stock
  
  # input
  # name: item name 
  # unit_price: unit_price of the item
  # stock (optional): number of units in stock of the given item, default: 100
  def initialize(name, unit_price, stock = 100)
    raise Error::ItemError, "Name can't be blank" if name.nil? || name.empty?
    raise Error::ItemError, "Unit Price can't be blank" if unit_price.nil?  || unit_price.empty?
    @name = name
    @unit_price = unit_price.to_f.round(2)
    @stock = stock
  end
  
  # checks if an item is out of stock or not. 
  # item should be checked if it is out of stock or not before adding into the cart
  def out_of_stock?
    @stock == 0 ? true : false
  end
  
end # class Item

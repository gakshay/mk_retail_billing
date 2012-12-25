#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require File.dirname(__FILE__) + '/error.rb'

# base class Product which stores name, stock and unit price, it can be extended by type of product we have in a retail shop
class Product
  attr_accessor :name, :unit_price, :stock
  
  # input
  # name: product name 
  # unit_price: unit_price of the product
  # stock (optional): number of units in stock of the given product, default: 100
  def initialize(name, unit_price, stock = 100)
    raise Error::ProductError, "Name can't be blank" if name.nil? || name.empty?
    raise Error::ProductError, "Unit Price can't be blank" if unit_price.nil?  || unit_price.empty?
    @name = name
    @unit_price = unit_price.to_f.round(2)
    @stock = stock
  end
  
  # checks if an product is out of stock or not. 
  # product should be checked if it is out of stock or not before adding into the cart
  def out_of_stock?
    @stock == 0 ? true : false
  end
  
end # class Product

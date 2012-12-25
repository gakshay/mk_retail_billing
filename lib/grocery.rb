#!/usr/bin/env ruby -wKU

require File.dirname(__FILE__) + '/product.rb'

# inherited Grocery class from Product and can have properties specific to grocery products, say exp date, mfg date
class Grocery < Product
end
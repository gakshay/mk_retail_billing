#!/usr/bin/env ruby -wKU
# encoding: UTF-8

module Error
  
  # User specific error handling 
  class UserError < ArgumentError
  end
  
  # Bill related error handling
  class BillError < StandardError
  end
  
  # Product related error handling
  class ProductError < StandardError
  end
end

#!/usr/bin/env ruby -wKU
# encoding: UTF-8

module Error
  
  # User specific error handling 
  class UserError < ArgumentError
  end
  
  # Bill related error handling
  class BillError < StandardError
  end
  
  # Item related error handling
  class ItemError < StandardError
  end
end

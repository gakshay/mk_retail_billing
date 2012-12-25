#!/usr/bin/env ruby -wKU
# encoding: UTF-8

module Error
  class UserError < ArgumentError
  end
  
  class BillError < StandardError
  end
  
  class ItemError < StandardError
  end
end

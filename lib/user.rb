#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require "date"
require File.dirname(__FILE__) + '/error.rb'
require File.dirname(__FILE__) + '/role.rb'

class User
  attr_accessor :name, :mobile, :role, :doj
  LOYALITY_YEARS = 2
    
  # helps to create new user, assign roles  
  def initialize(options = {})
    raise Error::UserError, "Name can't be blank" unless options[:name]
    raise Error::UserError, "Mobile can't be blank" unless options[:mobile]
    @name = options[:name] 
    @mobile = options[:mobile] 
    @doj = options[:doj].nil? ? Time.now : options[:doj]
    @role = options[:role].nil? ? Role::GENERAL : options[:role]
  end
  
  # class method to generate a guest user
  def self.guest_user(name = "Guest", mobile = "xxx")
    User.new({:name => name, :mobile => mobile})
  end
  
  # check if a user is loyal or not
  def loyal?
    if old_in_years > LOYALITY_YEARS 
      @role = Role::LOYAL if @role == Role::GENERAL || @role.nil?
      true
    else 
      false
    end
  end
  
  # calculates how old is a customer is at the retailer shop and hence used for loyality points
  def old_in_years
    (Time.now - @doj)/(60*60*24*365) unless self.doj.nil?
  end
  
end
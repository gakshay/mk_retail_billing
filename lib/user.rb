#!/usr/bin/env ruby -wKU
# encoding: UTF-8

require "date"
require File.dirname(__FILE__) + '/error.rb'
require File.dirname(__FILE__) + '/role.rb'

class User
  attr_accessor :name, :mobile, :role, :doj
  LOYALITY_YEARS = 2
    
  # input: hash {:name, :mobile, :doj, :role}
  # :name => "name"
  # :mobile => "mobile number"
  # :doj => Time object (optional), defaults: Time.now
  # :role => Role (optional), defaults: Role::GENERAL  
  def initialize(options = {})
    @name = options[:name] 
    @mobile = options[:mobile]
    doj = options[:doj]
    role = options[:role]
    raise Error::UserError, "Name can't be blank" if @name.nil? || @name.empty?
    raise Error::UserError, "Mobile can't be blank" if @mobile.nil? || @mobile.empty?
    @doj = doj.nil? ? Time.now : doj
    @role = role.nil? ? Role::GENERAL : role
  end
  
  # class method to create a guest user on the fly
  # input 'name', 'mobile', 'role'
  def self.guest_user(name = "Guest", mobile = "xxx", role = Role::GENERAL)
    User.new({:name => name, :mobile => mobile, :role => role})
  end
  
  # returns true if a user is loyal and updates his role
  # returns false if user is not loyal
  def loyal?
    if old_in_years > LOYALITY_YEARS 
      @role = Role::LOYAL if @role == Role::GENERAL || @role.nil?
      true
    else 
      false
    end
  end
  
  private
  
  # calculates customer's joining date in number of years
  def old_in_years
    (Time.now - @doj)/(60*60*24*365) unless self.doj.nil?
  end
  
end
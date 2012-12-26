Retail Billing & Discounts
==========================

Problem to generate retail bill and apply discounts


Problem - Billing System
========================

On a retail website, the following discounts apply: 
1. If the user is an employee of the store, he gets a 30% discount 
2. If the user is an affiliate of the store, he gets a 10% discount 
3. If the user has been a customer for over 2 years, he gets a 5% discount. 
4. For every $100 on the bill, there would be a $ 5 discount (e.g. for $ 990, you get $ 45 as a discount). 
5. The percentage based discounts do not apply on groceries. 
6. A user can get only one of the percentage based discounts on a bill.  

Write a program with test cases such that given a bill, it finds the net payable amount. Please note the stress is on object oriented approach and test coverage. 


Requirement
===========

ruby > 1.9.1

Usage
=====

ruby run.rb # for sample seed data, random bill generation and discounts

Design Flow
===========

lib/
  user.rb - class to create a user with name and mobile number with optional (doj (date_of_joining),  role). 
            Define loyal user and provide method to check if a given user is loyal? or not
  role.rb - Declares different Roles that a user can exhibit i.e staff, affiliate, loyal, general
  product.rb - class posses generic product features i.e. name, stock, unit_price. 
               Provides a method to check if a product is **out_of_stock?**  or not
  grocery.rb - inherited from Product class and may possess different attributes and methods for further    implementations
  non_grocery.rb - inherited from Product class and may possess different attributes and methods
  discount.rb - Module declares the Role based Discount constants, class methods that helps in calculating different types of discounts depending upon user roles and amount. These methods will be called by Bill class to calculate discounts
  bill.rb - This class generates a bill, calculate discounts. It provides methods to add an item to item, or remove an item from the cart. Each item when added to the cart calculates the total amount and discountable amount depending upon the item is not a Grocery product.
            Bill printing is done on console right now.
  error.rb - extends the standard errors of each class for further handling and custom messages
  
test/
  unit/
    user_test.rb
    product_test.rb
    discount_test.rb
    bill_test.rb


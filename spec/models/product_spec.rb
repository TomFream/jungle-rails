require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it "Is valid" do
      @category = Category.new(name: "test")
      @product = Product.new(
        name: "test",
        price: 200,
        quantity: 10,
        category: @category
      )
      expect(@product).to be_valid
    end

    it "is not valid if name is absent" do
      @category = Category.new(name: "test")
      @product = Product.new(
        name: nil,
        price: 200,
        quantity: 10,
        category: @category
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end 

    it "is not valid if price is absent" do
      @category = Category.new(name: "test")
      @product = Product.new(
        name: "test",
        quantity: 10,
        category: @category
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "is not valid if quantity is absent" do
      @category = Category.new(name: "test")
      @product = Product.new(
        name: "test",
        price: 200,
        quantity: nil,
        category: @category
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end


    it "is not valid if category is absent" do
      @product = Product.new(
        name: "test",
        price: 200,
        quantity: 10,
        category: nil
      )
      @product.validate
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    
  end
end
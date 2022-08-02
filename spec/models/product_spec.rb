require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    context "given all four fields" do

      it "should save successfully" do
        category = Category.new(name: 'Oak')
        product = Product.new(name: 'Mighty', quantity: 5, price: 700, category: category)
        expect(product).to be_valid
      end

    end

    context "missing one field" do

      it "should fail when no name" do
        category = Category.new(name: 'Fern')
        product = Product.new(quantity: 5, price: 700, category: category)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Name can't be blank")
      end

      it "should fail when no quantity" do
        category = Category.new(name: 'Aspen')
        product = Product.new(name: 'Wayitis', price: 700, category: category)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Quantity can't be blank")
      end

      it "should fail when no price" do
        category = Category.new(name: 'Willow')
        product = Product.new(name: 'Weeping', quantity: 5, category: category)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Price can't be blank")
      end

      it "should fail when no category" do
        product = Product.new(name: 'Street', quantity: 5, price: 700)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Category can't be blank")
      end

    end

  end
end
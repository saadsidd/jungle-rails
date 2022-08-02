require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    context "for passwords" do

      it "should not save when password is missing" do
        user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password_confirmation: 'abc123')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password can't be blank")
      end

      it "should not save when password_confirmation is missing" do
        user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abc123')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it "should not save when password and password_confirmation don't match" do
        user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abc123', password_confirmation: '123abc')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "should not save when password length is below 8 characters" do
        user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: 'abc123', password_confirmation: 'abc123')
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      end

    end

    it "should not save when email is not unique" do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'TEST@TEST.com', password: 'abcd1234', password_confirmation: 'abcd1234')
      expect(user).to be_valid
      user.save

      user2 = User.new(first_name: 'Jane', last_name: 'Doe', email: '       test@test.COM  ', password: 'password', password_confirmation: 'password')
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should not save if missing email" do
      user = User.new(first_name: 'John', last_name: 'Doe', password: 'abc123', password_confirmation: 'abc123')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "should not save if missing first name" do
      user = User.new(last_name: 'Doe', email: 'TEST@TEST.com', password: 'abc123', password_confirmation: 'abc123')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "should not save if missing last name" do
      user = User.new(first_name: 'John', email: 'TEST@TEST.com', password: 'abc123', password_confirmation: 'abc123')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

  end

  describe '.authenticate_with_credentials' do

    it "should return user if using correct login credentials" do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'TEST@TEST.com', password: 'abcd1234', password_confirmation: 'abcd1234')
      user.save
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end

    it "should return nil if using wrong login credentials" do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'TEST@TEST.com', password: 'abcd1234', password_confirmation: 'abcd1234')
      user.save
      expect(User.authenticate_with_credentials(user.email, 'some_wrong_password')).to eq(nil)
    end

    it "should still return user if using extra whitespace around email" do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'example@domain.com', password: 'abcd1234', password_confirmation: 'abcd1234')
      user.save
      expect(User.authenticate_with_credentials('    example@domain.com ', user.password)).to eq(user)
    end

    it "should still return user if using wrong case in email" do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'example@domain.com', password: 'abcd1234', password_confirmation: 'abcd1234')
      user.save
      expect(User.authenticate_with_credentials('eXample@domain.COM', user.password)).to eq(user)
    end

  end
end

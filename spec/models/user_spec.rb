require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    it 'requires password and password_confirmation fields' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'requires password and password_confirmation fields to match' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com",
        password: "test",
        password_confirmation: "tom"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires emails to be unique' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com",
        password: "test",
        password_confirmation: "test"
      )
      @user.validate
      @user.save

      @user2 = User.new(
        first_name: "Tommy",
        last_name: "Fream",
        email: "TOM@TEST.com",
        password: "test",
        password_confirmation: "test"
      )
      @user2.validate
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'requires first name, last name, and email' do
      @user = User.new(
        first_name: "Tom",
        email: "tom@test.com",
        password: "test",
        password_confirmation: "test"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'requires password be a minimum of 3 characters' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com",
        password: "yo",
        password_confirmation: "yo"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'returns a user object if the credentials are verified' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com",
        password: "test",
        password_confirmation: "test"
      )
      @user.validate
      @user.save

      expect(User.authenticate_with_credentials("tom@test.com", "test")).to_not be(nil)
    end

    it 'returns nil if the credentials are not verified' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com",
        password: "test",
        password_confirmation: "test"
      )
      @user.validate
      @user.save

      expect(User.authenticate_with_credentials("tom@test.com", "wrongpassword")).to be(nil)
    end

    it 'should return user object if extra whitespace is provided' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com",
        password: "test",
        password_confirmation: "test"
      )
      @user.validate
      @user.save

      expect(User.authenticate_with_credentials("  tom@test.com  ", "test")).to_not be(nil)
    end

    it 'should return user object when wrong case is used' do
      @user = User.new(
        first_name: "Tom",
        last_name: "Fream",
        email: "tom@test.com",
        password: "test",
        password_confirmation: "test"
      )
      @user.validate
      @user.save

      expect(User.authenticate_with_credentials("toM@tEst.com", "test")).to_not be(nil)
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
    it 'is valid with valid attributes' do
        user = User.new(email: 'john@gmail.com',
        password: "password")
        expect(user).to be_valid
    end

    it 'is not valid without an email' do
        user = User.new(password: "password")
        expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
        user = User.new(email: "john@exmple.com")
        expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
        User.create!(email: "john@example.com", password: "password")
        duplicate_user = User.new(email: "john@example.com", password: "password123")
        expect(duplicate_user).to_not be_valid
        expect(duplicate_user.errors[:email]).to include("User already exists, please log in."
)
    end

    it "can have an attached profile picture" do
        user = FactoryBot.create(:user)
        expect(user.profile_picture).to be_attached
    end
    
    it "can have many books" do
        user = User.create!(email:'john@example.com', password: 'password')
        book1 = Book.create!(title: "Book 1", author: "Author 1", isbn: "1234434", user: user)
        book2 = Book.create!(title: "Book 2", author: "Author 2", isbn: "134434", user: user)

        expect(user.books).to include(book1, book2)
    end
end

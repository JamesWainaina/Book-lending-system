require 'rails_helper'

RSpec.describe Book, type: :model do 
    it "is valid with valid attributes" do
        book = Book.new(title: "The Great Gatsby",
         author: "F.Scott Fitszgerald", isbn: "123456")
        expect(book).to be_valid
    end

    it "is not valid without a title" do
        book = Book.new(author: "F.Scott Fitzgerald",
        isbn: "123456")
        expect(book).to_not be_valid
    end

    it "is not valid without a author" do
        book = Book.new(title: "The Great Gatsby",isbn:"1246")
        expect(book).to_not be_valid
    end

    it "is not valid without isbn" do 
        book = Book.new(title: "The Great Gatsby", 
        author: "F.scott fitzgerald")
        expect(book).to_not be_valid
    end

    it "is not valid with a duplicate ISBN" do
        Book.create!(title: "The Great Gatsby", 
        author: "F.Scott Fitzgerald", isbn: "12345")
        duplicate_book = Book.new(title: "1984", 
        author: "George Kamau", isbn: "12345")

        expect(duplicate_book).to_not be_valid
        expect(duplicate_book.errors[:isbn]).to include("has already been taken")
    end

    it "can have an atached image" do
        book = FactoryBot.create(:book)
        expect(book.image).to be_attached
    end

    it "is valid without a user (user is optional)" do
        book = Book.new(title: "The Great Gatsby", 
        author: "F. Scott", isbn: "12345")
        expect(book).to be_valid
        expect(book.user).to be_nil
    end 

    it "can be associated with a user" do
        user = User.create!(name: "kimani Gathee",
        email: "kimani@gmail.com", password: "password")
        book = Book.new(title: "The Great Gatsby", author:"f. scott",
        isbn: "232832", user:user)

        expect(book).to be_valid
        expect(book.user).to eq(user)
    end

    it "returns true when the book is borrowed" do
        user = User.create!(name: "John Doe", email:"john@example.com",
        password: "password")
        book = Book.new(title: "The Great Gatsby", author: "f.Scott",
        isbn: "1234555", user:user)
        expect(book.borrowed?).to be true
    end

    it "returns false when the book is not borrowed" do
        book = Book.new(title: "The Great Gatsby", author: "f.scott",
        isbn: "12344345")
        expect(book.borrowed?).to be false
    end
end

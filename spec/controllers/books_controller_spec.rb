require 'rails_helper'

RSpec.describe BooksController, type: :controller do

    include Devise::Test::ControllerHelpers

    let(:user) { FactoryBot.create(:user) }

    describe "GET #index" do
        it "assigns @books" do
            book = Book.create!(title: "The Great Gatsby", 
            author: "F.Scott", isbn: "12344")
            get :index
            expect(assigns(:books)).to eq([book])
        end
        
        it 'renders the index template' do
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe "GET #show" do
        it "assigns the requested book to @book" do
            book = Book.create!(title: "The Great Gatsby", 
            author: "f.kimani", isbn: "12332435")
            get :show, params: { id: book.id } 
            expect(assigns(:book)).to eq(book)
        end

        it "renders the show template" do
            book =  Book.create!(title: "The Greate Gatsby",
            author: "f.kimani", isbn: "13728")
            get :show, params: { id: book.id }
            expect(response).to render_template(:show)
        end

        it "returns a 404 for a non-existent book" do
            expect {
                get :show, params: { id: 9999 }
            }.to raise_error(ActiveRecord::RecordNotFound)
        end 
    end    

    describe "GET #borrow" do
        context "when user is authenticated" do
            before { sign_in user}

            it "renders the borrow template if the book is available" do
                book = Book.create!(title: "The Great Gatsby",
                author: "f.debjf", isbn: "1344")
                get :borrow, params: { id: book.id }
                expect(response).to render_template(:borrow)
            end

            it "redirects if the book is already borrowed" do
                borrowed_book = Book.create!(title: "The Great Gatsby", 
                author: "f.Scott", isbn: "12345", user: user)
                get :borrow, params: { id: borrowed_book.id }
                expect(response).to redirect_to(borrowed_book)
                expect(flash[:alert]).to eq("This book is already borrowed.")
            end
        end

        context "when user is not authenticated" do
            it "redirects to the login page" do
                book = Book.create!(title: "The Great Gatsby", author: "Kamau ichungwa", isbn: "12345")
                get :borrow, params: {id: book.id}
                expect(response).to redirect_to(new_user_session_path)
            end
        end
    end     

    describe "POST #confirm_borrow" do
        before { sign_in user }

        context "when the book is available" do
            it "allows the user to borrow the book" do
                book = Book.create!(title: "The Great Gatsby", author: "f.Scott", isbn: "12345")
                post :confirm_borrow, params: { id: book.id, return_date: Date.today + 14.days }

                expected_return_date = Date.today + 14.days
                book.reload

                expect(book.user).to eq(user)
                expect(book.return_date).to eq(expected_return_date)
                expect(response).to redirect_to(book)
                expect(flash[:notice]).to eq("You have successfully borrowed the book. Return it by #{expected_return_date}.")
            end
        end

        context "when the book update fails" do
            it "does not allow borrowing and shows an error message" do
                allow_any_instance_of(Book).to receive(:update).and_return(false)
                book = Book.create!(title: "The Great Gatsby", author: "kamau Benet", isbn: "112434")
                post :confirm_borrow, params: { id: book.id}
                expect(flash[:alert]).to eq("Failed to borrow the book. Please try again.")
            end
        end
    end

    describe "POST #return" do
    context "when the user is the one who borrowed the book" do
      let(:user) { FactoryBot.create(:user) }
      let(:borrowed_book) { Book.create!(title: "The Great Gatsby", author: "James Gatheru", isbn: "12345", user: user) }
  
      before do
        sign_in user
      end
  
      it "allows the user to return the book" do
        post :return, params: { id: borrowed_book.id }
        borrowed_book.reload
  
        expect(borrowed_book.user).to be_nil
        expect(borrowed_book.return_date).to be_nil
        expect(response).to redirect_to(borrowed_book)
        expect(flash[:notice]).to eq("You have successfully returned the book.")
      end
    end
  
    context "when the user did not borrow the book" do
      let(:another_user) { FactoryBot.create(:user) }
      let(:borrowed_book) { Book.create!(title: "The Great Gatsby", author: "Kimani", isbn: "123345", user: user) }
      let(:user) { FactoryBot.create(:user) }
  
      before do
        sign_in another_user
      end
  
      it "does not allow the user to return the book" do
        post :return, params: { id: borrowed_book.id }
  
        expect(response).to redirect_to(borrowed_book)
        expect(flash[:alert]).to eq("You cannot return a book that you have not borrowed.")
      end
    end
  end  
end
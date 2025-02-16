
# Library Management System

- Here is a visual representation of the application:

![Project Overview](/public/Project%20picture.PNG)


## Overview

The **Library Management System** is a web application built using Ruby on Rails. It allows users to browse, borrow, and return books. Additionally, users can manage their profiles and view borrowing history. The application also incorporates user authentication and authorization using Devise.

## Features

- **User Authentication**: Users can sign up, log in, and manage their profiles. Authentication is powered by Devise.
- **Book Borrowing**: Users can borrow books and manage return dates.
- **Book Management**: Admins can add, edit, and remove books from the system.
- **Profile Management**: Users can update their personal information and profile pictures.
- **Responsive Design**: The app is designed to work across multiple screen sizes.

## Technologies Used

- **Backend**: Ruby on Rails
- **Frontend**: TailwindCSS
- **Authentication**: Devise
- **File Attachments**: Active Storage
- **Database**: Sqlite
- **Testing**: RSpec, capybara, FactoryBot

## Setup Instructions

### Prerequisites

- Ruby version: `>= 3.0.0`
- Rails version: `Rails 8.0.1 `
- Sqlite database

### Steps to Run Locally

1. **Clone the repository:**

   ```bash
   git clone https://github.com/JamesWainaina/Book-lending-system.git
   cd library-management-system
   ```

2.  **Install the required gems:**
    ```
    bundle install
    ```

3. **Set up the database:**

    - Configure your PostgreSQL credentials in config/database.yml.

    - Run the following commands to create and set up the database:
   
    ```
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. **Run the Rails server:**
    ```
    rails server
    ```
    - The app will be accessible at http://localhost:3000.


5. **Running Tests**
    ```
    bundle exec rspec
    rails test
    ```

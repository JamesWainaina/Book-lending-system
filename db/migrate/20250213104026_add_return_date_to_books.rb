class AddReturnDateToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :return_date, :date
  end
end

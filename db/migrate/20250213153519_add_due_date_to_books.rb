class AddDueDateToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :due_date, :date
  end
end

class AddNumberToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, null: false, :number, :integer
  end
end

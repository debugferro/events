class AddNumberToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :number, :integer
  end
end

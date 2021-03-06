class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|

      t.timestamps
    end
  end
end

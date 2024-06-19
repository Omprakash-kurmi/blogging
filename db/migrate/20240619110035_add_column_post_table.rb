class AddColumnPostTable < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :user_id, :integer, default: nil
  end
end

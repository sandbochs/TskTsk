class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :description
      t.boolean :completed, default: false
      t.datetime :completed_at
      t.integer :list_id
      t.integer :user_id

      t.timestamps
    end
    add_index :todos, :list_id
    add_index :todos, :user_id
  end
end

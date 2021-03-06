class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :status, default: '0'
      t.belongs_to :user, foreign_key: true, type: :integer
      t.integer :parent_id
      t.timestamps
    end
  end
end

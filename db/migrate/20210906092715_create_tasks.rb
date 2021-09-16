class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.string :status, default: 'new'
      t.belongs_to :user, foreign_key: true, type: :integer
      t.integer :parent_id
      t.timestamps
    end
  end
end

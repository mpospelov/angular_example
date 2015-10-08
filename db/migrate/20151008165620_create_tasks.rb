class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.datetime :date
      t.integer :duration
      t.references :user, foreign_key: true, index: true

      t.timestamps null: false
    end
  end
end

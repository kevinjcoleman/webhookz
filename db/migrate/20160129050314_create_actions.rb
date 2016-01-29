class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name
      t.text :content
      t.integer :action_type
      t.references :webhook, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

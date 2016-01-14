class CreateNations < ActiveRecord::Migration
  def change
    create_table :nations do |t|
      t.references :user, index: true, foreign_key: true
      t.string :nation_slug
      t.string :api_key

      t.timestamps null: false
    end
  end
end

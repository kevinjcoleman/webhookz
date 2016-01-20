class CreateWebhooks < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.string :event
      t.string :external_id
      t.string :link
      t.references :nation, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :webhooks, :external_id
  end
end

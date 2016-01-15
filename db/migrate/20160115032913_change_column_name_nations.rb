class ChangeColumnNameNations < ActiveRecord::Migration
  def change
  	remove_column :nations, :nation_count, :integer
  	add_column :nations, :webhooks_count, :integer
  end
end

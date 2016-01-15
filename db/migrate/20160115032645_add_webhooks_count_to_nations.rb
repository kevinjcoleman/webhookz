class AddWebhooksCountToNations < ActiveRecord::Migration
  def change
  	add_column :nations, :nation_count, :integer
  end
end

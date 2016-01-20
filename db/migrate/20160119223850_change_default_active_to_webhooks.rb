class ChangeDefaultActiveToWebhooks < ActiveRecord::Migration
  def change
  	change_column :webhooks, :active, :boolean, :default => true
  end
end

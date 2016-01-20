class AddStatusToWebhook < ActiveRecord::Migration
  def change
    add_column :webhooks, :active, :boolean
  end
end

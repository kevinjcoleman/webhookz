class AddValidBooleanToNation < ActiveRecord::Migration
  def change
  	add_column :nations, :valid, :boolean, :default => true
  end
end

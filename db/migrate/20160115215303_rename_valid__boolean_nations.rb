class RenameValidBooleanNations < ActiveRecord::Migration
  def change
  	remove_column :nations, :valid, :boolean, :default => true
  	add_column :nations, :valid_api, :boolean, :default => true
  end
end

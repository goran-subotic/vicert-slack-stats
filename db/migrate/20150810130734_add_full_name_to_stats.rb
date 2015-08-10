class AddFullNameToStats < ActiveRecord::Migration
  def change
    add_column :stats, :full_name, :string
  end
end

class AddListidToItems < ActiveRecord::Migration
  def change
    add_column :items, :list_id, :string, references: :lists

  end
end

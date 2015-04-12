class AddPositionToLists < ActiveRecord::Migration
  def self.up
    add_column :lists, :position, :integer
    List.reset_column_information

    list = List.all
    list.each_with_index do |listItem, i|
      listItem.position = i+1
      listItem.save!
    end

    def self.down
      #remove the column I just added because not every migration is perfect
      remove_column :items, :position
    end

  end
end

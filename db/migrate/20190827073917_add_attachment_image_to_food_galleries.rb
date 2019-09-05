class AddAttachmentImageToFoodGalleries < ActiveRecord::Migration[5.2]
  def self.up
    change_table :food_galleries do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :food_galleries, :image
  end
end

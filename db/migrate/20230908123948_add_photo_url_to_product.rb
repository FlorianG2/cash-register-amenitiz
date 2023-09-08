class AddPhotoUrlToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :photo_path, :string
  end
end

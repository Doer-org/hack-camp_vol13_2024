class AddImageUrlToFormulas < ActiveRecord::Migration[7.0]
  def change
    add_column :formulas, :image_url, :text
  end
end

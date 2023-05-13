class CreateScrapedFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :scraped_foods do |t|
      t.string :brand
      t.string :packaging
      t.datetime :imported_at
      t.string :status
      t.string :product_name
      t.string :quantity
      t.string :categories
      t.string :image_url
      t.string :barcode
      t.string :url

      t.timestamps
    end
  end
end

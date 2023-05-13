class AddCodeToScrapedFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :scraped_foods, :code, :string
  end
end

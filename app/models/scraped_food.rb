class ScrapedFood < ApplicationRecord
  validates :url, presence: true
end
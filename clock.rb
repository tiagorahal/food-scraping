require 'clockwork'
require './config/boot'
require './config/environment'

include Clockwork

handler do |job|
  puts "Running #{job}"
  system("cd /home/rahal/Documents/dev/jobs/food-scraping && bundle exec rails runner 'ScrapedFoodsController.new.scrape'")
end
every(1.day, 'daily_scraper_job', at: '16:42')
# every(1.minute, 'test_daily_scraper_job')
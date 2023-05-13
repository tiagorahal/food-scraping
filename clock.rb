require 'clockwork'
require './config/boot'
require './config/environment'
require 'socket'

include Clockwork

hostname = Socket.gethostname

handler do |job|
  puts "Running #{job}"
  system("cd /home/rahal/Documents/dev/jobs/food-scraping && bundle exec rails runner 'ScrapedFoodsController.new.scrape' -- --host=#{hostname}")
end

every(1.day, 'daily_scraper_job', at: '04:00')
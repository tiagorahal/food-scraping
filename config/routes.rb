Rails.application.routes.draw do
  # Define the root URL to the 'scrape' action of 'scraped_foods'
  root 'scraped_foods#scrape'
  # Define a resource for 'scraped_foods'
  resources :scraped_foods do
    # Define a custom member route named 'scrape'
    member do
      get 'scrape'
    end
  end
end
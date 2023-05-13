Rails.application.routes.draw do
  get '/' => 'api#home'
  get 'products/:code' => 'api#show_product'
  get 'products' => 'api#list_products'

  get 'scraped_foods/scrape'

  resources :scraped_foods do
    member do
      get 'scrape'
    end
  end

end
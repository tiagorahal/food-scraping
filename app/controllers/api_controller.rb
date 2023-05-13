class ApiController < ActionController::API
  def home
    render plain: 'Fullstack Challenge 20201026', status: 200
  end

  def list_products
    @scraped_foods = ScrapedFood.page(params[:page]).per(30)
    render json: @scraped_foods, status: 200
  end

  def show_product
    @scraped_food = ScrapedFood.find_by(code: params[:code])
    if @scraped_food.nil?
      render json: { error: "ScrapedFood with code '#{params[:code]}' not found" }, status: :not_found
    else
      render json: @scraped_food
    end
  end
end
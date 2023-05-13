class ApiController < ActionController::API
  def home
    render plain: 'Fullstack Challenge 20201026', status: 200
  end

  def list_products
    @scraped_foods = ScrapedFood.page(params[:page]).per(30)
    render json: @scraped_foods, status: 200
  end

  def show_product
    @product = Product.find_by(code: params[:code])
    if @product
      render json: @product, status: 200
    else
      render json: { error: "Product not found" }, status: 404
    end
  end
end
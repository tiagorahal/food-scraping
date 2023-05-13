require 'nokogiri'
require 'open-uri'

# Enumeration
module Status
  DRAFT = :draft
  IMPORTED = :imported
end

class ScrapedFoodsController < ApplicationController
  def index
    @scraped_foods = ScrapedFood.paginate(:page => params[:page])
    render json: @scraped_foods
  end

  def scrape
    count = 0
    mainPage = Nokogiri::HTML5(URI.open('https://world.openfoodfacts.org/'))

    mainPage.css('ul.products a').each do |link|
      query = link.attribute('href').value
      puts "THIS IS THE LINK: https://world.openfoodfacts.org#{query}"

      productPage = Nokogiri::HTML5(URI.open("https://world.openfoodfacts.org#{query}"))

      #URL 
      url = "https://world.openfoodfacts.org#{query}"

      #CODE
      code = productPage.css('span#barcode').text
      if code.empty?
        puts "No code found"
      else
        puts "Code: #{code}" 
      end


      #BARCODE
      barcode = productPage.css('#barcode_paragraph').text
      if barcode.empty?
        puts "No barcode found"
      else
        barcode = barcode.strip.gsub(/\s+/, '').gsub('Barcode:', '')
        puts "Bar Code: #{barcode}"
      end

      # BRANDS
      brands_tag = productPage.at_css('#field_brands_value')
      if brands_tag.nil?
        puts 'No brands found'
      else
        brands = brands_tag.css('[itemprop="brand"]').map(&:text).join(', ')
        puts "Brands: #{brands}"
      end

      # PACKAGING
      packaging_tag = productPage.at_css('#field_packaging_value')
      if packaging_tag.nil?
        puts 'No packaging found'
      else
        packaging = packaging_tag.css('a').map(&:text).join(', ')
        puts "Packaging: #{packaging}"
      end

      # IMPORTED_T and STATUS
      imported_t = Time.now
      status = if imported_t < Time.now
                 Status::IMPORTED
               else
                 Status::DRAFT
               end

      imported_t = imported_t.strftime('%Y-%m-%dT%H:%M:%SZ')
      puts "Imported_T: #{imported_t}"
      puts "Status: #{status}"

      #PRODUCT NAME
      product_name = productPage.css('h2.title-1').text
      if product_name.empty?
        puts "No product name found"
      else
        product_name = product_name.split('-').first.strip
        puts "Product Name: #{product_name}"
      end

      # QUANTITY
      quantity_tag = productPage.at_css('#field_quantity')
      if quantity_tag.nil?
        puts 'No quantity found'
      else
        quantity = quantity_tag.at_css('span#field_quantity_value').text
        puts "Quantity: #{quantity}"
      end

      #CATEGORIES
      categories_tag = productPage.at_css('#field_categories_value')
      if categories_tag.text.strip.empty?
        puts 'No categories found'
      else
        categories = categories_tag.css('a').map(&:text).join(', ')
        puts "Categories: #{categories}"
      end
      
      # PACKAGING
      packaging_tag = productPage.at_css('#field_packaging_value')
      if packaging_tag.nil?
        puts 'No packaging found'
      else
        packaging = packaging_tag.css('a').map(&:text).join(', ')
        puts "Packaging: #{packaging}"
      end

      # BRANDS
      brands_tag = productPage.at_css('#field_brands_value')
      if brands_tag.nil?
        puts 'No brands found'
      else
        brands = brands_tag.css('[itemprop="brand"]').map(&:text).join(', ')
        puts "Brands: #{brands}"
      end

      # IMAGE URL
      image_url = productPage.at_css('img#og_image')
      if image_url.nil?
        puts "No image_url found"
      else
        image_url = image_url['src']
        puts "image_url: #{image_url}"
      end
      
      if count < 3
        # Create the ScrapedFood object
        @scraped_food = ScrapedFood.create(
          brand: brands,
          packaging: packaging,
          imported_at: imported_t,
          status: status,
          product_name: product_name,
          quantity: quantity,
          categories: categories,
          image_url: image_url,
          barcode: barcode,
          code: code,
          url: url
        )
      
        count += 1
      else
        break
      end
    end

    # Redirect to the index view after creating the scraped_food instance
    redirect_to scraped_foods_path
  end
end
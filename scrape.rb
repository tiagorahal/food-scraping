require 'nokogiri'
require 'open-uri'

    module Status
      DRAFT = :draft
      IMPORTED = :imported
    end
    mainPage = Nokogiri::HTML5(URI.open('https://world.openfoodfacts.org/'))
    mainPage.css('ul.products a').each do |link|
        query = link.attribute('href').value
        puts "THIS IS THE LINK: https://world.openfoodfacts.org#{query}"
        productPage = Nokogiri::HTML5(URI.open("https://world.openfoodfacts.org#{query}"))


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
      


      # IMPORTED_T and STATUS
      imported_t = Time.now
      status = if imported_t < Time.now
                Status::IMPORTED
              else
                Status::DRAFT
              end
      imported_t = imported_t.strftime('%Y-%m-%dT%H:%M:%SZ')
      puts "Status: #{status}"
      puts "Imported_T: #{imported_t}"


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
      if quantity_tag.search('span').empty?
        puts 'No quantity value found'
      else
        quantity_value = quantity_tag.at_css('#field_quantity_value')
        puts "Quantity: #{quantity_value.text}"
      end


      # CATEGORIES
      categories_tag = productPage.at_css('#field_categories_value')
      if categories_tag.text.strip.empty?
        puts 'No categories found'
      else
        puts "Categories: #{categories_tag.text.strip}"
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

      puts ""
      puts ""
    end
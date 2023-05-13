require 'nokogiri'
require 'open-uri'

    mainPage = Nokogiri::HTML5(URI.open("https://world.openfoodfacts.org/"))

    mainPage.css('ul.products a').each do |link|
      query = link.attribute('href').value 
      puts "THIS IS THE LINK: https://world.openfoodfacts.org#{query}"


      productPage = Nokogiri::HTML5(URI.open("https://world.openfoodfacts.org#{query}"))
      code = productPage.css('span#barcode').text
      puts "Code: #{code}" 


      barcode = productPage.css('#barcode_paragraph').text.strip.gsub(/\s+/, '').gsub('Barcode:', '')
      puts "Bar Code: #{barcode}"


      # status still to implement

      
      # imported_t still to implement


      url = "https://world.openfoodfacts.org#{query}"
      puts "URL: #{url}"


      product_name = productPage.css('h2.title-1').text.split('-').first.strip
      puts "Product Name: #{product_name}" #format the name
      # .split('-')[1].strip to get between the - (brands)
      # .scan(/.*-(.*[g|L].*)/).flatten.first.strip this gets the quantity

      puts ""
      puts ""
    end
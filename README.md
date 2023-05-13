# HTTP GET to retrieve the home method response
curl -X GET http://localhost:3000/

# HTTP GET to retrieve the list_products method response
curl -X GET http://localhost:3000/scraped_foods?page=2  

# HTTP GET to retrieve the show_product method response for code 1234 (replace with the actual code you want to retrieve)
curl -X GET http://localhost:3000/show_product?code=1234
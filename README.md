# Open Food Facts API


This is a challenge by Coodesh


This project implements a REST API that uses data from the Open Food Facts project, an open database with nutritional information for various food products. The goal of this project is to support the team of nutritionists at Fitness Foods LC to quickly compare the nutritional information of foods in the Open Food Facts database.

This is the [Live video presentation](https://www.loom.com/embed/61b67a08aecf41ec9b8a55385ec5230b)

## Stack

- Ruby 3.1.1
- Rails 7
- PostgreSQL
- Gems:
  - `open-uri` version 0.3.0
  - `nokogiri` version 1.14.4
  - `clockwork` version 2.0
  - `will_paginate` version 3.1

## Installation

1. Clone the repository to your local machine:

```
git clone https://github.com/tiagorahal/food-scraping.git
```

2. Install the required gems:

```
bundle install
```

3. Create the database:

```
rails db:create
```

4. Run the migrations:

```
rails db:migrate
```

5. Run the server:

```
rails server
```

# API Documentation

This API is built using Ruby on Rails and follows OpenAPI 3.0 concepts.

## Base URL

`http://localhost:3000/`

## Endpoints

### GET /

Returns a message as plain text:

```
Fullstack Challenge 20201026
```

**Example Request:**

```
curl -X GET http://localhost:3000/
```

**Example Response:**

```
Fullstack Challenge 20201026
```

### GET /scraped_foods?page=2

Returns a list of scraped foods in JSON format.

**Query Parameters:**

| Parameter | Type   | Description             |
| --------- | ------ | ----------------------- |
| `page`    | number | The page number to fetch |

**Example Request:**

```
curl -X GET http://localhost:3000/scraped_foods?page=2
```

**Example Response:**

```
[
  {
    "code": 3661112502850,
    "barcode": "3661112502850(EAN / EAN-13)",
    "status": "imported",
    "imported_t": "2020-02-07T16:00:00Z",
    "url": "https://world.openfoodfacts.org/product/3661112502850",
    "product_name": "Jambon de Paris cuit à l'étouffée",
    "quantity": "240 g",
    "categories": "Meats, Prepared meats, Hams, White hams",
    "packaging": "Film en plastique, Film en plastique",
    "brands": "Tradilège, Marque Repère",
    "image_url": "https://static.openfoodfacts.org/images/products/366/111/250/2850/front_fr.3.400.jpg"
  },
  ...
]
```

### GET /products/1234

Returns the details of a product with the given code in JSON format.

**Query Parameters:**

| Parameter | Type   | Description                        |
| --------- | ------ | ---------------------------------- |
| `code`    | number | The product code to retrieve        |

**Example Request:**

```
curl http://localhost:3000/products/7622210449283
```

**Example Response:**

```
{
  "code": 7622210449283,
  "barcode": "1234(EAN / EAN-13)",
  "status": "imported",
  "imported_t": "2021-05-13T00:00:00Z",
  "url": "https://world.openfoodfacts.org/product/7622210449283",
  "product_name": "Sample Product",
  "quantity": "100 g",
  "categories": "Sample category",
  "packaging": "Sample packaging",
  "brands": "Sample brand",
  "image_url": "https://example.com/sample.jpg"
}
```

## Running the Clockwork Gem

To activate the Clockwork gem, run the following command:

```
bundle exec clockwork clock.rb
```

Note: This assumes you have already installed the Clockwork gem and have a `clock.rb` file in the root of your project.

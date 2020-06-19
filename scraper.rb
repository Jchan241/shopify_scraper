require 'json'
require 'open-uri'
require 'csv'

url = 'https://kflsupermarket.com.au/products.json?limit=250&page=2'
page = '0'

urlPlusPage = "#{url}#{page}"

products_serialized = open(urlPlusPage).read
products = JSON.parse(products_serialized)['products']

# puts products.first['title']

# products.each do |product|
#   puts product['title']
#   puts product['product_type']
#   product['tags'].each do |tag|
#     puts tag
#   end
#   product['variants'].each do |variant|
#     puts variant['price']
#   end
# end

CSV.open("KFLproducts.csv", "w") do |csv|
  products.each do |product|
    price = ''
    product['variants'].each do |variant|
      price = variant['price']
    end
    csv << [product['title'], product['tags'], product['product_type'], price]
  end
end

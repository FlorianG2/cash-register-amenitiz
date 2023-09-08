require 'json'

seed_resource_dir = "#{__dir__}/seed_resources/"

puts 'Cleaning Database...'
Product.destroy_all
puts 'Cleaned Database'
puts '---------------------------'

puts 'Creating products...'
products_json = JSON.parse(File.read("#{seed_resource_dir}/products.json"))
products_json['products'].each do |product|
  attributes = {
    product_code: product['product_code'],
    name: product['name'],
    price: product['price'],
    photo_path: product['photo_path']
  }
  Product.create!(attributes)
end
puts "Created #{Product.count} products"
puts '---------------------------'

# db/seeds.rb
puts "Limpiando base de datos..."
Product.destroy_all

puts "Creando productos de ejemplo..."

products_data = [
  {
    product_id: "p-001",
    name: "Zapatillas Runner X",
    description: "Zapatillas para running, suela EVA, talle 40-45",
    category: "Calzado",
    brand: "SportCo",
    price: 79.99,
    old_price: 99.99,
    stock: 25,
    tags: ["running", "outdoor"],
    image_url: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-002",
    name: "Camisa Casual Lona",
    description: "Camisa algodón premium, manga larga",
    category: "Ropa",
    brand: "ModaYa",
    price: 34.50,
    old_price: nil,
    stock: 100,
    tags: ["casual"],
    image_url: "https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-003",
    name: "Auriculares Inalámbricos A1",
    description: "Bluetooth 5.2, cancelación ruido",
    category: "Electrónica",
    brand: "SoundMax",
    price: 59.00,
    old_price: 79.00,
    stock: 10,
    tags: ["audio", "gadget"],
    image_url: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-004",
    name: "Cafetera Express 12oz",
    description: "Cafetera automática, 15 bar",
    category: "Hogar",
    brand: "HomeBrew",
    price: 129.00,
    old_price: 159.99,
    stock: 5,
    tags: ["kitchen"],
    image_url: "https://images.unsplash.com/photo-1517668808822-9ebb02f2a0e6?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-005",
    name: "Mochila Urbana 20L",
    description: "Mochila impermeable, compartimento laptop 15\"",
    category: "Accesorios",
    brand: "UrbanPack",
    price: 49.90,
    old_price: nil,
    stock: 40,
    tags: ["travel", "work"],
    image_url: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-006",
    name: "Pantalón Jogger",
    description: "Jogger sport con ajuste elastico",
    category: "Ropa",
    brand: "ModaYa",
    price: 29.90,
    old_price: 39.90,
    stock: 60,
    tags: ["sport"],
    image_url: "https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-007",
    name: "Smartwatch S2",
    description: "Monitor cardíaco, notificaciones",
    category: "Electrónica",
    brand: "TimeTech",
    price: 89.00,
    old_price: 119.00,
    stock: 15,
    tags: ["wearable"],
    image_url: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-008",
    name: "Lámpara LED de Mesa",
    description: "Luz regulable, USB-C",
    category: "Hogar",
    brand: "LightIt",
    price: 24.50,
    old_price: nil,
    stock: 30,
    tags: ["decor"],
    image_url: "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-009",
    name: "Set de Cocina 3 Piezas",
    description: "Ollas antiadherentes, apto inducción",
    category: "Hogar",
    brand: "CookWell",
    price: 69.99,
    old_price: 89.99,
    stock: 8,
    tags: ["kitchen"],
    image_url: "https://images.unsplash.com/photo-1556911220-bff31c812dba?w=400&h=400&fit=crop"
  },
  {
    product_id: "p-010",
    name: "Calcetines Pack x3",
    description: "Algodón confortable",
    category: "Ropa",
    brand: "BasicWear",
    price: 9.99,
    old_price: nil,
    stock: 200,
    tags: ["basics"],
    image_url: "https://images.unsplash.com/photo-1586350977771-b3b0abd50c82?w=400&h=400&fit=crop"
  }
]

products_data.each do |data|
  Product.create!(data)
  print "."
end

puts "\n¡Productos creados exitosamente!"
puts "Total productos: #{Product.count}"
puts "Categorías: #{Product.all_categories.join(', ')}"
puts "Marcas: #{Product.all_brands.join(', ')}"

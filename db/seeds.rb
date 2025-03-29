Booking.destroy_all
Tour.destroy_all
Category.destroy_all
User.destroy_all

ActiveStorage::Attachment.all.each(&:purge)

category_names = %w[Россия Европа Азия Африка]
categories = {}
category_names.each do |name|
  categories[name] = Category.create!(name: name)
end

tours_data = {
  "Лондон" => {
    filename: "london.jpg",
    categories: [ categories["Европа"] ]
  },
  "Париж" => {
    filename: "paris.jpg",
    categories: [ categories["Европа"] ]
  },
  "Рим" => {
    filename: "rome.jpg",
    categories: [ categories["Европа"] ]
  },
  "Токио" => {
    filename: "tokio.jpg",
    categories: [ categories["Азия"] ]
  }
}

tours_data.each do |name, data|
  tour = Tour.create!(
    name: name,
    price: rand(50_000..120_000),
    discounted: [ true, false ].sample,
    description: "Описание тура в #{name}",
    hidden: false
  )

  tour.categories << data[:categories]

  image_path = Rails.root.join("app/assets/images/#{data[:filename]}")
  if File.exist?(image_path)
    tour.image.attach(
      io: File.open(image_path),
      filename: data[:filename],
      content_type: "image/jpeg"
    )
  else
    puts "Could not find image: #{data[:filename]}"
  end
end

User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  is_admin: true
)

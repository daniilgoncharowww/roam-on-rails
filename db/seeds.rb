Booking.destroy_all
Tour.destroy_all
Category.destroy_all
User.destroy_all

ActiveStorage::Attachment.all.each(&:purge)

%w[Россия Европа Азия Африка].map do |name|
  Category.create(name: name)
end

tours = {
  "Лондон" => {
    filename: "london.jpg",
    category: Category.find_or_create_by(name: "Европа")
  },
  "Париж" => {
    filename: "paris.jpg",
    category: Category.find_or_create_by(name: "Европа")
  },
  "Рим" => {
    filename: "rome.jpg",
    category: Category.find_or_create_by(name: "Европа")
  },
  "Токио" => {
    filename: "tokio.jpg",
    category: Category.find_or_create_by(name: "Азия")
  }
}

tours.each do |key, value|
  tour = Tour.create!(
    name: key,
    price: rand(50_000..120_000),
    discounted: [ true, false ].sample,
    description: "Lorem ipsum dolor sit amet.",
    category: value[:category],
    hidden: false
  )

  attached = tour.image.attach(
    io: File.open(File.join(Rails.root, "app/assets/images/#{value[:filename]}")),
    filename: value[:filename],
    content_type: "image/jpeg"
  )
  p attached

  puts "Successfull added: #{key}"

  tour.save
end

User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  is_admin: true
)

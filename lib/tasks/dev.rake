desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  p "Creating sample data"
  12.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    username = Faker::Internet.username
    User.create(
      email: "#{first_name}@example.com",
      password: "password",
      username: username,
      first_name: first_name,
      last_name: last_name,
      private: true,
    )
  end
  p "There are now #{User.count} users."
end

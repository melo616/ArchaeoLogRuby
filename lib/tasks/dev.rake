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

    12.times do
      Dig.create(
        description: Faker::Lorem.sentence(word_count: 10),
        start_date: Date.today,
        end_date: Date.today,
        location: Faker::Address.full_address,
        name: "test",
      )
    end

    20.times do
      user = User.all.sample
      dig = Dig.all.sample
      DigParticipant.create(
        role: ["student", "lead"].sample,
        dig_id: dig.id,
        participant_id: user.id,
      )
    end

  end
  p "There are now #{User.count} users."
  p "There are now #{Dig.count} digs."

end

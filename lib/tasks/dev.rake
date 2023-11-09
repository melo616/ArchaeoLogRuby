desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  pp "☆･ﾟ:* Creating sample data *:･ﾟ☆"

  if Rails.env.development?
      Artifact.destroy_all
      DigImage.destroy_all
      DigParticipant.destroy_all
      Dig.destroy_all
      User.destroy_all
  end
  
  pp "Generating users"
  12.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
      email: "#{first_name}@example.com",
      password: "password",
      first_name: first_name,
      last_name: last_name,
      private: true,
    )
  end
  pp "There are now #{User.count} users."

  pp "Generating digs"
  12.times do
    description = Faker::Lorem.sentence(word_count: 3)
    address = Faker::Address.full_address
    date = Date.today
    test_id = User.all.sample.id
    test_id_2 = User.all.sample.id
    season = ["Spring", "Summer", "Fall", "Winter"].sample + " 2023"
    Dig.create(
      description: description,
      start_date: date,
      end_date: date,
      location: address,
      name: "test",
      season: season,
      creator_id: test_id_2,
    )
  end
  pp "There are now #{Dig.count} digs."

  # digs = Dig.all
  
  pp "Generating dig participants"
  Dig.all.each do |dig|
    num = rand(1..20)
    num.times do
      user = User.all.sample
      dig = dig
      DigParticipant.create(
        role: ["student", "lead"].sample,
        dig_id: dig.id,
        participant_id: user.id,
      )
    end
  end
  pp "There are now #{DigParticipant.count} participants."

  pp "Generating dig images"
  Dig.all.each do |dig|
    num = rand(1..6)
    num.times do 
      user = dig.dig_participants.sample
      DigImage.create(
        notes: Faker::Quote.jack_handey,
        image_url: "https://robohash.org/#{rand(9999)}",
        dig_id: dig.id,
        user_id: user.participant_id,
      )
    end
  end
  pp "There are now #{DigImage.count} dig images."

  pp "Generating artifacts (suspenseful music plays...)"
  Dig.all.each do |dig|
    10.times do
      material = ["clay", "metal", "wood", "shell"].sample
      category = ["jewelry", "weapon", "pottery", "tool"].sample
      hardness = rand(1..6)
      poster = dig.dig_participants.sample
      description = Faker::Lorem.sentence(word_count: 10)
      Artifact.create(
        lat: 1.11111,
        lng: 1.11111,
        material: material,
        category: category,
        mohs_hardness: hardness,
        site: "test",
        weight: 2.0,
        dig_id: dig.id,
        poster_id: poster.participant_id,
        description: description,
      )
    end
  end
  pp "There are now #{Artifact.count} artifacts. Yay!"

  pp "✧・ﾟ:*✧・ﾟ:* Task complete *:・ﾟ✧*:・ﾟ✧"
  pp "✧･*･* Ur a pretty pretty princess *･*･✧"
end

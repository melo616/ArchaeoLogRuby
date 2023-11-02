desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  p "Creating sample data"

  if Rails.env.development?
      # DigPhoto.destroy_all
      DigParticipant.destroy_all
      Dig.destroy_all
      User.destroy_all
  end
  
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

    12.times do
      description = Faker::Lorem.sentence(word_count: 3)
      address = Faker::Address.full_address
      date = Date.today
      # test_id = User.all.sample.id
      Dig.create(
        description: description,
        start_date: date,
        end_date: date,
        location: address,
        name: "test",
        season: "test",
        creator_id: 1,
        primary_investigator_id: 1,
      )
    end

    # 20.times do
    #   user = User.all.sample
    #   dig = Dig.all.sample
    #   pp user
    #   pp dig
    #   DigParticipant.create(
    #     role: ["student", "lead"].sample,
    #     dig_id: dig.id,
    #     participant_id: user.id,
    #   )
    # end

    # 20.times do 
    #   user = User.all.sample
    #   dig = Dig.all.sample
    #   DigImage.create(
        
    #   )
    # end

  end
  p "There are now #{User.count} users."
  p "There are now #{Dig.count} digs."

end

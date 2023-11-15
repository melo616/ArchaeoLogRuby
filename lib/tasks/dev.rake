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
    user_bios = [
      "Passionate archaeologist with a knack for uncovering ancient mysteries. Excited to explore new sites and contribute to our understanding of the past.",
      "Dedicated field worker with years of experience in hands-on excavations. Thrives on the thrill of discovering artifacts and unraveling history.",
      "Archaeology enthusiast fascinated by cultural heritage. Eager to collaborate with fellow researchers to reveal the stories buried beneath the sands of time.",
      "Field archaeologist with expertise in prehistoric civilizations. Committed to preserving and interpreting the archaeological record for future generations.",
      "Seasoned explorer with a deep appreciation for ancient cultures. Believes in the power of archaeology to bridge the gap between the past and the present.",
      "Curious researcher passionate about underwater archaeology. Aiming to unravel the mysteries of sunken civilizations and their maritime connections.",
        "Adventurous field archaeologist specializing in ancient trade routes. Enjoys the challenges of remote excavations and connecting the dots of human history.",
        "Cultural heritage preservationist dedicated to documenting and safeguarding endangered archaeological sites. Committed to fostering awareness and appreciation.",
        "Innovative archaeologist leveraging cutting-edge technology for non-invasive site exploration. Excited about the intersection of archaeology and modern science.",
        "Anthropologist with a focus on human evolution. Thrives on uncovering clues to our ancient ancestors and understanding the dynamics of early societies.",
        "Archaeological illustrator with a passion for bringing ancient artifacts and structures to life through detailed and accurate visual representations.",
        "Historical archaeologist fascinated by colonial-era sites. Aims to shed light on the daily lives and interactions of people from the past.",
        "Archaeobotanist exploring the relationships between ancient civilizations and plant life. Interested in the role of agriculture in shaping human history.",
        "Ceramic specialist with an eye for pottery analysis. Enjoys decoding cultural and social aspects through the study of ancient ceramic artifacts.",
        "Archaeological photographer capturing the essence of excavation sites. Believes in the power of visual storytelling to convey the richness of archaeological discoveries."
    ]
    bio = user_bios.sample
    User.create(
      email: "#{first_name}@example.com",
      password: "password",
      first_name: first_name,
      last_name: last_name,
      bio: bio,
      private: true,
    )
  end
  pp "There are now #{User.count} users."

  pp "Generating digs"
  12.times do
    dig_names = [
      "Valley of the Kings",
      "Lost City of Atlantis",
      "Machu Picchu Excavation",
      "Pompeii Unearthed",
      "Ancient Troy Expedition",
      "Mayan Temples Discovery",
      "Giza Pyramids Exploration",
      "Easter Island Expedition",
      "Stonehenge Unveiling",
      "Incan Citadel Quest",
      "Citadel of the Ancients Excavation",
      "Herculaneum Rediscovery Project",
      "Amazon Rainforest Archaeological Expedition",
      "Celtic Burial Mounds Exploration",
      "Terra Cotta Army Unveiling",
      "Teotihuacan Pyramid Quest",
      "Babylonian Empire Dig Site",
      "Petra Rose City Expedition",
      "Mesoamerican Ballgame Unearthed",
      "Chichen Itza Temples Investigation",
      "Cappadocia Underground Cities Excavation",
      "Pueblo Cliff Dwellings Discovery",
      "Indus Valley Civilization Unraveling",
      "Scottish Neolithic Village Dig",
      "Roman Forum Restoration Project",
      "Ancient Greek Shipwreck Exploration",
      "Viking Age Settlement Investigation",
      "Harappan Port City Unveiling",
      "Egyptian Oasis Temple Expedition",
      "Pre-Columbian Cave Paintings Study"
    ]
    name = dig_names.sample
    description = Faker::Lorem.sentence(word_count: 3)
    address = Faker::Address.full_address
    date = Date.today
    test_id = User.all.sample.id
    season = ["Spring", "Summer", "Fall", "Winter"].sample + " 2023"
    Dig.create(
      description: description,
      start_date: date,
      end_date: date,
      location: address,
      name: name,
      season: season,
      creator_id: test_id,
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
      sample_roles = {
        "lead" => :lead,
        "analyst" => :analyst,
        "field worker" => :field_worker
      }
      DigParticipant.create(
        role: sample_roles.keys.sample,
        dig_id: dig.id,
        participant_id: user.id,
      )
    end
  end
  pp "There are now #{DigParticipant.count} participants."

  # pp "Generating dig images"
  # Dig.all.each do |dig|
  #   num = rand(1..6)
  #   num.times do 
  #     user = dig.dig_participants.sample
  #     image_url = "https://res.cloudinary.com/demo/image/upload/sample1.jpg"
  #     DigImage.create(
  #       notes: Faker::Quote.jack_handey,
  #       image_url: image_url,
  #       dig_id: dig.id,
  #       user_id: user.participant_id,
  #     )
  #   end
  # end
  # pp "There are now #{DigImage.count} dig images."

  pp "Generating artifacts (suspenseful music plays...)"
  Dig.all.each do |dig|
    rand(5..20).times do
      material = ["clay", "metal", "wood", "shell"].sample
      category = ["jewelry", "weapon", "pottery", "tool"].sample
      hardness = rand(1..6)
      poster = dig.dig_participants.sample
      sample_data_descriptions = [
        "Pottery fragments from a Bronze Age settlement, showcasing intricate designs and evidence of advanced craftsmanship.",
        "Excavated animal bones providing insights into the dietary habits of a prehistoric community.",
        "Flint tools and arrowheads, suggesting the presence of early human activity in the region.",
        "Ancient textile remnants, revealing the weaving techniques and textile patterns of a bygone era.",
        "Ornate jewelry pieces made from various materials, offering clues about social status and cultural preferences.",
        "Preserved plant remains, indicating the agricultural practices and plant species cultivated in antiquity.",
        "Architectural fragments from a Roman villa, shedding light on the construction methods and architectural styles of the time.",
        "Seashell artifacts with intricate carvings, suggesting a coastal civilization with maritime connections.",
        "Human skeletal remains providing valuable data on health, lifestyle, and possible causes of mortality in ancient populations.",
        "Inscribed stone tablets containing ancient scripts, contributing to the understanding of language and communication.",
        "Metal artifacts, including tools and weapons, revealing advancements in metallurgy and craftsmanship.",
        "Ceramic vessels with unique shapes and decorative elements, showcasing the artistry of ancient pottery makers.",
        "Charred seeds and plant residues, offering insights into ancient agriculture and dietary habits.",
        "Shell beads and jewelry, providing evidence of trade networks and cultural exchange in prehistoric times.",
        "Bronze statuettes depicting deities, offering glimpses into religious beliefs and artistic expression.",
        "Well-preserved wooden artifacts, such as tools and implements, offering rare insights into ancient woodworking techniques.",
        "Stone carvings illustrating scenes from daily life, mythology, and rituals, enriching our understanding of ancient cultures.",
        "Glass artifacts, including beads and vessels, showcasing the skill of ancient glassmakers and trade connections.",
        "Clay figurines representing humans and animals, serving various ceremonial and symbolic purposes.",
        "Fossilized pollen grains, contributing to the reconstruction of ancient landscapes and environmental conditions.",
      "Stone tools with distinctive markings, hinting at the purposes and techniques of tool production in ancient societies.",
        "Metallic ingots and smelting residues, providing evidence of early metalworking and technological advancements.",
        "Fragmented manuscripts and scrolls, offering glimpses into ancient literature, knowledge, and cultural practices.",
        "Bone and antler artifacts, showcasing the versatility of materials used in crafting tools and decorative items.",
        "Carved ivory artifacts, depicting intricate scenes and patterns, highlighting the artistry of ancient ivory carvers.",
        "Shell tools and implements, illustrating the ingenuity of utilizing marine resources for practical purposes.",
        "Amulets and talismans, believed to have held religious or protective significance in ancient belief systems.",
        "Stone slabs with petroglyphs, featuring symbolic carvings and artwork, providing insights into ancient symbolism.",
        "Engraved metal coins, offering information about economic systems, trade routes, and currency in ancient civilizations.",
        "Remnants of ancient dyes and pigments, contributing to the understanding of artistic expression and color symbolism.",
        "Preserved plant fibers, showcasing various weaving techniques used in the creation of textiles and baskets.",
        "Clay tokens and counting devices, potentially linked to early systems of accounting and record-keeping.",
        "Decorative shell inlays from furniture and artifacts, reflecting the aesthetic preferences of ancient cultures.",
        "Architectural ceramics, such as roof tiles and bricks, revealing construction methods and building styles.",
        "Burnt offerings and ceremonial deposits, shedding light on religious rituals and practices of ancient societies.",
        "Metallic mirrors and reflective objects, indicating advancements in metallurgy and personal grooming habits.",
        "Fragmented musical instruments, providing insights into the musical traditions and cultural significance of sound.",
        "Wooden cart fragments and wheel components, offering clues about transportation methods in ancient civilizations.",
        "Copper alloy and gold jewelry, showcasing the craftsmanship and artistic styles of ancient metalworkers.",
        "Bone flutes and musical instruments, contributing to the understanding of ancient music and artistic expression."
      ]
      description = sample_data_descriptions.sample
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

desc "Drops, creates, and migrates database"
task reset: [
  :environment,
  "db:drop",
  "db:create",
  "db:migrate"
]

desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  pp "☆･ﾟ:* Creating sample data *:･ﾟ☆"

  if Rails.env.development?
      Artifact.destroy_all
      Image.destroy_all
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
  #     Image.create(
  #       notes: Faker::Quote.jack_handey,
  #       image_url: image_url,
  #       dig_id: dig.id,
  #       user_id: user.participant_id,
  #     )
  #   end
  # end
  # pp "There are now #{Image.count} dig images."

  pp "Generating artifacts (suspenseful music plays...)"
  Dig.all.each do |dig|
    rand(5..20).times do
      material = ["clay", "metal", "wood", "shell"].sample
      categories = {
        "jewelry" => :jewelry,
        "weaponry" => :weaponry,
        "tool" => :tool,
        "feature" => :feature,
        "pottery" => :pottery,
        "tablet" => :tablet,
        "human remains" => :human_remains,
        "clothing" => :clothing,
        "faunal remains" => :faunal_remains, 
        "other" => :other
      }
      category = categories.keys.sample
      hardness = rand(1..6)
      poster = dig.dig_participants.sample
      found_date = dig.start_date + rand((dig.end_date - dig.start_date).to_i)
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
        material: material,
        category: category,
        mohs_hardness: hardness,
        site: "test",
        weight: 2.0,
        dig_id: dig.id,
        poster_id: poster.participant_id,
        description: description,
        found_date: found_date,
      )
    end
  end
  pp "There are now #{Artifact.count} artifacts. Yay!"

  pp "Generating announcements..."
  Dig.all.each do |dig|
    rand(5..20).times do
      poster = dig.dig_participants.sample
      subject_lines = [
        "Unearth the Secrets of the Past: Join Our Archaeological Dig!",
        "Exciting News! Archaeological Discovery Mission Begins Soon!",
        "Dust Off Your Trowels: Archaeological Dig Launching Soon!",
        "Journey to the Past: Archaeological Dig in [Region] Now Open for Volunteers",
        "Archaeological Unveiling: Recent Discoveries at [Site]",
        "Preserve the Legacy: Archaeological Dig Invites Volunteers!",
        "Unlock the Past: Archaeological Dig Opportunity Awaits You!",
        "Dig Deeper: Archaeological Expedition Seeking Passionate Explorers!",
        "Become a Guardian of History: Archaeological Dig Volunteers Needed!",
        "Archaeological Quest Alert: Join the Expedition into [Era] Civilization!",
        "Explore Our Archaeological Journey: Updates from the Dig Site",
        "Archaeology Unleashed: Join us in Uncovering [Site]’s Rich History!",
        "Calling All History Enthusiasts! Join our Archaeological Expedition!",
        "Step Back in Time: Archaeological Excavation in [Site] Opens Doors",
        "Embark on a Time-Traveling Adventure: Archaeological Excavation Announcement",
        "Discover Ancient Mysteries: Exciting Archaeological Dig Opportunity!",
        "Calling All Adventurers: Archaeological Expedition Seeking Explorers!",
        "Uncover the Stories Beneath: Archaeological Dig Launch Announcement",
        "History Buffs Wanted! Join Our Archaeological Dig Adventure!",
        "Become a Modern-Day Indiana Jones: Archaeological Expedition Alert!"
      ]
      body_texts = [
        "Join our archaeological dig in [Location] and be a part of uncovering ancient artifacts that have been hidden for centuries. This is a unique opportunity to delve into the mysteries of the past and contribute to the preservation of our cultural heritage. No experience is necessary – just bring your passion for history and a sense of adventure!",
        "We're thrilled to announce the commencement of our archaeological excavation in [Site]. This site is believed to hold key insights into the lives of an ancient civilization. Join our team of experts and volunteers as we unearth artifacts, decipher ancient scripts, and piece together the puzzle of our shared history.",
        "Attention all history enthusiasts! The countdown has begun for our upcoming archaeological dig in [Location]. Grab your trowels and join us on this exciting journey into the past. Together, we'll uncover the secrets buried beneath the layers of time and connect with civilizations that have long been forgotten.",
        "Our team is excited to share the latest discoveries at [Site]! Recent excavations have unveiled a treasure trove of artifacts that shed light on the daily lives of ancient inhabitants. Stay tuned for updates as we continue to unearth the mysteries hidden beneath the earth's surface.",
        "Calling all adventurers and history buffs! We are on the brink of unveiling new chapters in history at our archaeological dig. Whether you're a seasoned archaeologist or a curious novice, there's a place for you in our expedition. Join us as we explore the rich tapestry of [Site]'s past and rewrite history together.",
        "Become a part of history by joining our archaeological dig in [Location]. This is not just an excavation; it's a journey into the heart of civilizations long gone. As we dig deeper, we invite you to uncover the stories that connect us to our ancestors and contribute to the legacy of human civilization.",
        "Exciting updates from the dig site! Our team has been hard at work unearthing artifacts that provide new insights into the daily lives of ancient civilizations. From pottery fragments to intricate tools, each discovery adds another piece to the puzzle of our shared history. Follow our journey as we bring the past to life!",
        "Embark on a time-traveling adventure with our archaeological excavation announcement. The site holds the promise of unlocking mysteries from a bygone era. Join our team of explorers, historians, and enthusiasts as we uncover the remnants of ancient civilizations. Your journey into the past begins here!",
        "Delve into the history of [Site] with our archaeological dig opportunity. We're seeking passionate explorers to join us in the excavation of this remarkable site. Whether you're a seasoned archaeologist or a newcomer to the field, this is your chance to make history by discovering the untold stories buried beneath the surface.",
        "Archaeology unleashed! Join us in uncovering [Site]'s rich history as we embark on an archaeological quest. This is more than just a dig; it's an opportunity to connect with the past and contribute to the preservation of our cultural heritage. Grab your tools and join us on this exciting journey!",
        "Step back in time with our archaeological excavation in [Site]. The doors are open for volunteers to participate in the discovery of ancient artifacts and the unraveling of historical mysteries. Whether you're a history buff, student, or simply curious, this is your chance to be a part of an unforgettable archaeological experience.",
        "Calling all history enthusiasts! Join our archaeological expedition and become a modern-day Indiana Jones. With each shovel, you'll contribute to our understanding of [Era] civilization. Uncover artifacts, decode ancient symbols, and make history with us!",
        "Embark on a time-traveling adventure with our archaeological excavation announcement. The site holds the promise of unlocking mysteries from a bygone era. Join our team of explorers, historians, and enthusiasts as we uncover the remnants of ancient civilizations. Your journey into the past begins here!",
        "Discover ancient mysteries with our exciting archaeological dig opportunity. Uncover the secrets of [Location] as we explore the layers of history buried beneath the ground. This is your chance to be a part of a groundbreaking expedition and contribute to the legacy of our ancestors.",
        "Calling all adventurers! Our archaeological expedition is seeking explorers to join us on a journey into the past. As we excavate [Site], you'll have the opportunity to uncover artifacts, decipher ancient scripts, and piece together the puzzle of a lost civilization. Are you ready for the adventure of a lifetime?",
        "Uncover the stories beneath with our archaeological dig launch announcement. Join us as we explore the rich history of [Site] and bring to light the forgotten tales of those who came before us. This is a unique opportunity to connect with the past and make your mark on history.",
        "History buffs wanted! Join our archaeological dig adventure and become a part of a team dedicated to preserving and understanding our shared heritage. No prior experience is necessary—just bring your enthusiasm and a sense of curiosity as we dig deep into the layers of history at [Location].",
        "Calling all history enthusiasts! Our archaeological expedition is now open for volunteers. Join us as we uncover the mysteries of [Era] civilization and contribute to the preservation of our cultural heritage. This is your chance to make a tangible impact on our understanding of the past.",
        "Become a modern-day guardian of history with our archaeological dig volunteers needed announcement. As we embark on this exciting journey, we invite you to join our team and help uncover the secrets hidden beneath the soil. Your passion for history can make a difference!"
      ]
      title = subject_lines.sample
      body = body_texts.sample
      Announcement.create(
        title: title,
        body: body,
        dig_id: dig.id,
        poster_id: poster.participant_id
      )
    end
  end
  pp "There are now #{Announcement.count} announcements. Yay!"

  pp "✧・ﾟ:*✧・ﾟ:* Task complete *:・ﾟ✧*:・ﾟ✧"
  pp "✧･*･* Ur a pretty pretty princess *･*･✧"
end

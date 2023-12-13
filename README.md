# ArchaeoLog

[`ArchaeoLog`](https://archaeolog.onrender.com) is a digital field log where archaeologists can create digs, add participants, add images, and log artifacts. It is a streamlined and user-friendly application that serves as a modern and lightweight upgrade to traditional museum and archaeological software.

## Table of Contents
1. [Features](#features)
2. [Future Features](#future-features)
3. [Data Model](#data-model)
4. [Installation](#installation)
5. [Credits and Gems/Software](#credits)

## Features

1. Digs: Create and manage archaeological digs with details such as location, start and end date, and description. 
2. Participants: Invite participants involved in a dig and assign roles to ensure security and control access.
3. Artifacts Logging: Log artifacts discovered during digs with detailed information such as material, category, description, and images.
4.  Image Uploads: Upload images related to digs and artifacts and add notes for easy reference. Utilizes Cloudinary for cloud-based storage.
5.  Data Visualization: Uses ChartKick for visualization of artifacts by type and date found.
6.  Modularized Data: Easy navigation of information related to digs, participants, and artifacts.
7. Announcements: Keep dig participants informed with announcements related to your project.

## Future Features

1. Maps Integration: View your dig's location on a map using GeoCoding and Google Maps API.
2. More robust data charts based on additional artifact attributes
3. Email notifications for invitations, announcements, and account information
4. Ability to add custom fields for artifacts
5. PDF uploads to share academic papers

## Data Model

![ERD](erd.png)

## Installation
1. Clone this repository:
```
  git clone https://github.com/melo616/ArchaeoLogRuby.git
  cd ArchaeoLog
```
2. Install dependencies:
  - Postgresql 12
  - Ruby version: `3.2.1`
  - Rails version: `7.0.4.3`
3. Install gems:
```
  bundle install
```
4. Set up database:
```
  rails db:create
  rails db:migrate
```
5. Setup environment variables:
   -Set up a Cloudinary account and access your cloud name, api secret, and api key
   -Create a .env with the following format:
```
 CLOUDINARY_CLOUD_NAME="your cloud name"
 CLOUDINARY_API_KEY="your api key"
 CLOUDINARY_API_SECRET="your api secret"
```

## Credits

This project was built using a base Ruby on Rails template provided by DPI.

### Gems included in DPI's Rails Template

- [`appdev_support`](https://github.com/firstdraft/appdev_support)
- [`annotate`](https://github.com/ctran/annotate_models)
- [`awesome_print`](https://github.com/awesome-print/awesome_print)
- [`better_errors`](https://github.com/BetterErrors/better_errors)
- [`binding_of_caller`](https://github.com/banister/binding_of_caller)
- [`dotenv-rails`](https://github.com/bkeepers/dotenv)
- [`draft_generators`](https://github.com/firstdraft/draft_generators/)
- [`draft_matchers`](https://github.com/jelaniwoods/draft_matchers/)
- [`devise`](https://github.com/heartcombo/devise)
- [`faker`](https://github.com/faker-ruby/faker)
- [`grade_runner`](https://github.com/firstdraft/grade_runner/)
- [`htmlbeautifier`](https://github.com/threedaymonk/htmlbeautifier/)
- [`http`](https://github.com/httprb/http)
- [`pry_rails`](https://github.com/pry/pry-rails)
- [`rails_db`](https://github.com/igorkasyanchuk/rails_db)
- [`rails-erd`](https://github.com/voormedia/rails-erd)
- [`rspec-html-matchers`](https://github.com/kucaahbe/rspec-html-matchers)
- [`rspec-rails`](https://github.com/rspec/rspec-rails)
- [`rufo`](https://github.com/ruby-formatter/rufo)
- [`specs_to_readme`](https://github.com/firstdraft/specs_to_readme)
- [`table_print`](https://github.com/arches/table_print)
- [`web_git`](https://github.com/firstdraft/web_git)
- [`webmock`](https://github.com/bblimke/webmock)

### Additional Gems for ArchaeoLog

- [`cloudinary`](https://github.com/cloudinary/cloudinary_gem)
- [`chartkick`](https://github.com/ankane/chartkick)
- [`pundit`](https://github.com/varvet/pundit)

### Additional software:
- OS Ubuntu 20.04.5 LTS
- Chromedriver
- Fly.io's `flyctl`
- Google Chrome (headless browser)
- Graphviz
- Heroku 
- Node JS 18
- NPM 8.19.3
- Parity
- Postgresql 12
- Redis
- Yarn

### VS Code extensions:
- aliariff.vscode-erb-beautify
- mbessey.vscode-rufo
- vortizhe.simple-ruby-erb

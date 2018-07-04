# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Label.find_or_create_by(
  name: 'Not specifically bad',
  slug: 'nothing',
  nice: true,
)
Label.find_or_create_by(
  name: 'Threatening text',
  slug: 'threat',
  nice: false,
)
Label.find_or_create_by(
  name: 'Hate speech',
  slug: 'hate',
  nice: false,
)
Source.find_or_create_by(
  name: "Stefans Test",
  token: "3d20e58a-42ce-4ee5-969f-15c58d5ff944"
)

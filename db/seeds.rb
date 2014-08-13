# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DEFAULT_PROPERTY_TYPES = [
  "Apartment",
  "House",
  "Bed & Breakfast",
  "Loft",
  "Cabin",
  "Villa",
  "Castle",
  "Dorm",
  "Treehouse",
  "Boat",
  "Plane",
  "Camper/RV",
  "Igloo",
  "Lighthouse",
  "Yurt",
  "Tipi",
  "Cave",
  "Island",
  "Chalet",
  "Earth House",
  "Hut",
  "Train",
  "Tent",
  "Other"
]

DEFAULT_PROPERTY_TYPES.each do |type|
  PropertyType.create(name: type)
end

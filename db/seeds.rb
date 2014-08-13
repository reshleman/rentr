# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DEFAULT_PROPERTY_CATEGORIES = [
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

DEFAULT_ROOM_CATEGORIES = [
  "Entire Home/Apartment",
  "Private Room",
  "Shared Room"
]

DEFAULT_PROPERTY_CATEGORIES.each do |category|
  PropertyCategory.create(name: category)
end

DEFAULT_ROOM_CATEGORIES.each do |category|
  RoomCategory.create(name: category)
end

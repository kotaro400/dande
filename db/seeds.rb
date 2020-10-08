# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Owner.create(uid: ENV["ENGINEER_UID"], password: ENV["ENGINEER_PWD"]) unless Owner.find_by(uid: ENV["ENGINEER_UID"])

Owner.create(uid: ENV["DESIGNER_UID"], password: ENV["DESIGNER_PWD"]) unless Owner.find_by(uid: ENV["DESIGNER_UID"])

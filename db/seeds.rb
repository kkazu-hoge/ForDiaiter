# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
customers = [
{ email: "test1@gmail.com",
password: "123456",
last_name: "テスト1",
first_name: "太郎",
public_name: "てすてす",
sex: 1,
birthday: "1992-09-28",
height: 177,
weight: 63 }
]
Customer.create(customers)

admins = [
{ email: "test1@gmail.com",
password: "123456"
}
]
Admin.create(admins)
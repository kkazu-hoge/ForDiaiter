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
sex: "man",
birthday: "1992-09-28",
height: 177,
weight: 63 }
]
Customer.create(customers)

admins = [
  { email: "test1@gmail.com",
  password: "123456"}
]
Admin.create(admins)


life_stress_factor = [
{ name: "ほぼ運動しない",coefficient: 1.2},
{ name: "軽い運動",coefficient: 1.375},
{ name: "中程度の運動",coefficient: 1.55},
{ name: "激しい運動",coefficient: 1.725},
{ name: "非常に激しい",coefficient: 1.9}
]
LifeStressFactor.create(life_stress_factor)

trainings = [
{ name: "腕立て伏せ",mets_value: 0.06,summary: ""},
{ name: "腹筋運動",mets_value: 0.05,summary: ""},
{ name: "懸垂",mets_value: 0.06,summary: ""},
{ name: "ヨガ：ハタ",mets_value: 0.03,summary: ""},
{ name: "ヨガ：パワー",mets_value: 0.06,summary: ""}
]
Training.create(trainings)
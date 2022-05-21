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
birthday: "1993-09-28",
height: 177,
weight: 65 }
]
Customer.create(customers)

admins = [
  { email: "test_admin@gmail.com",
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
{ name: "ヨガ：パワー",mets_value: 0.06,summary: ""},
{ name: "なわとび",mets_value: 0.21,summary: ""},
{ name: "ストレッチ",mets_value: 0.04,summary: ""},
{ name: "ピラティス",mets_value: 0.05,summary: ""},
{ name: "ジョギング",mets_value: 0.12,summary: ""},
{ name: "サーキットトレーニング",mets_value: 0.07,summary: ""}
]
Training.create(trainings)

# projects = [
# customer_id:2,
# life_stress_factor_id:2,
# sex:"man",
# age:28,
# height:165,
# weight:70,
# target_weight:68,
# pj_start_day:"2022-05-12",
# pj_finish_day:"2022-06-12",
# interval:3,
# name:"テストダイエット1"
# ]
# Project.create(projects)

# Project.create(customer_id:2, life_stress_factor_id:2, sex:"man", age:28, height:165, weight:70, target_weight:68, pj_start_day:"2022-05-12", pj_finish_day:"2022-06-12", interval:3, name:"テストダイエット1")


# pj_events = [
# { project_id:1, action_day:"2022-05-12"},
# { project_id:1, action_day:"2022-05-15"},
# { project_id:1, action_day:"2022-05-18"},
# { project_id:1, action_day:"2022-05-21"},
# { project_id:1, action_day:"2022-05-24"},
# { project_id:1, action_day:"2022-05-27"},
# { project_id:1, action_day:"2022-05-30"},
# { project_id:1, action_day:"2022-06-02"},
# { project_id:1, action_day:"2022-06-05"},
# { project_id:1, action_day:"2022-06-08"},
# { project_id:1, action_day:"2022-06-11"}
# ]
# PjEvent.create(pj_events)

# pj_event_details = [
#   {pj_event_id:1, training_id:2},
#   {pj_event_id:1, training_id:4},
#   {pj_event_id:2, training_id:2},
#   {pj_event_id:2, training_id:4},
#   {pj_event_id:3, training_id:2},
#   {pj_event_id:3, training_id:4},
#   {pj_event_id:4, training_id:2},
#   {pj_event_id:4, training_id:4},
#   {pj_event_id:5, training_id:2},
#   {pj_event_id:5, training_id:4},
#   {pj_event_id:6, training_id:2},
#   {pj_event_id:6, training_id:4},
#   {pj_event_id:7, training_id:2},
#   {pj_event_id:7, training_id:4},
#   {pj_event_id:8, training_id:2},
#   {pj_event_id:8, training_id:4},
#   {pj_event_id:9, training_id:2},
#   {pj_event_id:9, training_id:4},
#   {pj_event_id:10, training_id:2},
#   {pj_event_id:10, training_id:4},
#   {pj_event_id:11, training_id:2},
#   {pj_event_id:11, training_id:4},
# ]
# PjEventDetail.create(pj_event_details)

# plan_pj_events = [
# { project_id:1}
# ]
# PlanPjEvent.create(plan_pj_events)


# plan_pj_event_details = [
#   {plan_pj_event_id:1, training_id:2, activity_minutes: 10, burn_calories: 37},
#   {plan_pj_event_id:1, training_id:4, activity_minutes: 60, burn_calories: 132}
# ]
# PlanPjEventDetail.create(plan_pj_event_details)
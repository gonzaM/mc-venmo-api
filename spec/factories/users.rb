# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  full_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :user do
    email     { Faker::Internet.email }
    full_name { Faker::Name.name }
  end
end

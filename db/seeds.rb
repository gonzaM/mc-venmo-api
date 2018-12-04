# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
(1..10).each do |i|
  user = User.find_or_create_by!(email: "user_#{i}@email.com", full_name: "Full name #{1}")
  user.payment_account.update!(balance: i*10)
end


# Friends for 1
first_user = User.first
User.find_each do |user|
  next if user == first_user

  Friendship.find_or_create_by!(user_a: first_user, user_b: user)
  Payment.create!(
    amount: 100,
    description: 'Payment description',
    sender: first_user.reload,
    receiver: user
  )
end
# Friends for 2
second_user = User.second
[User.third, User.fourth].each do |user|
  Friendship.find_or_create_by!(user_a: second_user, user_b: user)
  Payment.create!(
    amount: 100,
    description: 'Payment description',
    sender: second_user.reload,
    receiver: user
  )
end

# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_a_id  :integer          not null
#  user_b_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_friendships_on_user_a_id  (user_a_id)
#  index_friendships_on_user_b_id  (user_b_id)
#

class Friendship < ApplicationRecord
  belongs_to :user_a, class_name: User.to_s
  belongs_to :user_b, class_name: User.to_s
end

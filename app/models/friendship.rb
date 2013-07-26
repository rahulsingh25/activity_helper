# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  status     :boolean          default(FALSE)
#

class Friendship < ActiveRecord::Base

	attr_accessible :friend_id,:status
	belongs_to :user
	belongs_to :friend, class_name:'User'

	validates :user_id, presence: true
	validates :friend_id, presence: true

	# has_many :messages, dependent: :destroy
	# has_many :inverse_messages, class_name:'Message', foreign_key:'friend_id'
end

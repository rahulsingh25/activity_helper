# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  message      :text
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  recipient_id :integer
#

class Message < ActiveRecord::Base

	attr_accessible :message, :recipient_id

	# belongs_to :friendship

	belongs_to :recipient, class_name: 'User'
	belongs_to :user

	validates :message, presence: true
	validates :recipient_id, presence: true
	validates :user_id, presence: true

	# validates :friendship_id, presence: true
end

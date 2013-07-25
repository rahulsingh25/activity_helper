class Message < ActiveRecord::Base

	attr_accessible :message, :user_id, :recipient_id

	# belongs_to :friendship

	belongs_to :recipient, class_name: 'User'
	belongs_to :user

	validates :message, presence: true
	validates :recipient_id, presence: true

	# validates :friendship_id, presence: true
end

class Comment < ActiveRecord::Base
	attr_accessible :content

	belongs_to :user
	belongs_to :activity

	validates :user_id, presence: true
	validates :activity_id, presence: true
	validates :content, presence: true

end

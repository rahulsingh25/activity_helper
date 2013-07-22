# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  activity_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
	attr_accessible :content

	belongs_to :user
	belongs_to :activity

	validates :user_id, presence: true
	validates :activity_id, presence: true
	validates :content, presence: true

	default_scope -> { order('created_at DESC') }

end

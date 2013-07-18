# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  category    :string(255)
#  name        :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Activity < ActiveRecord::Base
	attr_accessible :name, :description, :category
	
	validates :user_id, presence: true

	belongs_to :user
	has_many :comments

	default_scope -> { order('created_at DESC') }

	validates :description, presence: true, length: { maximum: 140 }

	validates :category, presence: true

	validates :name, presence: true
  	
end

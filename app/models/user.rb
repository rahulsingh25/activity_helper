# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  unconfirmed_email      :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :name, :username
  validates :name, length: {maximum:30}
  has_many :activities, dependent: :destroy

  VALID_USERNAME_REGEX = /\A[a-zA-Z]+((\_?[a-zA-Z0-9]+|[a-zA-Z0-9]*))*\z/i
  validates :username, presence: true, format: { with: VALID_USERNAME_REGEX }, uniqueness: { case_sensitive: false }
  before_save { self.username = username.downcase }


  def to_param
    username
  end
end

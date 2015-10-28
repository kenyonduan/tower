# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  email           :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :memberships
  has_many :teams, through: :memberships
  has_many :accesses
  has_many :projects, through: :accesses
  has_many :calendars, through: :accesses

  has_secure_password
end

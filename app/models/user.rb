class User < ActiveRecord::Base
  has_many :memberships
  has_many :teams, through: :memberships

  has_many :accesses
  has_many :projects, through: :accesses
end

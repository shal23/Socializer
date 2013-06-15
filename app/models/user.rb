class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_one :profile, :dependent => :destroy
  
  has_many :user_groups
  has_many :groups, :through => :user_groups
  has_many :status_updates
  
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  
  has_many :followed_users, :through => :relationships, :source => :followed
  
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy

  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  acts_as_voter

  # testing to see if user is in a group
  def is_member?(group)
    self.groups.include?(group)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(:followed_id => other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
end
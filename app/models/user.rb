class User < ActiveRecord::Base

  has_secure_password
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create

  has_many :books, dependent: :destroy
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_universal_and_determines_account
  has_one :member, :dependent => :destroy

  #users can have many projects, through their assigned tasks
  has_many :tasks
  has_many :projects, through: :tasks
  def is_admin?
  	is_admin
  end
end

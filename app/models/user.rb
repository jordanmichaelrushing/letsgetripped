class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :days, :dependent => :destroy
  has_many :exercises, :dependent => :destroy
  has_many :cardios, :dependent => :destroy
  has_one :super_challenge, :dependent => :destroy
  has_many :meals, :dependent => :destroy
  has_many :calf_crunches, :dependent => :destroy
  has_many :pushups, :dependent => :destroy
end

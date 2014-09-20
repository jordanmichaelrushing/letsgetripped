class Day < ActiveRecord::Base
  has_many :exercises, :dependent => :destroy
  has_one :cardio, :dependent => :destroy
  has_one :super_challenge, :dependent => :destroy
  has_many :meals, :dependent => :destroy
end

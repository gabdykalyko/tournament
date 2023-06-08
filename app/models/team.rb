class Team < ApplicationRecord
  validates :name, presence: true
  validates :division, presence: true
end

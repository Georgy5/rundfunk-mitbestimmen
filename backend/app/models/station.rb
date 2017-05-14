class Station < ApplicationRecord
  belongs_to :medium
  has_many :broadcasts
  attribute :name
  validates :medium, presence: true
end

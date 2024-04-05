class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) } # This scope will order the quotes by id in descending order
end

class Quote < ApplicationRecord
  belongs_to :company
  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) } # This scope will order the quotes by id in descending order

  # For Broadcasting on create, update and destroy
  # after_create_commit -> { broadcast_prepend_later_to "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" }
  # Those three callbacks are equivalent to the following single line
  # We use [quote.company, "quotes"] for security reasons, to avoid broadcasting to the wrong company channel
  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend
end

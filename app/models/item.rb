class Item < ApplicationRecord
  belongs_to :list


  validates :name, presence: true

  after_create_commit {broadcast_prepend_to "items"}
  after_update_commit {broadcast_replace_to "items" }
  after_destroy_commit {broadcast_remove_to "items"}


end

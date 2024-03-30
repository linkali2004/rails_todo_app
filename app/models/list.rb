class List < ApplicationRecord
   belongs_to :user
    validates :title, presence: true
    after_create_commit {broadcast_prepend_to "lists"}
    after_update_commit {broadcast_replace_to "lists" }
    after_destroy_commit {broadcast_remove_to "lists"}

    has_many :items , dependent: :destroy

    def isEmpty
        if self.items.count < 1
          true
        else
          false
        end
      end


    
end

class Conversation < ApplicationRecord
    belongs_to :sender, class_name: "Villager"
    belongs_to :receiver, class_name: "Villager"
    has_many :messages, dependent: :destroy

    validates_uniqueness_of :sender_id, scope: :receiver_id

    scope :between, -> (sender_id,receiver_id) do
        where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR (conversations.receiver_id = ? AND conversations.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
    end

    def recipient(current_user)
        self.sender_id == current_user.id ? self.receiver : self.sender
    end

    def unread_message_count(current_user)
        self.messages.where("villager_id != ? AND read = ?", current_user.id, false).count
    end

  end
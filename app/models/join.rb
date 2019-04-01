class Join < ApplicationRecord
  belongs_to :joinable, polymorphic: true
  belongs_to :user
end

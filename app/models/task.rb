class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  
  has_one_attached :image
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

end

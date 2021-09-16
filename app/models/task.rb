class Task < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'User', optional: true

  before_create :status_new

  delegate :full_name, to: :parent, prefix: true

  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }

  STATUS = [
    ['new', 1],
    ['in progress', 2],
    ['done', 3]
  ]

  def complete!
    self.status = 3
    save
  end

  private

  def status_new
    self.status = 1
  end
end

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'User', optional: true

  delegate :full_name, to: :parent, prefix: true

  validates :description, presence: true, length: { minimum: 10, maximum: 300 }
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }

  STATUSES = [
    NEW = 'new',
    IN_PROGRESS = 'in progress',
    DONE = 'done'
  ]

  def complete!
    update_column(:status, Task::DONE)
  end

  def task_done?
    status == Task::DONE
  end
end

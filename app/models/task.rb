class Task < ApplicationRecord
  belongs_to :user
  after_create :status_new

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

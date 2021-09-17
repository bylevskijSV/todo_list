module TasksHelper
  def status_color(status)
    {
      new: 'danger',
      in_progress: 'warning',
      done: 'success'
    }[status.to_sym]
  end
end

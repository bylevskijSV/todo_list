module TasksHelper
  def status_to_string(status)
    case status
    when 1
      Task::STATUS[0][0]
    when 2
      Task::STATUS[1][0]
    when 3
      Task::STATUS[2][0]
    end
  end

  def status_color(status)
    case status
    when 1
      'danger'
    when 2
      'warning'
    when 3
      'success'
    end
  end
end

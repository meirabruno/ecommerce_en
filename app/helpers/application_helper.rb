# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level
    when 'success' then 'alert alert-success'
    when 'danger' then 'alert alert-danger'
    end
  end
end

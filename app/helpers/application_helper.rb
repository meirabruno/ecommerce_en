# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    return 'alert alert-danger' if level == 'danger'

    'alert alert-success'
  end

  def product_status(status)
    return I18n.t('views.active') if status == 'active'

    I18n.t('views.draft')
  end

  def status_class(status)
    return 'badge bg-success' if status == 'active'

    'badge bg-secondary'
  end

  def tab_all_class(status)
    'active' if status.blank?
  end

  def tab_active_class(status)
    'active' if status == 'active'
  end

  def tab_draft_class(status)
    'active' if status == 'draft'
  end

  def old_price_class(product)
    return 'text-success' if product.comparation_price.blank?

    'text-secondary text-decoration-line-through'
  end
end

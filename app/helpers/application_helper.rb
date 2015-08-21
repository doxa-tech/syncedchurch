module ApplicationHelper

  def options_for_enum(model, enum)
    options_for_select(model.send(enum).map {|k, v| [ t("#{model.to_s.downcase}.#{enum}.#{k}"), k ]})
  end

end

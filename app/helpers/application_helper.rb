module ApplicationHelper

  def options_for_enum(record, enum)
    model = record.class
    pluralized_enum = enum.to_s.pluralize
    options_for_select(model.send(pluralized_enum).map {|k, v| [ t("#{model.to_s.downcase}.#{pluralized_enum}.#{k}"), k ]}, record.send(enum))
  end

end

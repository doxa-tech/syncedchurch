module ApplicationHelper

  def options_for_enum(record, enum)
    model = record.class
    pluralized_enum = enum.to_s.pluralize
    options_for_select(model.send(pluralized_enum).map {|k, v| [ t("#{model.model_name.i18n_key}.#{pluralized_enum}.#{k}"), k ]}, record.send(enum))
  end

  def active_link_to(text, link, route, options = {})
    controller, action = route.split("#")
    if controller == request.params[:controller]
      options[:class] = "active" if request.params[:action] == action || action == nil
    end
    link_to(text, link, options)
  end

  def active_block(route, options = {}, &block)
    controller, action = route.split("#")
    if controller == request.params[:controller]
      options[:class] = "active" if request.params[:action] == action || action == nil
    end
    content_tag(:div, options, &block)
  end

end

class DefaultFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    if block_given?
      super(method, text, options) { |l| block.call("<span class=\"label\">#{l.translation}</span>".html_safe) }
    else
      super
    end
  end

  def datepicker_field(method, position=nil)
    value = object.send(method)
    value = I18n.l(value, format: :datepicker) if value && datetime?(value)
    text_field method, class: "date picker #{position}", value: value
  end

  def timepicker_field(method, position=nil)
    value = object.send(method)
    value = I18n.l(object.send(method), format: :timepicker) if value && datetime?(value)
    text_field method, class: "time picker #{position}", value: value
  end

  private

  def datetime?(object)
    object.is_a?(Date) || object.is_a?(DateTime) || object.is_a?(Time)
  end
end

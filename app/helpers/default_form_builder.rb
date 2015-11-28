class DefaultFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    if block_given? 
      super(method, text, options) { |l| block.call("<span class=\"label\">#{l.translation}</span>".html_safe) }
    else
      super
    end
  end
end
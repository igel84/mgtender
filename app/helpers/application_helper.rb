#encoding: utf-8
module ApplicationHelper
  
  def build_span_tender_name(tender)
    html_classes = []
    html_classes << 'type-tn'
    html_classes << 'blue-bg' if tender.tender_type.is_name?(:tender)
    html_classes << 'green-bg' if tender.tender_type.is_name?(:auction)
    html_classes << 'red-bg' if tender.tender_type.is_name?(:review)
    content_tag(:span, tender.tender_type.short_name_ru , :class => html_classes) # => <div class="some another">Text</div>
  end

  def build_span_tender_status(tender)
    text = case tender.status
      when 0
        'Черновик'
      when 1
        'Активен'
      when 2
        'Завершен'
    end    
    html_classes = []
    html_classes << 'blue'
    content_tag(:span, text, :class => html_classes) # => <div class="some another">Text</div>
  end

end

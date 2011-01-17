# depends on i18n_multi_locales_form plugin
# rails plugin install https://github.com/ZenCocoon/i18n_multi_locales_form.git
module MultiLocaleFieldBuilder
  def multi_locale_field(method, opts = {})
    opts = {
      :type   => :text_field
    }.merge(opts)

    type = opts.delete(:type)

    html = []

    I18n.available_locales.each do |locale|
      html << self.send(type, method, opts.merge(:locale => locale, :title => locale.to_s.upcase)) + " " + locale.to_s.upcase
    end

    html.join('<br />').html_safe
  end
end

ActionView::Helpers::FormBuilder.send(:include, MultiLocaleFieldBuilder)

# reorganise the flash to work with bootstrap
module BootstrapHelper
  def flash_map(flashes = {})
    # devise can insert flashes with some other keys e.g. :timedout. We ignore these.

    # map from devise to bootstrap names
    devise_bootstrap = {notice: 'success', alert: 'danger', error: 'danger', secondary: 'warning'}

    closer = button_tag(escape_once("&times;"), class: 'close', data: {dismiss: 'alert'}, 'aria-hidden' => true)

    content = []
    flashes.each do |kind, message|
      sym = kind.to_sym

      # not all the flashes have the struture that bootstrap uses, skip those
      next unless devise_bootstrap.has_key?(sym)

      style = devise_bootstrap.fetch(sym, 'info')

      fragment = content_tag(:div, message, class: "alert alert-#{style} alert-dismissable", data: {alert: ''}) do
        (message + closer).html_safe
      end

      content << fragment
    end
    
    content.join.html_safe
  end
end

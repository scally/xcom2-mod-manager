module NSMenuItemExtends
  def create params={}
    new.tap do |item|
      item.title = params[:title] if params[:title]
      item.action = params[:action] if params[:action]
      item.setState NSOnState if params[:enabled]
    end
  end

  def title_version
    create title: "#{'CFBundleDisplayName'.info_plist} #{'CFBundleShortVersionString'.info_plist}"
  end

  def quit
    create title: 'Quit', action: 'terminate:'
  end
end

module NSMenuItemIncludes
  def checked?
    state == 1
  end

  def toggle
    self.state = checked? ? 0 : 1
  end
end

NSMenuItem.class_eval do
  extend NSMenuItemExtends
  include NSMenuItemIncludes
end

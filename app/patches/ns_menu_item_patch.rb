module NSMenuItemPatch
  def create params={}
    new.tap do |item|
      item.title = params[:title] if params[:title]
      item.action = params[:action] if params[:action]
      item.setState NSOnState if params[:enabled]
    end
  end
end

NSMenuItem.class_eval do
  extend NSMenuItemPatch
end

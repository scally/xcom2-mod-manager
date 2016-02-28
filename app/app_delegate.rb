class AppDelegate
  def applicationDidFinishLaunching notification
    @library = ModLibrary.new

    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength NSVariableStatusItemLength
    @status_item.setHighlightMode false
    @status_item.setTitle 'xc2mods'
    @status_item.setTarget self
    @status_item.setMenu create_mods_menu
  end

  def create_mods_menu
    NSMenu.new.tap do |menu|
      menu.initWithTitle ''

      @library.all.each do |mod|
        menu.addItem(NSMenuItem.new.tap do |item|
          item.title = mod.name
          item.action = 'clicked_menu_bar:'
          item.setState(NSOnState) if mod.enabled
        end)
      end

      menu.addItem(NSMenuItem.new.tap do |item|
        item.title = '---'
      end)

      menu.addItem(NSMenuItem.new.tap do |item|
        item.title = "version #{"CFBundleShortVersionString".info_plist}"
      end)

      menu.addItem(NSMenuItem.new.tap do |item|
        item.title = 'Quit xc2mod manager'
        item.action = 'terminate:'
      end)
    end
  end

  def clicked_menu_bar item
    item.state = item.state == 1 ? 0 : 1
    if item.state == 1
      @library.enable item.title
    else
      @library.disable item.title
    end
  end
end

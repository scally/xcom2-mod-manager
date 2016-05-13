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

      menu.addItem NSMenuItem.title_version
      menu.addItem NSMenuItem.create title: 'Enable All', action: 'enable_all:'
      menu.addItem NSMenuItem.create title: 'Disable All', action: 'disable_all:'
      menu.addItem NSMenuItem.quit
      menu.addItem NSMenuItem.separatorItem

      @library.all.each do |mod|
        menu.addItem NSMenuItem.create(title: mod.name, action: 'clicked_menu_bar:', enabled: mod.enabled)
      end
    end
  end

  def enable_all item
    @library.enable_all
    @library.all.each do |mod|
      @status_item.menu.itemWithTitle(mod.name).state = 1
    end
  end

  def disable_all item
    @library.disable_all
    @library.all.each do |mod|
      @status_item.menu.itemWithTitle(mod.name).state = 0
    end
  end

  def version
    'CFBundleShortVersionString'.info_plist
  end

  def clicked_menu_bar item
    item.toggle
    @library.toggle item.title
  end
end

class ModLibrary
  def initialize
    @installed_mods = InstalledMods.new
    @available_mods = AvailableMods.new
  end

  def all
    @available_mods.all.sort.map do |name|
      Mod.new name: name, enabled: @installed_mods.include?(name)
    end
  end

  def toggle mod_name
    @installed_mods.toggle mod_name
  end

  def enable_all
    @installed_mods.enable_all @available_mods.all
  end

  def disable_all
    @installed_mods.disable_all
  end
end

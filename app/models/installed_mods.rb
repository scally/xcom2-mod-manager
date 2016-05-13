class InstalledMods
  def initialize
    @ini = Ini.new
    @installed_mods = @ini.all
  end

  def all
    @installed_mods.uniq.compact.sort
  end

  def include? mod_name
    all.include? mod_name
  end

  def toggle mod_name
    if include? mod_name
      @installed_mods.delete_if { |mod| mod == mod_name }
    else
      @installed_mods << mod_name
    end
    save
  end

  def enable_all mods
    @installed_mods += mods
    @installed_mods.uniq!
    save
  end

  def disable_all
    @installed_mods.clear
    save
  end

  def save
    @ini.save @installed_mods
  end
end

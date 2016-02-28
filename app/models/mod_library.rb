class ModLibrary
  def initialize
    @ini = NSDictionary.og_dictionaryWithContentsOfIniFile mod_ini_path
    @installed_mods = @ini['Engine.XComModOptions']['ActiveMods']
  end

  def all
    get_mod_name_list.sort.map do |name|
      Mod.new name: name, enabled: installed_mods.include?(name)
    end
  end

  def enable mod_name
    @installed_mods << mod_name
    write_mods
  end

  def disable mod_name
    @installed_mods.delete_if { |mod| mod == mod_name }
    write_mods
  end

  def write_mods
    NSFileManager.defaultManager.setAttributes({'NSFileImmutable' => 0}, ofItemAtPath: mod_ini_path, error: nil)
    @installed_mods.sort!
    data = @ini.og_iniFileData
    data.write_to mod_ini_path
    NSFileManager.defaultManager.setAttributes({'NSFileImmutable' => 1}, ofItemAtPath: mod_ini_path, error: nil)
  end

  def installed_mods
    @installed_mods.uniq.compact.sort
  end

  def mod_root_path
    '~/Library/Application Support/Steam/steamapps/workshop/content/268500'.stringByExpandingTildeInPath
  end

  def mod_ini_path
    '~/Library/Application Support/Feral Interactive/XCOM 2/VFS/Local/my games/XCOM2/XComGame/Config/XComModOptions.ini'.stringByExpandingTildeInPath
  end

  def get_mod_directory_list
    NSFileManager.defaultManager.contentsOfDirectoryAtPath mod_root_path, error: nil
  end

  def get_mod_name_list
    get_mod_directory_list.map do |directory|
      files = NSFileManager.defaultManager.contentsOfDirectoryAtPath mod_root_path.stringByAppendingPathComponent(directory), error: nil
      next unless files && files.any?
      files.grep(/xcommod/i).first.split('.').first
    end.compact
  end
end

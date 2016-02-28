class ModLibrary
  def initialize
    @ini = NSDictionary.og_dictionaryWithContentsOfIniFile mod_ini_path
    @installed_mods = @ini['Engine.XComModOptions']['ActiveMods']
  end

  def all
    AvailableMods.new.all.sort.map do |name|
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
    unlock_mod_file
    @installed_mods.sort!
    @ini.og_iniFileData.write_to mod_ini_path
    lock_mod_file
  end

  def lock_mod_file
    NSFileManager.defaultManager.setAttributes({'NSFileImmutable' => 1}, ofItemAtPath: mod_ini_path, error: nil)
  end

  def unlock_mod_file
    NSFileManager.defaultManager.setAttributes({'NSFileImmutable' => 0}, ofItemAtPath: mod_ini_path, error: nil)
  end

  def installed_mods
    @installed_mods.uniq.compact.sort
  end

  def mod_ini_path
    File.expand_path '~/Library/Application Support/Feral Interactive/XCOM 2/VFS/Local/my games/XCOM2/XComGame/Config/XComModOptions.ini'
  end
end

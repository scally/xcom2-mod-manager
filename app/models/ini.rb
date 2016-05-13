class Ini
  def initialize
    @ini = load_from_file || self.class.empty
    @ini['Engine.XComModOptions'] = @ini['Engine.XComModOptions'].dup
    @ini['Engine.XComModOptions']['ActiveMods'] ||= []
    @ini['Engine.XComModOptions']['ActiveMods'] = Array(@ini['Engine.XComModOptions']['ActiveMods'])
  end

  def load_from_file
    NSDictionary.og_dictionaryWithContentsOfIniFile(mod_ini_path).dup
  end

  def all
    @ini['Engine.XComModOptions']['ActiveMods'].dup
  end

  def save mods
    unlock_mod_file
    @ini['Engine.XComModOptions']['ActiveMods'] = Array(mods.sort)
    @ini.og_iniFileData.write_to mod_ini_path
    lock_mod_file
  end

  def lock_mod_file
    NSFileManager.defaultManager.setAttributes({'NSFileImmutable' => 1}, ofItemAtPath: mod_ini_path, error: nil)
  end

  def unlock_mod_file
    NSFileManager.defaultManager.setAttributes({'NSFileImmutable' => 0}, ofItemAtPath: mod_ini_path, error: nil)
  end

  def mod_ini_path
    File.expand_path '~/Library/Application Support/Feral Interactive/XCOM 2/VFS/Local/my games/XCOM2/XComGame/Config/XComModOptions.ini'
  end

  def self.empty
    {'Engine.XComModOptions' => {'ActiveMods' => []}}
  end
end

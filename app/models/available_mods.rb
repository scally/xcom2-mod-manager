class AvailableMods
  def all
    Dir[File.join(mod_root_path, '*')].map do |directory|
      files = Dir.glob(File.join(directory, '*.xcommod'), File::FNM_CASEFOLD)
      next unless files.any?
      File.basename files.first, '.*'
    end.compact
  end

  def mod_root_path
    File.expand_path '~/Library/Application Support/Steam/steamapps/workshop/content/268500'
  end
end

class Mod
  attr_reader :name, :enabled

  def initialize params={}
    @name = params.fetch :name
    @enabled = params.fetch :enabled, false
  end
end

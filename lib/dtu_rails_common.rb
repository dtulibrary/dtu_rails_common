require "dtu_rails_common/engine"

Gem.loaded_specs['dtu_rails_common'].dependencies.each do |d|
  begin
    require d.name
  rescue LoadError
  end
end

module DtuRailsCommon
end

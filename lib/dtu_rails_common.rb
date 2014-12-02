require "dtu_rails_common/engine"

Gem.loaded_specs['dtu_rails_common'].runtime_dependencies.each do |d|
  require d.name
end

module DtuRailsCommon
end

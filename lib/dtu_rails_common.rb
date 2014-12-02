require "dtu_rails_common/engine"

Gem.loaded_specs['dtu_rails_common'].dependencies.each do |d|
  require d.name
end

module DtuRailsCommon
end

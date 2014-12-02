require "dtu_rails_common/engine"
require 'byebug'

Gem.loaded_specs['dtu_rails_common'].dependencies.each do |d|
  begin
    require d.name
  rescue LoadError
  end
end

module DtuRailsCommon
end

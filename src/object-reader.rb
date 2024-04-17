# frozen_string_literal: true

require 'sketchup.rb'
require 'extensions.rb'

module ObjectReader

  unless file_loaded?(__FILE__)
    ex = SketchupExtension.new('Object Reader', 'object-reader/bootstrap')
    ex.description = 'A simple Sketchup plugin that saves information about selected objects into a JSON file.'
    ex.version     = '1.0.0'
    ex.copyright   = 'Martin Vuk'
    ex.creator     = 'Martin Vuk'
    Sketchup.register_extension(ex, true)
    file_loaded(__FILE__)
  end
end

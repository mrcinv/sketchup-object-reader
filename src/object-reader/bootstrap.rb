# frozen_string_literal: true

require_relative 'read_selected_objects'
module ObjectReader
  # Initialize plugin when the Sketchup is started. This function loads the plugin
  # at Sketchup startup. It adds an entry to the menu and creates an icon in the toolbar.
  def self.initialize_plugin
    cmd = read_selected_object_command
    ext_menu = UI.menu
    plugin_menu = ext_menu.add_submenu("Object reader")
    plugin_menu.add_item("Save to JSON") { ReadSelectedObjects.run }
    toolbar = UI.toolbar("ObjectReader")
    toolbar.add_item(cmd)
  end
end

# Do the initialization of the plugin
ObjectReader.initialize_plugin
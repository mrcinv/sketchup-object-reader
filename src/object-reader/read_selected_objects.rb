# frozen_string_literal: true

require 'json'
require_relative 'constants'
require_relative 'readers'

module ObjectReader
  # The command that will read the selected objects and save them to a JSON file
  class ReadSelectedObjects
    class << self
      # Run the command and do the tasks it needs to perform. This method will read the information about
      # the objects that are selected in Sketchup and save that information into the JSON file.
      def run
        model = Sketchup.active_model
        info = Readers.read_selection(model.selection)
        if info.empty?
          UI.messagebox("No selected entities. Please select entities before saving the information", MB_OK)
          return
        end
        file = json_filename(model)
        path = UI.openpanel("Select where to save the information about selected entities!",
                            file && File.dirname(file), file && File.basename(file))
        return unless path
        save!(info, path)
        UI.messagebox("Information was saved to #{path}", MB_OK)
      end

      # @param model [Sketchup::Model] the model to construct the name for.
      # @return [String, nil] the name of the JSON file to save the data into.
      def json_filename(model)
        path = model.path
        return nil if path.empty?

        basename = File.basename(path, ".skp")
        File.join(File.dirname(path), "#{basename}.json")
      end

      # Save the information about the objects into the given filename.
      # @param info [Hash, Array] an object that contains the info about the selected entities.
      #  The object should be of the class, that can be transformed to JSON.
      # @param filepath [String] the path where to save the JSON.
      # @return [Integer] the number of bytes that were written to the file.
      def save!(info, filepath)
        File.write(filepath, JSON.pretty_generate(info))
      end
    end
  end

  # Create tje command for reading info about selected files and saving it to the JSON file.
  # @return [UI::Command] the command object that can be added to the menu or toolbar.
  def self.read_selected_object_command
    cmd = UI::Command.new("Write to JSON") do
      ReadSelectedObjects.run
    end
    cmd.tooltip="Write information about selected objects to Sketchup."
    icon_path = File.join(PLUGIN_PATH, "icons", "saveJSON.svg")
    cmd.large_icon = icon_path
    cmd.small_icon = icon_path
    cmd
  end
end
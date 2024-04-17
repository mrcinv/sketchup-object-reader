# frozen_string_literal: true

require 'json'

module ObjectReader
  # The command that will read the selected objects and save them to a JSON file
  class ReadSelectedObjects
    class << self
      # Run the command and do the tasks it needs to perform. This method will read the information about
      # the objects that are selected in Sketchup and save that information into the JSON file.
      def run
        info = read(Sketchup.active_model.selection)
        file = json_filename(Sketchup.active_model)
        save!(info, file)
      end

      # @param model [Sketchup::Model] the model to construct the name for.
      # @return [String] the name of the JSON file to save the data into.
      def json_filename(model)
        path = model.path
        basename = File.basename(path, ".skp")
        File.join(File.dirname(path), "#{basename}.json")
      end

      # Save the information about the objects into the given filename.
      def save!(info, file)
        File.write(file, JSON.pretty_generate(info))
      end
    end
  end

  # Create tje command for reading info about selected files and saving it to the JSON file.
  # @return [UI::Command] the command object that can be added to the menu or toolbar.
  def read_selected_object_command
    UI::Command.new("Write selected objects to JSON") do
      ReadSelectedObjects.run
    end
  end
end
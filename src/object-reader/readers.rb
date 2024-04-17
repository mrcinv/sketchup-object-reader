# frozen_string_literal: true

module ObjectReader
  # This module contains the classes that can get information from different types of Sketchup objects.
  module Readers
    # The general class that can get information common to all Sketchup entities.
    class EntityReader
      class << self
        # Read the information about the given entity and return it in a structured way,
        # @param sketchup_entity [Sketchup::Entity] the Sketchup entity to be read
        # @return [Hash{Symbol => Object}] the information about the given entity.
        def read_entity(sketchup_entity)
          klass = sketchup_entity.class.name
          # Deleted entities can not be queried
          return { type: klass, deleted: true } if sketchup_entity.deleted?

          {
            type: klass,
            persistent_id: sketchup_entity.persistent_id,
            deleted: false
          }
        end
      end
    end

    # The class that gets the information for Sketchup group.
    class GroupReader
      class << self
        # Read the information about the given entity and return it in a structured way,
        # @param sketchup_group [Sketchup::Group] the Sketchup entity to be read
        # @return [Hash{Symbol => Object}] the information about the given entity.
        def read_entity(sketchup_group)

          entity_info = EntityReader.read_entity(sketchup_group)
          return entity_info if sketchup_group.deleted?

          children_info = sketchup_group.entities.collect do |entity|
            Readers.read_entity(entity)
          end
          entity_info[:children] = children_info
          entity_info
        end
      end
    end

    # A dictionary of entity readers indexed by the class of the entity.
    READERS = {
      Sketchup::Group => GroupReader
    }

    # Read the information about the given entity and return it in a structured way,
    # @param sketchup_entity [Sketchup::Entity] the Sketchup entity to be read
    # @return [Hash{Symbol => Object}] the information about the given entity.
    # @example
    #   # read the first selected object
    #   ObjectReader.ObjectReaders.read_entity(Sketchup.active_model.selection[0])
    def self.read_entity(sketchup_entity)
      reader = READERS[sketchup_entity.class] || EntityReader
      reader.read_entity(sketchup_entity)
    end

    # Read the Sketchup selection and return the information about the selected objects.
    # @param [Sketchup::Selection] the selection in the Sketchup model
    # @return [Array<Hash{Symbol=> Object}>] the array with information about the entities in the selection.
    def self.read_selection(selection)
      selection.collect do |entity|
        read_entity(entity)
      end
    end
  end
end
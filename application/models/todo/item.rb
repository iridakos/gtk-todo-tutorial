require 'securerandom'
require 'json'

module Todo
  class Item
    PROPERTIES = [:id, :title, :notes, :priority, :filename, :creation_datetime].freeze

    PRIORITIES = ['high', 'medium', 'normal', 'low'].freeze

    attr_accessor *PROPERTIES

    def initialize(options = {})
      if user_data_path = options[:user_data_path]
        # New item. When saved, it will be placed under the :user_data_path value
        @id = SecureRandom.uuid
        @creation_datetime = Time.now.to_s
        @filename = "#{user_data_path}/#{id}.json"
      elsif filename = options[:filename]
        # Load an existing item
        load_from_file filename
      else
        raise ArgumentError, 'Please specify the :user_data_path for new item or the :filename to load existing'
      end
    end

    # Loads an item from a file
    def load_from_file(filename)
      properties = JSON.parse(File.read(filename))

      # Assign the properties
      PROPERTIES.each do |property|
        self.send "#{property}=", properties[property]
      end
    rescue => e
      raise ArgumentError, "Failed to load existing item: #{e.message}"
    end

    # Resolves if an item is new
    def is_new?
      !File.exists? @filename
    end

    # Saves an item to its `filename` location
    def save!
      File.open(@filename, 'w') do |file|
        file.write self.to_json
      end
    end

    # Deletes an item
    def delete!
      raise 'Item is not saved!' if is_new?

      File.delete(@filename)
    end

    # Produces a json string for the item
    def to_json
      result = {}
      PROPERTIES.each do |prop|
        result[prop] = self.send prop
      end

      result.to_json
    end
  end
end

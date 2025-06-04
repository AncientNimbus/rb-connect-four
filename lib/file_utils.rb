# frozen_string_literal: true

require "yaml"
require "json"

# Filer operations helper module
# @author Ancient Nimbus
# @version 0.2.0
module FileUtils
  class << self
    # Return the root path.
    # @return [String] project root path
    def proj_root
      @proj_root ||= File.expand_path("../", __dir__)
    end

    # Return cross-system friendly filename.
    # @param filename [String]
    # @return [String] Formatted filename
    def formatted_filename(filename)
      filename.downcase.tr(" ", "_")
    end

    # Return the full path of a specific file.
    # @param filename [String]
    # @param *dirs [Array<String>] `filepath("en", ".config", "locale")` will return <root...>/.config/locale/en
    def filepath(filename, *dirs)
      File.join(proj_root, *dirs, filename)
    end

    # Check if a file exist in the given file path.
    # @param filepath [String]
    # @param use_filetype [Boolean]
    # @param default_type [String]
    def check_file?(filepath, use_filetype: true, default_type: ".yml")
      default_type = "" unless use_filetype
      filepath += default_type
      File.exist?(filepath)
    end

    # Load file in YAML or JSON format.
    # @param filepath [String] the base path of the file to write (extension is added automatically).
    # @param format [Symbol] set target file format, default: `:yml`
    # @param symbols [Boolean] set whether to use symbols as key, default: true
    # @return [Hash]
    def load_file(filepath, format: :yml, symbols: true)
      filepath += format == :yml ? ".yml" : ".json"
      return puts "File not found: #{filepath}" unless File.exist?(filepath)

      File.open(filepath, "r") do |str|
        data = if format == :yml
                 YAML.safe_load(str, permitted_classes: [Time, Symbol], aliases: true, freeze: true)
               else
                 JSON.parse(str.read)
               end
        return symbols ? to_symbols(data) : data
      end
    end

    # Convert string keys to symbol keys.
    # @param obj [Object]
    # @return [Hash]
    def to_symbols(obj)
      case obj
      when Hash
        obj.transform_keys(&:to_sym).transform_values { |v| to_symbols(v) }
      when Array
        obj.map { |e| to_symbols(e) }
      else
        obj
      end
    end
  end
end

filename = FileUtils.formatted_filename("debug en")
path = FileUtils.filepath(filename, ".config", "locale")
p FileUtils.load_file(path)
p FileUtils.load_file(path, format: :json)

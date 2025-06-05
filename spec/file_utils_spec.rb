# frozen_string_literal: true

require_relative "../lib/file_utils"

F = FileUtils

describe FileUtils do
  describe "#proj_root" do
    it "returns the full path of the project directory" do
      local_path = File.expand_path("../", __dir__)
      expect(F.proj_root).to eq(local_path)
    end
  end

  describe "#formatted_filename" do
    context "when the value contains a single word" do
      it "returns the same word if the word is lowercase" do
        filename = "enterprise"
        expect(F.formatted_filename(filename)).to eq("enterprise")
      end

      it "returns the word in lowercase if it contains uppercase characters" do
        filename = "Defiant"
        expect(F.formatted_filename(filename)).to eq("defiant")
      end
    end

    context "when the value contains multiple words" do
      it "returns a value where whitespaces are replaced with underscores if all words are lowercase" do
        filename = "deep space nine"
        expect(F.formatted_filename(filename)).to eq("deep_space_nine")
      end

      it "returns a lowercase value where whitespaces are replaced with underscores if the value contains uppercase characters" do
        filename = "Bird of Prey"
        expect(F.formatted_filename(filename)).to eq("bird_of_prey")
      end
    end

    context "when the value contains forbidden characters" do
      it "raises an argument error" do
        filename = "Bad<|/:|>+===N'amE"
        expect { F.formatted_filename(filename) }.to raise_error(ArgumentError, "Forbidden character detected")
      end
    end
  end

  describe "#filepath" do
    local_path = File.expand_path("../", __dir__)
    filename = "emh.md"

    context "when the argument only contains the filename" do
      it "returns the full project filepath" do
        filepath = "#{local_path}/#{filename}"
        expect(F.filepath(filename)).to eq(filepath)
      end
    end

    context "when the argument contains the filename and one dir argument" do
      it "returns the full project filepath" do
        subfolder = "sys"
        filepath = "#{local_path}/#{subfolder}/#{filename}"
        expect(F.filepath(filename, subfolder)).to eq(filepath)
      end
    end

    context "when the argument contains the filename and multiple dir arguments" do
      it "returns the full project filepath" do
        subfolder1 = "officers"
        subfolder2 = "science"
        filepath = "#{local_path}/#{subfolder1}/#{subfolder2}/#{filename}"
        expect(F.filepath(filename, subfolder1, subfolder2)).to eq(filepath)
      end
    end
  end

  describe "#check_file?" do
  end

  describe "#load_file" do
  end

  describe "#to_symbols" do
  end

  describe "#get_string" do
  end

  describe "#s" do
  end
end

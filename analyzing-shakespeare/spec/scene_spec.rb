require "spec_helper"

RSpec.describe Scene do
  let(:xml) { load_fixture('scene.xml') }
  let(:scene) { Scene.create_from_xml(xml) }

  describe "#speeches" do
    it "should find one speech for each speech in the scene" do
      expect(scene.speeches.count).to eq 9
    end
  end

  describe "#speakers" do
    it "should have one speaker for each unique speaker in the play" do
      expect(scene.speakers.count).to eq 3
    end

    it "should have the lines for each speaker" do
      lines = ["When shall we three meet again",
               "In thunder, lightning, or in rain?", "Where the place?",
               "I come, Graymalkin!"]
      expect(scene.speakers.first).to eq ["First Witch", lines]
    end
  end
end

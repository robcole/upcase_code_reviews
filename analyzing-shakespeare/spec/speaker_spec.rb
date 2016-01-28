require "spec_helper"

RSpec.describe Speaker do
  let(:play) { Play.create_from_xml(xml) }
  let(:xml) { load_fixture('macbeth.xml') }

  # magic values for tests from "golden master" answers - https://goo.gl
  describe ".create_speakers" do
    it "accepts scenes and outputs the speakers and lines for those scenes" do
      speakers = Speaker.create_speakers_from_scenes(play.scenes)
      expect(speakers.count).to eq 40
    end

    it "should have the correct number of lines for the speaker" do
      first_witch = play.speakers.first
      expect(first_witch[1].count).to eq 62
    end
  end
end

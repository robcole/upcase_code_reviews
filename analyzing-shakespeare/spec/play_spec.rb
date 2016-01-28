require "spec_helper"

RSpec.describe Play do
  let(:play_xml) { load_fixture('macbeth.xml') }
  let(:play) { Play.create_from_xml(play_xml) }

  describe "#create_from_xml" do
    it "should convert the play into a new Play instance" do
      expect(play).to be_a Play
    end
  end

  describe "#scenes" do
    it "should have one scene for each scene in the play" do
      expect(play.scenes.count).to eq 28
    end
  end
end

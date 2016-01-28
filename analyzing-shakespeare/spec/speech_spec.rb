require "spec_helper"

RSpec.describe Speech do
  let(:xml) { load_fixture('speech.xml') }
  let(:speech) { Speech.create_from_xml(xml) }

  describe "#lines" do
    it "should find one line for each line in the speech" do
      expect(speech.lines.count).to eq 11
    end

    it "should identify the speaker" do
      expect(speech.speaker).to eq "ROSS"
    end
  end

  describe "#said_by_all?" do
    context "when it was said by a speaker"
    it "should determine if the speech was said by ALL" do
      expect(speech.said_by_all?).to be_falsey
    end
  end

  context "when it was said by all" do
    it "should determine if the speech was said by ALL" do
      all_fixture = load_fixture('speech_by_all.xml')
      all_speech = Speech.create_from_xml(all_fixture)
      expect(all_speech.said_by_all?).to be_truthy
    end
  end
end

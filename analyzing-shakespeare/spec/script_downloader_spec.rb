require "spec_helper"

RSpec.describe ScriptDownloader do
  describe ".run!" do
    let(:mock_xml) { "<MOCKBETH></MOCKBETH>" }

    it "should not open an invalid url" do
      expect do
        ScriptDownloader.run!(url: "/etc/passwd")
      end.to raise_error("URL is not of HTTP type.")
    end

    it "should attempt to download a valid url" do
      url = Shakespeare::Base.default_url
      parsed_url = URI.parse(url)
      loaded_file = instance_double("TempFile")
      allow(loaded_file).to receive(:read).and_return(mock_xml)
      allow(ScriptDownloader).to receive(:default_url).and_return(url)
      expect(Net::HTTP).to receive(:get).with(parsed_url) { loaded_file }
      ScriptDownloader.run!(url: url)
    end

    it "should attempt to save a successful xml download" do
      fixture_path = Shakespeare::Base.fixture_path('macbeth.xml')
      allow(ScriptDownloader).to receive(:read_xml_url).and_return(mock_xml)
      args = [fixture_path, "w"]
      mock_file = instance_double("File")
      expect(File).to receive(:open).with(*args).and_yield(mock_file)
      expect(mock_file).to receive(:write).with(mock_xml)
      ScriptDownloader.run!(save_fixture: true)
    end
  end
end

module Shakespeare
  module Utils
    def parse_xml(xml_body)
      Nokogiri::XML(xml_body) do |config|
        config.strict.nonet
      end
    end

    def default_url
      "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    end

    def fixture_path(filename)
      File.expand_path("../../spec/fixtures/#{filename}", __FILE__)
    end

    # LineCount SpeakerName
    def display_speaker(speaker)
      puts "#{speaker[1].count} #{speaker[0]}"
    end

    def load_fixture(filename)
      filename_with_path = Shakespeare::Base.fixture_path(filename)
      File.open(filename_with_path)
    end
  end
end

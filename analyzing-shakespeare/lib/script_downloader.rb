class ScriptDownloader
  def self.run!(url: nil, save_fixture: false)
    xml = read_xml_url(url)
    save_fixture ? save_file!(xml) : xml
  end

  def self.read_xml_url(url)
    url ||= Shakespeare::Base.default_url
    url = URI.parse(url)
    Net::HTTP.get(url)
  rescue
    raise TypeError, "URL is not of HTTP type."
  end

  def self.save_file!(xml, filename = 'macbeth.xml')
    file_with_path = Shakespeare::Base.fixture_path(filename)
    File.open(file_with_path, "w") { |f| f.write(xml) }
  end
end

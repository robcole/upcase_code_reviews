require_relative './shakespeare_utils'
module Shakespeare
  class Base
    extend Shakespeare::Utils

    def self.create_from_xml(xml)
      @parsed_xml = parse_xml(xml)
      new(@parsed_xml)
    end

    private

    def parsed_xml
      @parsed_xml
    end

    def initialize(parsed_xml)
      @parsed_xml = parsed_xml
    end

    def create_subitems(klass, xpath_finder)
      parsed_xml.
        xpath(xpath_finder).
        map { |node| klass.create_from_xml(node.to_s) }
    end

    def find_xml_value(query)
      regex = Regexp.new("<#{query}>(.+)<\/#{query}>")
      parsed_xml.
        xpath("//#{query}").
        map { |node| regex.match(node.to_s).captures.first }
    end
  end
end

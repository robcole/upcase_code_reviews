class Speech < Shakespeare::Base
  def speaker
    @speaker ||= find_xml_value("SPEAKER").first.to_s
  end

  def lines
    @lines ||= find_xml_value("LINE").map(&:to_s)
  end

  def said_by_all?
    speaker == "ALL"
  end
end

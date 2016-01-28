class Scene < Shakespeare::Base
  def speeches
    @speeches ||= create_speeches
  end

  def speakers
    @speakers ||= create_speakers
  end

  private

  def create_speeches
    create_subitems(Speech, "//SPEECH").reject(&:said_by_all?)
  end

  def lines_for_speaker(speaker)
    speeches.
      select { |speech| speech.speaker == speaker }.
      flat_map(&:lines)
  end

  def create_speakers
    speeches.inject({}) do |memo, speech|
      memo.merge({speech.speaker => lines_for_speaker(speech.speaker)} )
    end
  end
end

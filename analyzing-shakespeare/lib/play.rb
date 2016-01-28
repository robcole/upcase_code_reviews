class Play < Shakespeare::Base
  def scenes
    @scenes ||= create_subitems(Scene, "//SCENE")
  end

  def speakers
    @speakers ||= Speaker.create_speakers_from_scenes(scenes)
  end
end

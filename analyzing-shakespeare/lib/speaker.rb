class Speaker
  def self.create_speakers_from_scenes(scenes)
    [*scenes].map(&:speakers).inject({}) do |memo, scene_speakers|
      memo.merge combine_scene_lines_for_speaker(memo, scene_speakers)
    end
  end

  def self.combine_scene_lines_for_speaker(hash, scene_speakers)
    scene_speakers.inject({}) do |memo, (name, lines)|
      old_lines = hash.fetch(name, nil)
      new_lines = old_lines.nil? ? lines : lines.push(old_lines).flatten
      memo.merge({name => new_lines})
    end
  end
end

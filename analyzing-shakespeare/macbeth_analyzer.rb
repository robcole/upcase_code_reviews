require_relative './lib/shakespeare'
xml = Shakespeare::Base.load_fixture('macbeth.xml')
play = Play.create_from_xml(xml)
ordered_speakers = play.speakers.sort_by { |speaker| speaker[1].count }.reverse!
ordered_speakers.each { |speaker| Shakespeare::Base.display_speaker(speaker) }

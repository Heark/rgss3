#==============================================================================
# 
#  Yuuta Kirishima / Dexter ~ Random Song PLayer
# -- Script Call: RandomMusic.play(volume, pitch)
# -- Example: RandomMusic.play(100, 100)
#
# 
#==============================================================================
$music = Dir["Audio/BGM/*"]

class Music
  attr_accessor :song
  def initialize
    @song = $music.sample
  end
  def play(volume, pitch)
    RPG::BGM.new(@song, volume, pitch).play
  end
end
RandomMusic = Music.new
RandomMusic.song = $music.sample[10..500]
=end



  

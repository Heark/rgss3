=begin
// Computer Generated Music
// Yuuta Kirishima / Dexter / Heark
//
//
// Instructions---- 
// Place all the music files into the SE folder.
// Call the script call: Musica.play(loop)
// Set loop to true or false if you want it to continue.
=end

num = rand(100) 

rand_volume = 100
rand_pitch = num + 15 

volume = rand_volume
pitch  = rand_pitch
pitch2 = rand_pitch + 10
pitch3 = rand_pitch + 8
pitch4 = rand_pitch + 6
pitch5 = rand_pitch % 2
pitch6 = rand_pitch * 4
pitch7 = rand_pitch * 2
pitch8 = rand_pitch * 1.5
pitch9 = rand_pitch
pitch10 = rand_pitch + 20

  $a = RPG::SE.new("a.mp3", volume, pitch)
  $b = RPG::SE.new("b.mp3", volume, pitch2)
  $c = RPG::SE.new("c.mp3", volume, pitch3)
  $d = RPG::SE.new("d.mp3", volume, pitch4)
  $e = RPG::SE.new("e.mp3", volume, pitch5)
  $f = RPG::SE.new("f.mp3", volume, pitch6)
  $g = RPG::SE.new("g.mp3", volume, pitch7)
  $h = RPG::SE.new("h.mp3", volume, pitch8)
  $i = RPG::SE.new("i.mp3", volume, pitch9)
  $j = RPG::SE.new("j.mp3", volume, pitch10)
  #k = RPG::SE.new("k.wav", volume, pitch).play
  $sequence = [$a, $b, $c, $d, $e, $f, $g, $h, $i, $j]
  
# Something for a later function (Disregard)
module Math
  attr_accessor :AFFLEC
  @AFFLEC = Array.new
end

class Result
    def play(loop)
  while loop == true
    $sequence.sample.play
    $sequence.sample.play
    $sequence.sample.play
    $sequence.sample.play
    $sequence.sample.play
  end
else
    $sequence.sample.play
    $sequence.sample.play
    $sequence.sample.play
    $sequence.sample.play
    $sequence.sample.play
  end
end
Musica = Result.new

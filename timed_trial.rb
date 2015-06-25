=begin
  VXA Timed Trial
  By: Yuuta Kirishima / Dexter
  Special Thanks: Galenmereth / Tor Damian Design
  
  What does it do?
  When trial has ended displays a message then exits the game. 
  Also disables save if you allow it too.
  
  Terms of use:
  Free to use in commercial and in non-commerical
  
  Credit:
  Galenmereth & Yuuta Kirishima / Dexter
=end
# If set to false, script won't activate
timed_trial = true

# If Set to true player's save will not save.
$disable_save = true

# Enter value in minutes
$minutes = 25



if timed_trial == true

def create_method(name, &block)
  self.class.send(:define_method, name, &block)
end
create_method(:thea) { $game_message.add("Trial ended, demo is over.") }
create_method(:wilma) {  SceneManager.exit }
if $disable_save == true
  if File.exist?("Save01.rvdata2")
    File.delete("Save01.rvdata2")
  end
end
module TDD
class Timer
  @@timers = []
  class << self
    #--------------------------------------------------------------------------
    # * Call After Frames
    #--------------------------------------------------------------------------
    def call_after_frames(args={})
      timer_object = {
        :observer => nil,
        :method => nil,
        :params => nil,
        :frames => 0
      }.merge(args)

      # Raise error unless required params
      raise "#{self}: Requires observer and method" unless timer_object[:observer] && timer_object[:method]

      # Push into timer queue
      @@timers.push(timer_object)
    end

    #--------------------------------------------------------------------------
    # * Frame Update Call
    #--------------------------------------------------------------------------
    def update
      @@timers.each do |timer_object|
        if timer_object[:frames] > 0
          # Reduce frames left if any
          timer_object[:frames] -= 1
        else
          # Call method with params if no more frames to count down
          if timer_object[:params]
            timer_object[:observer].send(timer_object[:method], *timer_object[:params])
          else
            timer_object[:observer].send(timer_object[:method])
          end

          # Remove from timers
          @@timers.delete(timer_object)
        end
      end
    end
  end
end
end


#==============================================================================
# Scene_Base extensions
#------------------------------------------------------------------------------
# Extends update_basic to call the TDD::Timer.update method once per frame
#------------------------------------------------------------------------------
# aliases:
# * :tdd_timer_scene_update_basic_extension, :update_basic
#==============================================================================
class Scene_Base
  #--------------------------------------------------------------------------
  # * ALIAS Frame Update
  #--------------------------------------------------------------------------
  alias_method :tdd_timer_scene_update_basic_extension, :update_basic
  def update_basic
    TDD::Timer.update
    tdd_timer_scene_update_basic_extension
  end
end
module DataManager

  #--------------------------------------------------------------------------
  # * Set Up New Game
  #--------------------------------------------------------------------------
  class << self
    unless method_defined?(:data_q36N9Sjn_dm_setup_new_game)
      alias_method(:data_q36N9Sjn_dm_setup_new_game, :setup_new_game)
    end
  end
  
  def self.setup_new_game(*args, &block)
    data_q36N9Sjn_dm_setup_new_game(*args, &block)

  TDD::Timer.call_after_frames(
    :frames   => 3600*$minutes,
    :observer => self,
    :method   => :thea,
    :params   => nil
  )
  TDD::Timer.call_after_frames(
    :frames   => 3940*$minutes,
    :observer => self,
    :method   => :wilma,
    :params   => nil
  )
  end
  
end
end

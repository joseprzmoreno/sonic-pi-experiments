sc = scale(:F3, :minor)
sc2 = scale(:C4, :minor)
use_bpm 190

#comment 18/19 . To finish, uncomment 8

live_loop :main do
  #stop
  use_random_seed [12,12,14,14,24,24,28,28].tick
  in_thread do
    use_synth :pluck
    play_pattern_timed sc.shuffle, [1,2,1,1,1,1,2,1]
  end
  in_thread do
    use_synth :piano
    play_pattern_timed sc2.shuffle.take(4), [2,4,3,2]
  end
  #sleep 8
  #next
  use_synth :winwood_lead
  play_pattern_timed sc2.shuffle, 0.5
end



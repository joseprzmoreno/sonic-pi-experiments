define :ritm do
  sleep 0.33
  sample :bd_tek, amp:1
  2.times do
    sleep 0.33
    sample :bd_tek, amp:0.6
  end
end

live_loop :bat1 do
  sleep 0.33
  ritm
  sleep 0.33
  ritm
end

live_loop :bass_organ, sync: :bat1 do
  use_random_seed 1001
  use_synth :organ_tonewheel
  play_pattern_timed scale(:c3, :minor_pentatonic).shuffle, 0.33, release: 0.22
end

live_loop :mel1, sync: :bat1 do
  sleep 0.33*4
  use_random_seed 1001 #1001  -- ar 1001|1007 1008, ab: tick|choose fx
  use_synth :organ_tonewheel
  notes = ring(:c5, :d5, :g5, :a5)
  #with_fx :echo, phase: 0.33*2 do
  #with_fx :flanger do
  #play chord(notes.tick, :m7), amp:1.5, release: 0.33*0.5
  #end
  #end
end


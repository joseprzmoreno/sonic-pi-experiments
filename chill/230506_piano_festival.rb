t = 0.5

live_loop :bg do
  use_synth :piano
  play chord [:C3, :G3, :A3].choose, :m7,
    amp: rrand(0.5, 0.9), pan: -0.5
  sleep [t, t * 0.5, t, t * 1.5].tick
end

live_loop :bg2, sync: :bg do
  #stop
  use_synth :piano
  if one_in(12) then
    sleep t * 12
  else
    play chord scale(:C4, :minor_pentatonic).choose, :M,
      pan: 0.5
    sleep [t * 0.5, t, t * 1.5, t].tick
  end
end

live_loop :scale, sync: :bg do
  #stop
  use_synth :piano
  play_pattern_timed scale(:C3, :dorian), t, amp: 0.5,
    pan: -0.3
end

live_loop :chord, sync: :bg do
  #stop
  use_synth :piano
  if one_in(2) then
    play_pattern_timed chord([:C5, :G5].choose, :m7),
      t * 0.5, amp: 0.5, pan: 0.8
  else
    sleep t * 4
  end
end

live_loop :scale2, sync: :bg do
  #stop
  use_synth :piano
  s = scale(:C4, :dorian).reverse.take(4)
  play_pattern_timed s, [t, t * 0.5, t], amp: 0.6
end

live_loop :rnd, sync: :bg do
  #stop
  use_synth :piano
  s = scale(:C3, :dorian, num_octaves: 3).shuffle
  play_pattern_timed s, t * 0.25, amp: 0.4, release: 0.15
end







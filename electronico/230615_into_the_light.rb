t = 0.25
factor = 1
crease = 0.96

live_loop :bg do
  use_synth :bass_foundation
  ns = [:C2, :r, :r, :r, :C2, :r, :r, :r,
        :G2, :r, :r, :r, :G2, :r, :r, :r,
        :F2, :r, :r, :r, :F2, :r, :r, :r,
        :G2, :r, :r, :r, :G2, :r, :r, :r]
  play_pattern_timed ns, t * factor
end

live_loop :main, sync: :bg do
  use_synth :bass_foundation
  ns = [:C4, :G4, :A4, :A4, :F4, :Bb4, :r]
  with_fx :echo, phase: t * 0.66 do
    play ns.choose, attack: 0.5, release: 1, amp: 0.8
  end
  sleep t * factor
end

c = 1
live_loop :drums, sync: :bg do
  
  if c == 1 || c == 4 || c == 7 || c == 10 then
    sample :drum_bass_hard
  end
  
  if c == 4 || c == 8 || c == 12 then
    sample :drum_snare_hard
  end
  
  sample :drum_cymbal_pedal
  
  c = c + 1
  
  if c == 13 then
    c = 1
  end
  
  sleep t * factor
end

live_loop :ambi, sync: :bg do
  use_synth :tb303
  s = scale(:C4, :minor_pentatonic)
  with_fx :gverb do
    ch = chord(s.choose, :M)
    play ch, release: 0.1
  end
  sleep [t, t * 2, t, t * 2, t, t * 2,
         t * 2, t, t * 2, t, t * 2, t].tick * factor
end

live_loop :speed_randomizer, sync: :bg do
  factor = factor * crease
  print factor
  if factor < 0.7 then
    crease = 1.04
  end
  if factor > 1.3 then
    crease = 0.96
  end
  sleep t * 24 * factor
end

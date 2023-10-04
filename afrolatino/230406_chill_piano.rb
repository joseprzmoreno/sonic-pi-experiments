live_loop :perc do
  sample :drum_tom_lo_soft
  sleep 0.75
  sample :drum_tom_lo_soft
  sleep 0.25
  sample :drum_tom_lo_soft
  sleep 0.25
  sample :drum_tom_lo_soft
  sleep 0.25
  sample :drum_tom_lo_soft
  sleep 0.5
end

live_loop :cow, sync: :perc do
  sample :drum_cowbell, rate: 2, amp: 0.3, pan: -0.3
  sleep 0.25
  sample :drum_cowbell, rate: 2, amp: 0.8, pan: 0.2
  sleep 0.25 * 1.33
  sample :drum_cowbell, rate: 2, amp: 0.3, pan: 0.9
  sleep 0.25 * 0.67
  sleep 5
end


live_loop :piano1, sync: :perc do
  use_synth :piano
  play [:D4, :F4, :A4]
  sleep 0.5
  play [:G4, :B4, :D5]
  sleep 0.25
  play [:F4, :A4]
  sleep 0.5
  play [:F4, :A4]
  sleep 0.25
  
  play [:D4, :F4, :A4]
  sleep 0.25
  play [:D4, :F4, :A4]
  sleep 0.25
  play [:D4, :F4, :D5]
  sleep 0.5
  play [:G4, :B4, :E5]
  sleep 0.25
  play [:F4, :A4]
  sleep 0.5
  play [:F4, :A4]
  sleep 0.5
end

live_loop :piano2, sync: :piano1 do
  use_synth :piano
  chords = ring(chord(:C3, :M), chord(:D3, :M), chord(:G3, :M7))
  play chords.tick, pan: -0.6
  sleep [0.25, 0.25, 0.5, 0.25, 0.25, 0.75, 1.125, 0.25].tick
end

live_loop :ambiance, sync: :piano1 do
  use_synth :bass_foundation
  play scale(:C2, :major_pentatonic).tick, amp: 1, pan: 0.6
  sleep [0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.75, 0.75].shuffle.tick
end


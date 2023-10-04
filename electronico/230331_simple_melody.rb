live_loop :bass do
  use_synth :bass_foundation
  play :C2, release: 0.2
  sleep 0.5
  play :C2, release: 0.2
  sleep 0.5
  play :D2, release: 0.2
  sleep 0.5
  play :D2, release: 0.2
  sleep 0.5
end

live_loop :rhythm, sync: :bass do
  sample :drum_bass_soft
  sleep 1
end

live_loop :rhythm2, sync: :bass do
  sleep 0.125
  sample :drum_bass_hard
  sleep 0.125
  sample :drum_bass_hard, release: 0.1
  sleep 0.75
end

live_loop :melody do
  use_random_seed 37 #15, 17, 21, 23, 37
  use_synth :prophet
  notes = scale(:C3, :major, num_octaves: 2).shuffle
  with_fx :echo do
    play notes.tick, release: 0.125
    sleep [0.25, 0.25, 0.25, 0.5].choose
  end
end


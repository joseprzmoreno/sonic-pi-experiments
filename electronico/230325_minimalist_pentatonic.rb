live_loop :random_riff do
  use_synth :prophet
  use_random_seed 18777
  notes = (scale :e3, :minor_pentatonic).shuffle +
    notes = (scale :e3, :minor_pentatonic).shuffle
  play notes.tick, release: 0.25, cutoff: 80
  sleep 0.25
end

live_loop :bass do
  use_synth :square
  use_random_seed 77
  notes = (scale :e3, :minor_pentatonic).shuffle +
    (scale :e3, :minor_pentatonic).shuffle
  play notes.tick, release: 0.2, amp: 0.4
  sleep 0.5
end

live_loop :third do #amp 0 to 0.3
  use_synth :dsaw
  use_random_seed 10
  notes = (scale :e4, :minor_pentatonic, num_octaves: 2).shuffle
  with_fx :echo do
    play notes.tick, amp: 0, release: 0.1
  end
  sleep 0.125
end



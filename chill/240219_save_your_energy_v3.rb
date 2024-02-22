use_bpm 120

live_loop :r do
  sample :bd_ada, amp: 8
  sleep 1
end

amp = ring(1,2,3,2)
live_loop :c, sync: :r do
  use_synth :tech_saws
  use_synth_defaults sustain: 1
  notes = [:C3, :D3, :F3, :A3]
  for note in notes do
    play chord(note, '5'), amp: amp.tick
    sleep 1
  end
end

live_loop :d, sync: :r do
  use_random_seed [1000,1000,21,21,2000,2000,7000].tick(:rs)
  use_synth :supersaw
  use_synth_defaults sustain: 0.2, release: 0
  sc = scale(:C4, :major_pentatonic).shuffle
  8.times do
    with_fx :reverb do
      play sc.tick, amp: [2, 1.5].tick(:amp), pan: rrand(-1, 1)
      sleep 0.25
    end
  end
end






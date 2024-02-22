use_bpm 120

live_loop :r do
  16.times do |i|
    amp = 8
    amp = 0 if i > 12
    sample :bd_ada, amp: amp
    sleep 1
  end
end

amp = ring(1,2,3,2)
live_loop :c, sync: :r do
  use_synth :tech_saws
  use_synth_defaults sustain: 1
  notes = [:C3, :D3, :F3, :A3, :C3, :D3, :F3, :A3, :C3, :D3, :F3, :A3, :C3, :D3, :C3, :D3]
  for note in notes do
    play chord(note + 12, '5'), amp: 3
    sleep 1
  end
end

live_loop :d, sync: :r do
  use_random_seed [1,1,2,2,3,3,4,4].tick(:rs)
  use_synth :square
  use_synth_defaults sustain: 0.2, release: 0
  sc = scale(:C4, :major_pentatonic).shuffle
  8.times do
    with_fx :ping_pong do
      play sc.tick, amp: [2, 1.5, 1].tick(:amp), pan: rrand(-1, 1) if not one_in(9)
      sleep 0.25
    end
  end
end






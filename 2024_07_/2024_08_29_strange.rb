use_bpm 120

live_loop :main do
  use_synth :pluck
  sc = scale(:G4, :minor_pentatonic)
  play sc.choose if not one_in 3
  sleep 0.5
end

live_loop :saws, sync: :main do
  use_random_seed [120, 22, 23].tick(:rss)
  4.times do
    use_synth :tech_saws
    sc = scale(:G3, :minor)
    play chord(sc.choose, 'm'), sustain: 1, amp: [0.5, 0.7].tick(:bs)
    sleep 1
  end
end

live_loop :ambi, sync: :main do
  use_synth :zawa
  with_fx :ping_pong do
    play [:C5, :D5].tick, release: 2, amp: 0.5
  end
  sleep 4
end

live_loop :drums, sync: :main do
  with_fx :reverb do
    sample :tabla_ghe1, amp: 1
  end
  sleep [1, 0.5, 0.5, 1, 1].tick
end

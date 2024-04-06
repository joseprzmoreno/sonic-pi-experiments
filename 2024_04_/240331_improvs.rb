use_bpm 120

live_loop :r do
  sample :bd_808, amp: 8
  sleep 1
end

live_loop :r3, sync: :r do
  sample :elec_blip, amp: 4, rate: 4
  sleep 0.5
end

live_loop :r2, sync: :r do
  with_fx :gverb, damp: 0.7 do
    sample :drum_cowbell, rate: rrand_i(10,20) * 0.1, amp: rrand(0.3, 0.6) if not one_in(4)
  end
  sleep 0.25
end

live_loop :vs, sync: :r do
  use_random_seed [17,17,23,23,22,22,100,100].tick(:rss)
  use_synth :tech_saws
  ns = scale(:C4, :major, num_octaves: 2).shuffle.take(4)
  with_fx :panslicer do
    with_fx :hpf, cutoff: 120 do
      play chord(ns.tick(:ns), :M7), sustain: 1, amp: 3
    end
  end
  sleep 1
end

live_loop :bass, sync: :r do
  use_synth :saw
  play [62 - 12, 60 - 12].tick, amp: 2, sustain: 1
  sleep 1
end

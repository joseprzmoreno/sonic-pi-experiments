use_bpm 120

live_loop :melody do
  use_synth :supersaw
  use_random_seed 11 #11 12 22 24 28 29 290
  use_synth_defaults pulse_width: 0.2, release: 0.3
  pattern = [
    [:e5, :e4, :d3, :d4].shuffle,
    [:d5, :d4, :c3, :c4].shuffle,
    [:e4, :g4, :a3, :d4].shuffle,
    [:g3, :g4, :a3, :a4].shuffle
  ].tick
  pattern.each do |n|
    with_fx :echo do
      play n
    end
    sleep 0.5
  end
end

live_loop :bassline do
  use_random_seed 12 #19 35 26
  use_synth :chipbass
  pattern = [:e3, :g3, :a3, :c4, :b3, :a3, :g3, :e3].shuffle
  play_pattern_timed pattern, 0.25
end

live_loop :drums do
  sample :bd_haus, amp: 1.5, attack: 0.02
  sleep 0.5
  sample :drum_snare_soft, amp: 0.8, attack: 0.02
  sleep 0.25
  sample :bd_haus, amp: 1.5, attack: 0.02
  sleep 0.25
end

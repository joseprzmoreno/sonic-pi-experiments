use_bpm 120

live_loop :ambi do
  use_synth :dsaw
  with_fx :flanger do
    play chord([:C4, :D4, :A4, :G4].tick - 12.2, '6'), sustain: 4, pan: -0.5
  end
  sleep 4
end

live_loop :mel, sync: :ambi do
  use_random_seed 707
  use_synth :prophet
  use_synth_defaults amp: 0.8, release: 0.2
  with_fx :echo do
    play_pattern_timed scale(:D3, :major_pentatonic, num_octaves: 2).shuffle, 0.5, pan: 0.5
  end
end

live_loop :drums, sync: :ambi do
  sample :drum_cymbal_open if one_in(6)
  3.times do
    sample :bd_pure, amp: 2
    sleep 0.5
    sample :bd_boom, amp: 1.5
    sleep 0.5
  end
  2.times do
    sample :bd_pure, amp: 2
    sleep 0.25
    sample :bd_boom, amp: 1.5
    sleep 0.25
  end
end

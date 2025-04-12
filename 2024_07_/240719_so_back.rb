use_bpm 120

live_loop :base do
  sleep 1
end

live_loop :drums, sync: :base do
  sample :bd_808, amp: 8
  sleep 1
  sample :sn_generic, amp: 0.5
  sleep 1
end

live_loop :rhodey, sync: :base do
  use_synth :tb303
  with_fx :reverb do
    with_fx :panslicer do
      play :C2, sustain: 4, amp: 0.5
      sleep 4
      play :D2, sustain: 4, amp: 0.5
      sleep 4
      play :G2, sustain: 4, amp: 0.5
      sleep 4
      play :D2, sustain: 4, amp: 0.5
    end
  end
end

live_loop :organ, sync: :base do
  use_synth :organ_tonewheel
  notes = [:C3, :D3, :G3, :G3]
  notes = [:F3, :A3, :Bb3]
  notes = scale(:D3, :minor)
  notes = scale(:D3, :minor_pentatonic)
  with_fx :echo do
    with_fx :flanger do
      play notes.choose + 24, sustain: rrand(0.15,0.3), amp: 1 #+2 +7
    end
  end
  sleep 0.5
end

live_loop :cow, sync: :base do
  stop
  with_fx :gverb do
    sample :drum_cowbell, amp: 0.3, release: 3, rate:[1,2,3,4].choose if one_in(16)
  end
  sleep 0.125
end

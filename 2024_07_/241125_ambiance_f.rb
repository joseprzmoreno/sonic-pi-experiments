use_bpm 120

live_loop :main do
  use_random_seed [1200, 2400].tick
  use_synth :tech_saws
  sc = scale(:D4, :dorian)
  4.times do
    z = rrand_i(0,5)
    play [sc[z], sc[z+2], sc[z+4]], sustain: 1, amp: 1
    sleep 1
  end
end

live_loop :mel, sync: :main do
  #stop
  use_synth :beep
  use_random_seed [130, 131].tick(:rss)
  sc = scale(:D5, :dorian)
  z = rrand_i(0, 5)
  with_fx :panslicer do
    8.times do
      play sc[z], amp: 1, pan: rrand(-1, 1)
      sleep [0.25, 0.75].choose
      z = z + [-2,-1,1,2].tick(:dists)
    end
  end
end

live_loop :drums, sync: :main do
  #stop
  sample :drum_bass_hard, amp: 0.5
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.5
end

live_loop :glass, sync: :main do
  #stop
  sample :ambi_glass_rub, rate: [0.5, 0.8].tick(:ag), amp: 0.3
  sleep 1
end

live_loop :bells, sync: :main do
  #stop
  use_synth :pretty_bell
  with_fx :echo, phase: rrand(0.48, 0.52) do
    play scale(:D4, :dorian).choose if one_in(2)
  end
  sleep 1
end



use_bpm 120
add = 0

live_loop :drums do
  sample :bd_808, amp: 8
  sleep 1
  sample :drum_snare_soft
  sleep 1
end

live_loop :cyms, sync: :drums do
  sample :drum_cymbal_pedal, amp: 0.8
  sleep 0.5
  sample :drum_cymbal_pedal, amp: 0.6
  sleep 0.5
end

live_loop :pad, sync: :drums do
  #stop
  use_synth :saw
  with_fx :lpf, cutoff: 80 do
    play 58 + add
    sleep 1
    play 60 + add
    sleep 1.5
    play 60 + add
    sleep 0.5
    play 58 + add
    sleep 1
  end
end

live_loop :ambi, sync: :pad do
  use_synth :hoover
  use_synth_defaults sustain:4, release:0
  play chord(:C3, '5')
  sleep 4
  play chord(:G3, '5')
  sleep 4
end

cont = 0
live_loop :mel, sync: :pad do
  use_random_seed 700
  use_synth :blade
  ns = [60, 62, 64, 67, 67, 69, 69, 72, 72, :r, :r, :r, :r, :r, :r, :r]
  #ns = scale(:C4, :dorian) + [:r, :r, :r, :r, :r, :r, :r, :r, :r]
  ns_orig = ns
  ns = ns.shuffle if cont % 2 == 1
  ns = ns_orig if cont % 2 == 0
  with_fx :flanger do
    ns.each do |n|
      play n, amp: rrand(1.6,2.4), pan: rrand(-0.5, 0.5)
      sleep 0.25
    end
  end
  cont += 1
end

live_loop :bells do
  #stop
  with_fx :panslicer do
    play chord([:C2, :D5, :A4, :G3].tick, '5'), amp: 0.8
  end
  sleep 0.125
end

















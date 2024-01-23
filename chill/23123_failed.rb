use_bpm 60
rs = 0

live_loop :bells do
  use_random_seed rs if rs != 0
  use_synth :pretty_bell
  ns = [:C4, :D4, :A3, :C4]
  ns = ns.shuffle if rs != 0
  with_fx :echo do
    play chord(ns.tick, :m7)
  end
  sleep 1
end

live_loop :hoov, sync: :bells do
  use_synth :hoover
  use_synth_defaults amp: 0.5, sustain: 4, release: 0
  ns = [:C5, :F4, :C5, :Ab4]
  n = ns.tick
  play chord(n, '5')
  sleep 4
end

live_loop :mel, sync: :bells do
  #stop
  amp = 1
  amp = 0.8 if one_in(20)
  amp = 0.6 if one_in(20)
  amp = 0.4 if one_in(20)
  use_synth :blade
  notes = [[:D6,:C6].choose, :A5, [:G5,:F5].choose, [:C5,:D5].choose]
  #with_fx :panslicer do
  #with_fx :whammy, grainsize: 0.125 do
  play notes.tick(:ns), amp: amp
  #end
  #end
  sleep 0.5
end

live_loop :bass, sync: :bells do
  use_synth :hollow
  use_synth_defaults sustain: 2, amp: 2
  play [:C3, :D3, :G2, :A2].tick
  sleep 2
end

live_loop :snare do
  sample :drum_snare_soft
  sleep 0.5
  sample :bd_klub, amp: 2
  sleep 0.5
end
























































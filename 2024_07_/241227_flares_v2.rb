live_loop :bd_drums do
  sample :bd_fat, amp: 4
  sleep 0.5
  sample :drum_snare_soft, amp: 2
  sleep 0.5
end

live_loop :bass, sync: :bd_drums do
  use_synth :rodeo
  use_synth_defaults release: 0.25, amp: 0.6
  play :A5
  sleep 0.25
  play [:E4, :D4, :C4].choose
  sleep 0.25
end

live_loop :flares, sync: :bd_drums do
  use_synth :tech_saws
  play chord(:D6, '6')
  sleep 1
  play chord([:B5, :G5, :F5].choose, 'M')
  sleep 0.25
  play chord(:A5, '6')
  sleep 0.75
end

live_loop :piano, sync: :bd_drums do
  use_synth :pretty_bell
  use_random_seed [1,2,3,4].tick(:rs)
  4.times do
    sc = scale([:D5, :A4, :G5, :D4].choose, :minor_pentatonic)
    play sc.choose, release: rrand(0.3, 1), amp: rrand(0.6,1)
    sleep [0.125, 0.25].choose
  end
  sleep 0.25
end

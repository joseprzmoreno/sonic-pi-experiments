live_loop :bd_drums do
  sample :bd_fat, amp: 1
  sleep 0.5
  sample :drum_snare_soft
  sleep 0.5
end

live_loop :bass, sync: :bd_drums do
  use_synth :saw
  use_synth_defaults release: 0.25, amp: 0.6
  play :A1
  sleep 0.25
  play :E2
  sleep 0.25
end

live_loop :flares, sync: :bd_drums do
  use_synth :tech_saws
  play chord(:D4, '6')
  sleep 1
  play chord(:B3, 'M')
  sleep 0.25
  play chord(:A3, '6')
  sleep 0.75
end

live_loop :piano, sync: :bd_drums do
  use_synth :subpulse
  use_random_seed [1,2,3,4].tick(:rs)
  4.times do
    with_fx :nbpf do
      sc = scale([:D3, :A4, :G5, :D6].choose, :minor_pentatonic)
      play sc.choose, release: 0.1, amp: rrand(0.6,1)
    end
    sleep [0.25, 0.5].choose
  end
  sleep 1
end

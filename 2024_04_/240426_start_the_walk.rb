use_bpm 120

live_loop :r do
  #stop
  sample :bd_ada, amp: 4
  sleep 1
end

live_loop :main, sync: :r do
  #stop
  use_random_seed 19
  use_synth_defaults release: 0.6
  use_synth :prophet
  sh = scale(:D3, :minor_pentatonic).shuffle
  scs = [scale(:D3, :minor_pentatonic),
         sh]
  sc = scs.tick(:scs)
  16.times do
    play sc.tick(:ns), amp: 0.6
    sleep [0.25, 0.5].tick(:durs)  #2,4
  end
end

live_loop :bg, sync: :r do
  #stop
  use_synth :growl
  sc = scale(:D5, :minor_pentatonic)
  use_synth_defaults sustain: 2, amp: 0.3
  with_fx :lpf, cutoff: 100 do
    with_fx :flanger do
      play chord(sc.choose, [:M, :m].tick)
    end
  end
  sleep 2
end

live_loop :r2, sync: :r do
  #stop
  pat = [1,0,1,0,1,1,0,0,1,0,0,1,0,1,0,1]
  16.times do |i|
    sample :sn_dub, amp: rrand(0.1,0.3) if pat[i] == 1
    sleep 0.25
  end
end


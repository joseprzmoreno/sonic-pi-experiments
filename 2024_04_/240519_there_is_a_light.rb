live_loop :drums do
  #stop
  in_thread do
    8.times do
      sample :bd_808, amp: [16, 8].tick(:amps)
      sleep 0.5
    end
  end
  sample :drum_cymbal_hard
  sleep 4
end

live_loop :melody, sync: :drums do
  use_synth :prophet
  use_random_seed 24 #24 28 32 36
  sc = scale(:D4, :minor_pentatonic)
  ts = [0.25, 0.25, 0.25, 0.5, 0.5, 0.25].shuffle
  6.times do
    play chord(sc.choose, ['M', '6'].tick(:qs)), pan: -0.5
    sleep ts.tick(:durs)
  end
end

live_loop :bass, sync: :drums do
  stop
  use_synth :saw
  use_synth_defaults amp: 0.3
  use_random_seed 12 #12 16 20 24
  sc = scale(:D3, :minor_pentatonic).shuffle.take(4)
  with_fx :echo, phase: 0.75 do
    play sc.tick, sustain: 0.5, release: 1.5, pan: 0.5
  end
  sleep 1
end

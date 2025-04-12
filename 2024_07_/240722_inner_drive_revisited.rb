use_bpm 120

live_loop :r do
  sample :bd_808, amp: 8
  sleep 1
end

live_loop :vs, sync: :r do
  #use_random_seed [17,17,23,23,22,22,100,100].tick(:rss)
  use_random_seed [7].tick(:rss) #7 10 800 9000 24 33 37 39 40 51 55
  use_synth :tech_saws
  ns = scale(:C4, :minor_pentatonic, num_octaves: 2).shuffle.take(4)
  with_fx :echo, phase: 0.5 do
    with_fx :hpf, cutoff: 120 do
      play chord(ns.tick(:ns), [:M, '6'].choose), sustain: 0.5, amp: 6
    end
  end
  sleep 1
end

live_loop :bass, sync: :r do
  #stop
  use_synth :saw
  sleep 0.5
  with_fx :echo do #echo flanger panslicer echo
    play [62 - 12, 60 - 12].tick, amp: 0.7, sustain: 0.5
  end
  sleep 0.5
end

live_loop :r2, sync: :r do
  sample :drum_cymbal_pedal, amp: [2,1].tick
  sleep 0.25
end

live_loop :pianos, sync: :r do
  #stop
  use_synth :hollow
  ns = [[:C5, :D5], [:F5, :G5], [:G5, :A5]].tick(:chs)
  amp = 12
  16.times do
    play chord(ns.tick(:ns), '5'), amp: amp
    sleep 0.5
    amp = amp * 0.9
  end
end

fadeout = 0
vol = 1
set_volume! 1
live_loop :fadeout, sync: :r do
  stop if fadeout == 0
  100000.times do
    vol = vol * 0.99
    set_volume! vol
  end
  sleep 0.1
end

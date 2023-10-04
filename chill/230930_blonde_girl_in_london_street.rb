use_bpm 120
#set_volume! 1

live_loop :drums do
  sample :bd_ada, amp: 2
  sleep 1
end

live_loop :cymbals, sync: :drums do
  dr = [:elec_cymbal, :elec_fuzz_tom, :elec_chime, :elec_mid_snare]
  4.times do
    #sample dr.tick
    sleep 2
  end
end

live_loop :bg, sync: :drums do
  use_synth :hoover
  use_synth_defaults sustain: 0.8, release: 0.8
  use_random_seed([12, 14, 16, 18].tick(:rs))
  ns = scale(:C4, :major_pentatonic).shuffle.take(4)
  ds = [2, 1, 1, 4]
  2.times do
    4.times do
      play chord(ns.tick(:ns), :M7)
      sleep ds.tick(:ds)
    end
  end
end

live_loop :melody, sync: :drums do
  use_synth :subpulse
  use_synth_defaults amp: 2
  use_random_seed([11, 13, 15, 17].tick(:mrs))
  ns = [:C4, :C5, :D4, :D5, :E4, :G4, :G5, :G4, :A4, :E5, :r, :r, :r, :r, :r, :r].shuffle
  ns.each do |n|
    n = ns.tick(:mns)
    with_fx :panslicer do
      #play n + 24
      sleep 0.5
    end
  end
end

live_loop :finish, sync: :drums do
  stop
  vol = 1
  100.times do
    set_volume! vol
    vol = vol - 0.01
    sleep 0.25
  end
end

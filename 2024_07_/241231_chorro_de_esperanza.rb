use_bpm 120

rs1 = [10,11,12,13]
rs2 = [105,1009,1011,1013]
set_volume! 1.5
pc = 0.25

live_loop :drums do
  with_fx :reverb do
    sample :bd_fat, amp: 1.5
  end
  sleep 1
end

live_loop :flang, sync: :drums do
  use_random_seed rs1.tick(:rss)
  use_synth :supersaw
  use_synth_defaults sustain: 0.15, release: 0
  sc = scale(:D4, :minor_pentatonic)
  z = rrand_i(0, sc.size - 1)
  3.times do
    amp_ = [0.5, 0.4, 0.3, 0.2, 0.3, 0.4].tick(:amps)
    #with_fx :reverb, amp: 0.6 do
    with_fx :flanger do
      play sc[z], amp: amp_
      sleep pc
      z = z - 2
    end
    #end
  end
  sleep 1
end

live_loop :prophet, sync: :drums do
  use_synth :prophet
  use_random_seed rs2.tick(:rss)
  use_synth_defaults sustain: 0.15, release: 0
  sc = scale(:D3, :minor_pentatonic, num_octaves: 2)
  with_fx :lpf, cutoff: 90 do
    play chord(sc.choose, 'M'), amp: rrand(1.2, 1.6)
    sleep pc
  end
end

live_loop :drums2, sync: :drums do
  sample :drum_cymbal_pedal, amp: [1, 0.5].tick(:amp)
  sleep 0.5
end

live_loop :activate_randomness, sync: :drums do
  rs1 = [rrand_i(0,1000), rrand_i(0,1000), rrand_i(0,1000), rrand_i(0,1000)]
  rs2 = [rrand_i(0,1000), rrand_i(0,1000), rrand_i(0,1000), rrand_i(0,1000)]
  sleep 8
end

fadeout = 0
vol = 1.5
live_loop :fadeout, sync: :drums do
  stop if fadeout == 0
  100000.times do
    set_volume! vol
    vol = vol - 0.001
    sleep 0.01
  end
end



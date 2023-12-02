use_bpm 120

live_loop :main do
  sleep 4
end

live_loop :ambi, sync: :main do
  use_synth :dsaw
  use_synth_defaults sustain: 0, release: 2 #0,4
  with_fx :flanger do
    3.times do
      play chord(:D4, 'm7')
      sleep 4
      play chord(:A4, 'm7')
      sleep 4
    end
    play chord(:G4, 'm7')
    sleep 4
    play chord(:C5, 'm7')
    sleep 4
  end
end

live_loop :drums, sync: :main do
  stop
  if one_in(20) then
    #sample :drum_splash_soft
  end
  sample :bd_808, amp: 4
  sample :elec_plip
  sleep 1
  sample :elec_plip
  sample :bd_808, amp: 4
  sleep 0.5
  sample :elec_plip
  sleep 0.5
end

live_loop :bassline, sync: :main do
  stop
  use_synth :bass_foundation
  use_synth_defaults sustain: 4
  sc = scale(:D2, :minor_pentatonic)
  with_fx :reverb do
    with_fx :slicer do
      play sc.tick
    end
  end
  sleep 4
end

live_loop :melody, sync: :main do
  stop
  use_synth :blade
  use_random_seed [24,24,38,38,39,39,42,42].tick(:rs)
  sc = scale(:D3, :minor_pentatonic, num_octaves: 2).shuffle.take(2)
  pat = [0,1,0,1,0,0,1,0]
  durs = [0.5, 0.5, 0.75, 0.25, 0.25, 0.25, 0.5, 1]
  8.times do
    play sc[pat.tick(:ns)], amp: 1.8
    sleep durs.tick(:ds)
  end
end

live_loop :fadeout do
  stop
  mv = 1
  10000.times do
    set_volume! mv
    mv = mv - 0.01
    sleep 0.5
  end
end

#set_volume! 1
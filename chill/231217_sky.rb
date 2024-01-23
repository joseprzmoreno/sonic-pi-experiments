use_bpm 60

volume = 1
set_volume! volume

live_loop :main do
  sleep 4
end

live_loop :bg, sync: :main do
  use_synth :dsaw
  use_synth_defaults sustain: 4
  play chord(:C4, :M7)
  sleep 4
  play chord(:D4, :M7)
  sleep 4
  play chord(:G4, :M7)
  sleep 4
  play chord(:A4, :M7)
  sleep 4
end

live_loop :fg, sync: :main do
  use_synth :chiplead
  12.times do
    play [:C4, :B3, :A3, :E3].tick
    sleep 0.5
  end
  4.times do
    play [:C4, :A3, :E3, :C3].tick
    sleep 0.5
  end
end

live_loop :bells, sync: :main do
  #stop
  use_random_seed 12
  sc = scale(:C4, :major_pentatonic, num_octaves: 2).shuffle
  use_synth :pretty_bell
  with_fx :gverb, amp: 0.8 do
    with_fx :echo, phase: 0.12, max_phase: 16 do
      if not one_in(6) then
        play chord(sc.tick(:chs), '5')
      end
    end
  end
  sleep 1
end

live_loop :violin, sync: :main do
  #stop
  use_synth :piano
  use_synth_defaults amp:2
  use_random_seed 54
  ns = [:C4, :C4, :C4, :D4, :D4, :D4, :E4, :E4,
        :r, :r, :A4, :A4, :G4, :r, :r, :r].shuffle
  with_fx :whammy do
    play ns.tick(:ns)
  end
  sleep 0.125
end

live_loop :finish do
  #stop
  vol = 1
  10000.times do
    if volume < 0.1 then
      sleep 1
      next
    end
    set_volume! vol
    vol = vol - 0.01
    sleep 0.125
  end
end





















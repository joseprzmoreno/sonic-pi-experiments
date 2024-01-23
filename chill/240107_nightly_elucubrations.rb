use_bpm 120
rs = 90988
shuffle = 1
bass = 1
drops = 1
saw = 1
set_volume! 1

live_loop :main do
  sleep 1
end

live_loop :bass, sync: :main do
  stop if bass == 0
  use_synth :bass_foundation
  use_synth_defaults release: 0.15
  use_random_seed rs
  sc = scale(:D2, :dorian, num_octaves: 2)
  ds = [6,4,2,4,6,4,2,6,8,7,8,4,2,4,7,2]
  ds = ds.shuffle if shuffle == 1
  with_fx :echo do
    16.times do |i|
      play sc[ds[i]], pan: [-0.5, 0.5].tick(:ps), amp: 2
      sleep 0.25
    end
  end
end

live_loop :drops, sync: :main do
  stop if drops == 0
  use_synth :tb303
  use_synth_defaults sustain: 2
  use_random_seed rs
  sc = scale(:D5, :dorian)
  pos_ini = rrand_i(0,3)
  with_fx :panslicer do
    play sc[pos_ini], sustain: 4
    sleep 4
    play sc[pos_ini + 3]
    sleep 2
    play sc[pos_ini + [1.5,1,2].choose]
    sleep 2
  end
end

live_loop :saw_, sync: :main do
  stop if saw == 0
  use_synth :supersaw
  use_synth_defaults sustain: 2, amp: 3
  with_fx :bpf, centre: 600 do
    3.times do
      play [:D4, :F4, :A4, :C4]
      sleep 2
      play [:A4, :C4, :Eb4, :G4]
      sleep 2
    end
    play [:D4, :F4, :A4, :C4]
    sleep 2
    play [:A4, :C4, :Eb4, :G4]
    sleep 2
    play [:Eb4, :G4, :B4, :D4], sustain: 4
    sleep 4
  end
end

vol = 1
live_loop :finish, sync: :main do
  stop
  10000.times do
    set_volume! vol
    vol = vol - 0.01
    sleep 0.2
  end
end

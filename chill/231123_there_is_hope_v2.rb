use_bpm 120

hoov = 1
cym = 1
proph = 1
tb = 1
rs = 137 #137 444 3000 4000

live_loop :main do
  sleep 4
end

live_loop :hoov, sync: :main do
  use_random_seed rs
  sc = scale(:C3, :minor_pentatonic)
  z = rrand_i(0,4)
  stop if hoov == 0
  use_synth :hoover
  notes = [sc[z], sc[z+1]]
  4.times do
    with_fx :echo, phase: 0.15 do
      play notes.tick(:ns), release: 0.3, pan: -0.6
    end
    sleep 1
  end
end

live_loop :cym, sync: :main do
  stop if cym == 0
  sample :drum_cymbal_closed, amp: [0.9, 0.6].tick, rate: 1.2
  sleep 0.25
end

live_loop :proph, sync: :main do
  use_random_seed rs
  sc = scale(:C4, :minor_pentatonic)
  stop if proph == 0
  use_synth :prophet
  use_synth_defaults sustain: 2, attack: 1, release: 4, amp: 0.6
  with_fx :tremolo do
    n = sc.choose
    4.times do
      play chord([n, n+12].tick, :M), pan: 0.6
      sleep 1
    end
  end
end

live_loop :tb, sync: :main do
  stop if tb == 0
  use_random_seed rs
  sc1 = scale(:C3, :minor_pentatonic)
  sc2 = scale(:C3, :minor_pentatonic)
  ns1 = sc1.shuffle.take(4)
  ns2 = sc2.shuffle.take(4)
  use_synth :tb303
  use_synth_defaults sustain: 1
  with_fx :slicer do
    with_fx :echo, phase: 0.15 do
      3.times do
        4.times do
          play ns1.tick, pan: rrand(-1,1)
          sleep 1
        end
      end
      4.times do
        play ns2.tick, pan: rrand(-1,1)
        sleep 1
      end
    end
  end
end

load_synthdefs "/home/jose/projects/sonic_pi/sc/"
use_synth :brightlead

ns = [60, 64, 67, 69];
live_loop :changer do
  use_synth :brightlead
  use_random_seed 19 #16`
  ns = ns.shuffle
  4.times do
    n = ns.tick
    play freq: n, rate: 4
    sleep 0.5
  end
end

live_loop :bg, sync: :changer do
  use_synth :growl
  play chord(ns.choose, 'm7'), sustain: 2
  sleep 2
end





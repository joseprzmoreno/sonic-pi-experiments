t = 0.25

live_loop :main do
  use_synth :hoover
  with_fx :flanger, depth: 400 do
    play chord([:A4, :Bb4, :C5, :Bb4,
    :A4, :Bb4, :C5, :E5 ].tick, :M),
      attack: 0.1, release: 0.1, sustain: t * 4 - 0.1, amp: 0.3
    sleep t * 4
  end
end

live_loop :melody, sync: :main do
  use_random_seed 18
  use_synth :pluck
  ns = [:A3, :A4, :G4, :F4, :E4, :Eb4, :G4, :D4].shuffle.ring #.shuffle
  ds = [t, t*0.5, t*1.5, t, t, t*0.5, t*1.5, t]
  for i in 0..ns.length()-1 do
    play [ns[i]]
    sleep ds[i]
  end
end




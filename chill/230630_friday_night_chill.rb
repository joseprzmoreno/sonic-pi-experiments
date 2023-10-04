t = 0.25

live_loop :base do
  sample :drum_bass_soft
  sleep t
  sample :drum_bass_soft, rate: 2
  sleep t
end

live_loop :main, sync: :base do
  stop
  use_synth :chipbass
  notes = [:C4, :D4, :G4, :A4]
  durs = [t, t * 2, t, t * 4]
  for i in 0..notes.length()-1 do
    play notes[i]
    sleep durs[i]
  end
end

live_loop :sec, sync: :main do
  stop
  use_synth :dpulse
  #use_synth [:dpulse, :pulse, :dsaw, :saw, :hoover, :growl].choose
  s = scale(:C5, :major)
  ss = s + [:r]
  sss = ss.shuffle
  #with_fx :echo, phase: t * 0.25 do
  with_fx :wobble do
    play sss.tick, release: 0.2,
      amp: 0.6 #0.8
  end
  #end
  sleep t
end

live_loop :bass, sync: :main do
  stop
  use_synth :hollow #:dsaw
  use_synth_defaults sustain: t * 2, # 4,
    amp: 4 #1
  if one_in(4) then
    bassline(:G3, :M)
    bassline(:A3, :M7)
    bassline(:C3, :M)
    bassline(:D3, :M7)
  else
    bassline(:C3, :M)
    bassline(:D3, :M7)
  end
end

define :bassline do |n, q|
  play chord(n, q)
  sleep t * 4
end

c = 0
live_loop :r2, sync: :base do
  stop
  sample :glitch_bass_g, rate: 4, amp: [0.6, 0.3].tick
  sleep t
  sample :tabla_dhec, rate: 1.5 if c % 4 == 2
  c += 1
end

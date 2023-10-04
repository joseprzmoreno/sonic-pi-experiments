t = 0.25
m = t * 4
amp_line1 = 1

ns = scale(:C4, :dorian)
#ns = scale(:G4, :dorian)

live_loop :bg do
  use_synth :hoover
  notes = [:D5, :C5]
  notes2 = [:F5, :Bb5]
  n = notes.tick
  with_fx :hpf, cutoff: 80 do
    play [n, n + 5],
      amp: 0.6, release: m * 2
  end
  sleep m * 2
end

c = 0
live_loop :perc, sync: :bg do
  if c % 8 == 0 then
    c = 0
  end
  if c % 2 == 0 then
    sample :drum_bass_soft
  end
  if c % 4 == 0 then
    sample :drum_heavy_kick
  end
  if c % 3 == 0 or c % 7 == 0 then
    sample :elec_bell, rate: rrand_i(2,5)
  end
  c = c + 1
  sleep t
end

count = 0
live_loop :line1, sync: :bg do
  use_synth :supersaw
  if count % 10 == 0 then
    sleep m * 2
  else
    durs = [t * 2, t, t * 2, t, t *2, t,
            t * 0.5, t * 0.5, t * 1.5, t * 0.5]
    n = ns.choose
    play [n, n+5], amp: amp_line1, release: 0.8,
      pan: rrand(-0.8, 0.8)
    sleep durs.tick * 2
  end
  count = count + 1
end

live_loop :voice, sync: :bg do
  #stop
  path = "/home/jose/projects/sonic_pi/audios/"
  phr1 = "sunergasia.wav"
  phr2 = "alla.wav"
  with_fx :reverb do
    sample path + phr1
    sleep m * 4
    sample path + phr2
    sleep m * 8
  end
end

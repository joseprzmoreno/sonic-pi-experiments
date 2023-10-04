t = 0.25

ambi = 0
ambi2 = 0
bells = 0
organ = 0

define :flag do |name|
  if name == 0 then
    stop
  end
end

live_loop :r do
  sample :drum_bass_hard
  sleep t
  sample :perc_snap
  sleep t
end

live_loop :bass, sync: :r do
  use_synth :beep
  sleep t
  play :A2
  sleep t
  play :G2
  sleep t * 2
end

live_loop :ambi, sync: :r do
  flag(ambi)
  use_synth :dsaw
  use_synth_defaults release:0.30
  play chord(:Ab3, '5') # + 7
  sleep t * 3
  play chord(:B3, '5') # + 7
  sleep t * 0.5
  play :Ab2, release: 0.10
  sleep t * 0.25
  play :B2, release: 0.10
  sleep t * 0.25
end

live_loop :ambi2, sync: :r do
  flag(ambi2)
  use_synth :hoover
  s = scale(:Ab3, :minor_pentatonic)
  with_fx :ixi_techno do
    play chord(s.tick, '5')
    sleep t * 4
  end
end

live_loop :bells_loop, sync: :r do
  flag(bells)
  bells 0
  #bells 0.4
  #bells 0.7
  sleep t
end

define :bells do |detune|
  use_synth :pretty_bell
  use_synth_defaults amp: 0.3
  s = scale(:Ab5, :minor_pentatonic)
  with_fx :echo do
    n = Time.now.to_i
    play s[n] + detune
    sleep t
  end
end

live_loop :organ do
  flag(organ)
  use_synth :organ_tonewheel
  use_synth_defaults sustain: t * 4 #*4, *12
  s = scale(:Ab5, :minor_pentatonic).reverse
  with_fx :flanger do
    with_fx :reverb do
      play chord(s.tick, '5')
    end
  end
  sleep t * 4
  play :r
  sleep t * 4
end

"Propuesta de letra:
Aquí vine a encontrar
lo que tanto busqué
y siempre quise tener
Aquí lo vine a encontrar (-aaar (falsete))"

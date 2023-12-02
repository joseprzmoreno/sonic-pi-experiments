use_bpm 120

r = 1
bl = 1
saw = 0
piano = 0
bells = 0

live_loop :main do
  sleep 4
end

live_loop :r, sync: :main do
  stop if r == 0
  c = 0
  16.times do
    sample :drum_snare_hard if c % 2 == 0
    sample :drum_snare_soft if c % 2 == 1
    sample :elec_blip, amp: 2 if c % 2 == 1
    sample :drum_cymbal_pedal
    sample :bd_808
    sleep 0.5
    sample :drum_snare_soft if c % 4 == 1
    sample :drum_cymbal_pedal, amp: 0.5
    sleep 0.5
    c += 1
  end
end

live_loop :bassline, sync: :main do
  stop if bl == 0
  use_synth :bass_foundation
  use_synth_defaults sustain: 8, amp: 1
  sc = scale(:D3, :dorian)
  with_fx :flanger do
    play chord(sc[0], '6')
    sleep 8
    play chord(sc[4], '6')
    sleep 8
  end
end

live_loop :saw, sync: :main do
  stop if saw == 0
  use_synth :dsaw
  use_synth_defaults release: 8, amp: 0.6
  with_fx :reverb do
    play chord([:C4, :D4, :C4, :A3].tick, :M)
  end
  sleep 4
end

live_loop :piano, sync: :main do
  stop if piano == 0
  use_synth :piano
  notes = [:C5, :A4]
  notes = [:G4, :D4] if one_in(4)
  2.times do
    play notes.tick - 24
    sleep 0.5
  end
end

live_loop :bells, sync: :main do
  stop if bells == 0
  use_synth :prophet
  chords = [
    chord(:D4, :M),
    chord(:G4, :m),
    chord(:F4, :M7),
    chord(:G4, :M)
  ]
  4.times do
    with_fx :hpf, cutoff: 60 do
      play_pattern chords.tick(:chs), amp: 1.5, release: 2
      sleep [1,2,1,4].tick(:ds)
    end
  end
end






















bt = 0.25
add = 0

live_loop :mel1 do
  use_synth :zawa
  chords = ring(:C4 + add, :Eb4 + add, :D4 + add, :Fs4 + add, :Eb4 + add).shuffle
  qualities = ring(:m7, :m7, :m7, :M7, :M)
  durs = ring(bt*3, bt, bt*2, bt*2, bt*4).shuffle
  play chord(chords.tick, qualities.tick), attack: bt*0.5, sustain_level:
    0.7, sustain: 0.2, release: bt
  sleep durs.tick
end

live_loop :perc1, sync: :mel1 do
  z = rrand_i(1,5)
  if z == 5
    sleep bt
  elsif z == 4
    2.times do
      sample :drum_cowbell, rate: rrand_i(1,3), amp: 0.2
      sleep bt * 0.5
    end
  else
    sample :drum_cowbell, rate: rrand_i(1,3), amp: 0.2
    sleep bt
  end
end

live_loop :background, sync: :mel1 do
  use_synth :bass_foundation
  with_fx :flanger do
    play [:Eb3 + add, :Fs3 + add, :C3 + add, :D3  + add, :D3 + add].choose,
      release: bt*3, amp: 0.3
  end
  sleep bt
end
use_bpm 120

live_loop :drums do
  sample :drum_tom_lo_soft
  sleep 2
end

live_loop :drums2, sync: :drums do
  sample :ambi_glass_rub, rate: 0.2
  sleep 4
end

live_loop :magic, sync: :drums do
  use_synth :tech_saws
  play :D3, sustain: 0.6
  sleep 2
  play :F3, sustain: 0.6
  sleep 2
end

live_loop :mel, sync: :drums do
  use_synth :chiplead
  n = [:D4, :D4, :E4, :G4].tick(:ns)
  6.times do
    with_fx :gverb do
      play chord(n, 'M'), release: 0.25
    end
    sleep [0.75, 1, 0.5, 0.5, 0.5, 0.5].tick(:durs)
  end
end

live_loop :claves, sync: :drums do
  stop
  use_synth :sc808_claves
  freq = 180
  amp = 0.45
  8.times do
    play freq, amp: amp
    freq = freq * 0.75
    amp = amp * 1.25
    sleep 0.25
  end
end


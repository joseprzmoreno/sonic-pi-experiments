sc = scale(:D3, :minor)

live_loop :background do
  use_synth :piano
  durs = [0.25, 0.5]
  if one_in(4) then
    n = sc.tick
    d = durs.tick
    play chord(n, :m7), amp: 0.4, pan: -0.5
    sleep d * 0.5
    play chord(n, :m7), amp: 0.2, pan: -0.5
    sleep d * 0.5
  else
    amp = 0.3
    if one_in(10) then
      amp = 0.9
    end
    play chord(sc.tick, :m7), amp: amp, pan: -0.5
    sleep durs.tick
  end
end

live_loop :melody, sync: :background do
  use_synth :piano
  notes = scale(:G3, :minor_pentatonic, num_octaves: 2) + [:r]
  notes = notes.shuffle
  play notes.tick, amp: 0.3, pan: 0.5
  sleep [0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 1].choose
end

live_loop :ambiance, sync: :background do
  stop #uncommented commented
  use_synth :organ_tonewheel
  with_fx :reverb do
    with_fx :lpf, cutoff: 70 do
      play chord(scale(:G5, :minor_pentatonic).choose, [:M, :m].tick)
    end
  end
  sleep 2
end

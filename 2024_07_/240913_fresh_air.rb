live_loop :main do
  sample :drum_cymbal_closed, rate: 2
  sleep 0.5
end

live_loop :drums, sync: :main do
  stop
  use_synth :sc808_claves
  play 60
  sleep 0.25
  play 60
  sleep 0.25
  play 72
  sleep 0.5
end

live_loop :music, sync: :main do
  use_synth :tech_saws
  with_fx :lpf, cutoff: 90 do
    with_fx :flanger do
      play chord(scale(:C5, :minor_pentatonic).take(4).tick, '6'), sustain: 1
    end
  end
  sleep 1
end

live_loop :mel, sync: :main do
  poss = [5, 3, 5, 1]
  poss = [4, 3, 4, 2] if one_in 2
  poss = [4, 2, 1, 0] if one_in 2
  poss = [5, 3, 5, 1] if one_in 2
  sc = scale(:C4, :minor_pentatonic)
  use_synth :blade
  play sc[poss.tick(:ds)]
  sleep 0.5
  play sc[poss.tick(:ds)]
  sleep 1.5
  play sc[poss.tick(:ds)]
  sleep 0.5
  play sc[poss.tick(:ds)]
  sleep 0.5
end

live_loop :bells, sync: :main do
  use_random_seed 12
  use_synth_defaults amp: 0.3
  use_synth :pretty_bell
  4.times do
    2.times do
      play chord(scale(:C6, :minor_pentatonic).choose, '5'), pan: [-1, 1].tick(:ps)
      sleep 0.25
    end
    sleep 0.5
  end
end

live_loop :bass do
  use_synth :saw
  use_synth_defaults release: 0.1, sustain: 0.05
  play :C2
  sleep 0.25
  play :D2
  sleep 0.25
end

live_loop :main do
  use_synth :zawa
  with_fx :echo do
    play chord(scale(:D4, :major).choose, '6'), amp: 0.4
    sleep [2, 1, 2, 1, 2].tick
  end
end

live_loop :second, sync: :main do
  sample :drum_bass_soft, amp: 4
  sleep 0.5
end



live_loop :chords do
  use_synth :tech_saws
  sc = scale(:D4, :minor_pentatonic)
  with_fx :reverb do
    play chord(sc.choose, '6'), sustain: 2, release: 0
  end
  sleep 2
end

live_loop :drum, sync: :chords do
  sample :drum_bass_soft
  sleep 0.5
end

live_loop :organ, sync: :chords do
  use_synth :organ_tonewheel
  sc = scale(:A4, :minor_pentatonic)
  with_fx :panslicer do
    q = '5'
    q = '6' if one_in 4
    play chord(sc.choose, q), sustain: 1
  end
  sleep 1
end

live_loop :cyms, sync: :chords do
  use_synth :sc808_closed_hihat
  play [60, 62, 64, 68].tick, amp: 0.1
  sleep 0.25
end



live_loop :hoov do
  use_synth :pulse
  with_fx :lpf, cutoff: 90 do
    with_fx :reverb, mix: 0.8, room: 0.1 do
      play chord([:C4, :D4, :C4, :D4, :C4, :A4, :G4, :D4].tick(:hs), 'M'), attack: 0.01,
        sustain: 0.5, release: 0, amp: 1, pan: -0.5
    end
  end
  sleep 0.5
end

live_loop :drums, sync: :hoov do
  sample :drum_bass_hard
  sleep [1,2,1].tick
end

live_loop :mel, sync: :hoov do
  use_synth :tech_saws
  use_random_seed 12
  use_synth_defaults sustain: 1
  sc = scale(:C5, :minor_pentatonic)
  prev = sc.choose
  16.times do
    if one_in (6) then
      play chord(prev, '6')
    else
      prev = sc.choose
      play chord(prev, '6')
    end
    sleep 1
  end
end

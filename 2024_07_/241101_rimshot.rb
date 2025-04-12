use_bpm 120

live_loop :base do
  use_synth :sc808_rimshot
  with_fx :reverb do
    play 60
    sleep 1
    play 60
    sleep 0.5
    play 60
    sleep 0.5
  end
end

live_loop :orns, sync: :base do
  use_synth :blade
  with_fx :reverb do
    chords = [:F4, :G4, :A4, :C5]
    4.times do
      play chord(chords.tick, '6'), sustain: 2
      sleep 2
    end
  end
end

live_loop :saw, sync: :base do
  use_synth :tech_saws
  with_fx :echo do
    with_fx :nlpf, amp: 0.2 do
      if not one_in(5) then
        play scale(:D6, :minor_pentatonic).choose,
          sustain: 0.1, release: 0.1, amp: 0.5, pan: rrand(-1,1)
      end
    end
    sleep 0.25
  end
end

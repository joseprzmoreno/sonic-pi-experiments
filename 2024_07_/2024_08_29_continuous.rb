use_bpm 120

live_loop :drums do
  sample :drum_bass_soft, amp: 2
  sleep 1
end

live_loop :cyms, sync: :drums do
  sample :drum_cymbal_closed, amp: [1, 0.5, 0.75, 0.25].tick
  sleep 0.25
end

live_loop :noise, sync: :drums do
  use_synth :bnoise
  play 60, amp: 0.5
  sleep 4
end

live_loop :ambi, sync: :drums do
  use_synth :tech_saws
  notes = [:C4, :D4, :G4, :A4]
  with_fx :echo do
    play chord(notes.tick, '6'), sustain: 0.1, release: 0.2
    sleep 1
  end
end

live_loop :saw, sync: :drums do
  use_synth :saw
  with_fx :reverb do
    with_fx :panslicer do
      play [:C4, :G3, :B3, :A3].tick(:ns), sustain: [4, 4, 4, 4, 8, 8, 8, 8].tick(:durs), release: 0, amp: 0.3
    end
  end
  sleep 8
end

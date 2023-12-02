use_bpm 120

live_loop :bells do
  sleep 4
end

live_loop :bells2, sync: :bells do
  use_synth :hoover
  notes = [:C3, :C4, :D3, :D4]
  4.times do
    with_fx :echo, phase: 0.15 do
      play notes.tick(:ns), release: 0.3, pan: -0.6
    end
    sleep 1
  end
end

live_loop :cym, sync: :bells do
  sample :drum_cymbal_soft, amp: [0.6, 0.3].tick, rate: 1.2
  sleep 0.25
end

live_loop :bells3, sync: :bells do
  use_synth :prophet
  use_synth_defaults sustain: 4
  with_fx :flanger do
    play chord([:G4, :A4, :D4, :E4].tick, :M7), pan: 0.6
  end
  sleep 4
end

live_loop :tb, sync: :bells do
  use_synth :tb303
  with_fx :slicer do
    with_fx :echo, phase: 0.15 do
      play [:C3, :D3, :G3, :A3,
            :C3, :D3, :G3, :A3,
            :C3, :D3, :G3, :A3,
            :D3, :F3, :E3, :A3
            ].tick, sustain: 1, pan: rrand(-1,1)
    end
  end
  sleep 1
end

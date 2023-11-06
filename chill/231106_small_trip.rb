use_bpm 90

live_loop :main do
  sleep 4
  #triangle [0,0,1].tick
end

live_loop :piano, sync: :main do
  with_fx :gverb do
    3.times do
      piano_loop
    end
    piano_loop_with_echo
  end
end

define :piano_loop do
  use_synth :piano
  use_synth_defaults amp: 2
  play chord(:C4, '5')
  sleep 1
  play chord(:D4, '5')
  sleep 1
  play chord(:A3, '5')
  sleep 2
end

define :piano_loop_with_echo do
  use_synth :piano
  use_synth_defaults amp: 2
  2.times do
    play chord(:C4, '5')
    sleep 0.5
  end
  2.times do
    play chord(:D4, '5')
    sleep 0.5
  end
  play chord(:A3, '5')
  sleep 0.75
  play chord(:A3, '5')
  sleep 1.25
end

live_loop :rhythm, sync: :main do
  stop
  sample :elec_soft_kick
  sleep 0.5
  sample :elec_snare
  sleep 0.5
end

live_loop :base, sync: :main do
  stop
  sample :elec_chime, finish: 0.01, amp: [0.8, 0.6].tick
  sleep 0.25
end

live_loop :bassline, sync: :main do
  stop
  use_synth :dsaw
  3.times do
    play :F2, sustain: 2
    sleep 2
    play :G2, sustain: 2
    sleep 2
    play :D2, sustain: 4
    sleep 4
  end
end

define :triangle do |var|
  notes = [
    [:C6, :D6, :C6, :A5],
    [:G5, :A5, :G5, :E5]
  ]
  ns = notes[var]
  use_synth :tri
  play ns[0]
  sleep 0.5
  play ns[1]
  sleep 0.25
  play ns[2]
  sleep 0.25
  play ns[3]
  sleep 1
end

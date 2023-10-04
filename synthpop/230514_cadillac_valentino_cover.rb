t = 0.22
voice = 0

live_loop :perc do
  sample :drum_bass_hard, amp: 0.5
  sleep t * 2
  sample :drum_cymbal_closed, rate: 1.5
  sleep t * 2
end

count = 0
live_loop :bass, sync: :perc do
  stop
  count = count + 1
  use_synth_defaults release: 0.2
  use_synth :bass_foundation
  ns = [:A2, :A2, :G2, :G2, :E2, :E2, :G2, :G2]
  if count % 4 == 0 then
    ns = [:E2, :E2, :D2, :D2, :B1, :B1, :D2, :D2]
  end
  play_pattern_timed ns, t, amp: 1.2
end

live_loop :ambiance, sync: :perc do
  #stop
  use_synth_defaults release: 1, amp: 0.4 #1 2
  use_synth :hoover
  play [:A4, :A4 + 7], pan: -0.3
  sleep t * 8
  play [:E4, :E4 + 7], pan: 0.3
  sleep t * 8
end

notes = [:A4, :A4, :C5, :B4, :G4, :A4,
         :E4, :E4, :Fs4, :E4, :D4, :C4]

live_loop :notes_randomizer, sync: :perc do
  sleep t * 24
  notes = notes.shuffle
end

voice = 0
live_loop :voice, sync: :notes_randomizer do
  if voice == 0 then stop end
  use_synth :dsaw #dsaw prophet rodeo
  with_fx :flanger do
    play_pattern_timed notes,
      [t * 2, t, t, t * 2, t, t * 4], amp: 0.3
  end
end

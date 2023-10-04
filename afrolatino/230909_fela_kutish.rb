# Tempo and Time Signature
use_bpm 120
use_synth :saw
time_signature = 4
t = 0.25

# Define a function for the bassline
live_loop :bassline do
  notes = (ring :e1, :f1, :g1, :a1)
  durations = (ring 1, 1, 1, 1)
  play_pattern_timed notes, durations
end

live_loop :main, sync: :bassline do
  use_synth :organ_tonewheel
  use_synth_defaults sustain: t * 1.25, attack: 0.05, release: 0.5
  notes = scale(:G4, :major_pentatonic)
  if one_in(3) then
    sleep t
  else
    z = rrand_i(0,2)
    if z == 0 then
      play notes.choose, amp: 2
      sleep t
      
    elsif z == 1 then
      play chord(notes.choose, :M7), amp: 4
      sleep t
      
    else
      n = notes.choose
      2.times do
        play n, amp: 2
        sleep t * 0.5
      end
    end
    sleep t
  end
end

# Define a function for the brass section
live_loop :brass_section, sync: :bassline do
  use_synth :fm
  notes = (ring :e4, :g4, :a4, :b4)
  durations = (ring 0.5, 0.5, 0.5, 0.5)
  4.times do
    play_pattern_timed notes, durations, amp: 0.7, release: 0.1
  end
end

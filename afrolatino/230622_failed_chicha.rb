t = 0.3
t025 = t * 0.25
t033 = t * 0.334
t04 = t * 0.4
t05 = t * 0.5
t066 = t * 0.667
t075 = t * 0.75
t15 = t * 1.5
t2 = t * 2
t4 = t * 4

define :flag do |flag|
  if flag == 0 then stop end
end

define :play_timed do |notes, times, **args|
  ts = times.ring
  notes.each_with_index do |note, i|
    play note, **args
    sleep ts[i]
  end
end

perc1 = 1
live_loop :perc1 do
  use_sample_defaults amp: 0.6
  flag(perc1)
  sample :drum_cymbal_closed
  sleep t
  sample :drum_bass_soft
  sleep t075
  sample :drum_bass_soft, amp: 0.4
  sleep t04
end

voice1 = 1
live_loop :voice1 do
  flag(voice1)
  use_synth :tri
  n1 = [:D4, :A3, :D4, :Cs4, :C4, :E4, :G3, :Bb3, :C4]
  with_fx :eq do
    play_timed n1, [t2, t05, t075, t075, t, t, t05, t, t05, t05],
      release: rrand(0.2, 0.3), amp: 2
  end
end

bass0 = 1
live_loop :bass1 do
  flag(bass0)
  sleep t
end
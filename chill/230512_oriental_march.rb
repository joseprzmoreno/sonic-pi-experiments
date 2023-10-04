t = 0.25

perc = 1
line1 = 0
line2 = 0
bass = 0
voice = 0

define :flag do |flag|
  if flag == 0 then
    stop
  end
end

define :turn_off do
  bass = 0
  sleep t * 8
  voice = 0
  sleep t * 8
  line2 = 0
  sleep t * 8
  line1 = 0
  sleep t * 8
  perc = 0
end

live_loop :perc do
  flag(perc)
  sample :drum_cymbal_closed, amp: [1, 0.5, 0.8, 0.3].tick
  sleep t
end

live_loop :line1, sync: :perc do
  flag(line1)
  s = scale(:D4, :minor_pentatonic)
  use_synth :organ_tonewheel
  s = s.tick
  play [s, s+5], pan: -0.6
  sleep t
end

live_loop :line2, sync: :perc do
  flag(line2)
  if one_in(10)
    sleep t * 8
  else
    use_synth :organ_tonewheel
    s = scale(:D5, :minor_pentatonic)
    with_fx :reverb do
      play s.choose, amp: 0.8, pan: 0.6
    end
    sleep t * 4
  end
end

n = 5
live_loop :bass, sync: :perc do
  if one_in(4) then
    n = rrand_i(5,9)
  end
  flag(bass)
  s = scale(:D3, :minor_pentatonic).reverse.take(4)
  s2 = scale(:D3, :minor_pentatonic).reverse.take(n).reverse.take(4)
  use_synth :blade
  play s.tick, pan: -0.3
  sleep t
  play s2.tick, pan: 0.3
  sleep t
end

live_loop :voice, sync: :perc do
  flag(voice)
  use_synth :pluck
  s = scale(:D5, :minor_pentatonic).shuffle
  s = s.tick
  play s, amp: 4 #s 4  [s, s+5] 8
  sleep [t * 4, t * 2, t, t, t, t * 2, t].tick
end

#turn_off
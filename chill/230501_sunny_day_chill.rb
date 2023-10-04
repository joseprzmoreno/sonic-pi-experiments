t = 0.25

s = scale(:C5, :minor_pentatonic)
sb = scale(:C3, :minor_pentatonic)
p1_initial = s.choose
p2_initial = sb.choose

n1 = p1_initial
use_synth :beep
stop
live_loop :player1 do
  if one_in(10) then
    play :r
  else
    with_fx :reverb do
      play n1, amp: rrand(0.7, 0.9),
        release: rrand(0.1,0.2)
    end
  end
  sleep t
  z = rrand_i(-4, 4)
  n1 = s[tick + z]
end

n2 = p2_initial
use_synth :supersaw
live_loop :player2, sync: :player1 do
  play chord(n2, :major), release: t*2 #:minor
  sleep t * 2
  play chord(n2, :m11), release: t*2 #:m7
  sleep t * 2
  z = rrand_i(-2, 2)
  n2 = sb[tick + z]
end

live_loop :perc, sync: :player1 do
  stop
  sample :loop_safari
  sleep t * 12
end



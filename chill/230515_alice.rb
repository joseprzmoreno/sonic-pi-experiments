t = 0.33

s = scale(:C4, :minor_pentatonic, num_octaves: 2)
s2 = s.take(4).shuffle

live_loop :bg do
  #stop
  use_synth :tri #:hollow
  with_fx :echo, phase: t do
    play_pattern_timed s.shuffle,
      [t * 1.5, t * 0.5], amp: 1.2 #0.6
  end
end

live_loop :fg, sync: :bg do
  stop
  use_synth :piano #:square
  n = s2.tick
  q = [:M, :M, '6'].choose
  with_fx :reverb do
    play chord(n, q)#, amp: 0.6, release: 0.2
  end
  sleep t
  if one_in(4) then
    play chord(n, q)#, amp: 0.6, release: 0.2
  end
  sleep t
end

live_loop :voice, sync: :bg do
  stop
  use_synth :prophet #chiplead
  if one_in(4) then
    sleep t * 4
  end
  if one_in(6) then
    with_fx :distortion do
      with_fx :hpf, cutoff: 70 do
        3.times do
          play chord(s2.choose, 'M'), amp: 0.6
          sleep t
        end
      end
    end
  end
  durs = [1,1,1,1,1.5,2,2.5,4].shuffle
  #durs = [0.5,0.5,1].shuffle
  with_fx :distortion do
    with_fx :hpf, cutoff: 70 do
      play s.choose - 12, amp: rrand(0.1,0.2)
    end
  end
  sleep t * durs.tick
end

live_loop :bass1 do
  use_synth :bass_foundation
  play :d2, release: 0.15
  sleep 0.25
  play :d2, release: 0.15
  sleep 0.25
  play :g2, release: 0.15
  sleep 0.25
  play :a2, release: 0.15
  sleep 0.25
end

define :line_play do |note|
  play note, amp: 0.8, release: 0.1
end


live_loop :line1, sync: :bass1 do
  stop
  use_synth :pulse
  s = scale(:d4, :minor_pentatonic).shuffle
  line_play(s.tick)
  sleep 0.25
end

define :voice do |n|
  if n == 1
    sample "/home/jose/audios/something_must_change.wav", rate: rrand(0.90,1.10)
  else
    sample "/home/jose/audios/algo_tiene_que_cambiar.wav", rate: rrand(0.90,1.10)
  end
end

live_loop :line2, sync: :bass1 do
  stop
  use_synth :prophet
  durs = [0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5, 0.75, 0.25, 1, 1, 1, 0.25, 0.25].shuffle.ring
  chords = [chord(:d5, :m), chord(:a5, :M), chord(:g5, :m)].shuffle.ring
  with_fx :flanger, phase: 0.45 do
    play chords.tick, amp:0.8, release: durs.tick * 2
    if dice(12) == 12
      in_thread do
        d = dice(2)
        6.times do
          #voice(d)
        end
      end
    end
  end
  sleep durs.tick
end
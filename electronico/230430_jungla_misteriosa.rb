t = 0.25
m = t * 4

flag_bg = 1
flag_bg2 = 1
flag_perc = 0
flag_song = 0
flag_song2 = 0

define :flag do |flag|
  if flag == 0 then
    stop
  end
end


live_loop :bg do
  flag(flag_bg)
  d = scale(:D4, :dorian)
  use_synth :winwood_lead
  with_fx :reverb do
    with_fx :flanger do
      with_fx :lpf, cutoff: 80 do
        play [d.choose, d.choose, d.choose], release: m * 2.2,
          pan: -0.3
      end
    end
  end
  sleep m * 2
end

live_loop :bg2, sync: :bg do
  flag(flag_bg2)
  s = scale(:D4, :minor_pentatonic)
  use_synth :pretty_bell
  with_fx :echo do
    play s.choose, release: 0.1, amp: 0.7, pan: 0.3
  end
  sleep [t, t*2, t, t*2, t].tick
end

live_loop :battery, sync: :bg do
  flag(flag_perc)
  sample :drum_cymbal_closed, rate: 1.5, amp: 0.5
  sleep [t*0.5, t*0.5, t*2, t*0.5, t*0.5].tick
end

notes = [60, 62, 59, 57, 55, 69, 71, 74].shuffle
live_loop :song, sync: :bg do
  flag(flag_song)
  if one_in(4) then
    notes = notes.shuffle
  end
  use_synth :blade
  play notes.tick, amp: 0.4
  sleep t
end

live_loop :song2, sync: :bg do
  flag(flag_song2)
  if one_in(4) then
    notes = notes.shuffle
  end
  use_synth :dtri
  n = notes.tick
  play [n, n+5], amp: 0.4
  sleep t
end










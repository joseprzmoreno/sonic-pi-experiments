use_bpm 120
t = 0.25
m = t * 4
sc = scale(:D4, :dorian)
bass_pattern = [sc[0]-12, :r, sc[0], :r]
ambiance_pattern = [sc[5], sc[7]]

perc_flag = 0
bass_flag = 0
ambiance_flag = 0
melody_flag = 0

define :flag do |fv|
  if fv == 0 then
    stop
  end
end

live_loop :perc do
  flag(perc_flag)
  
  in_thread do
    sleep m
    sample :tabla_dhec, amp: 0.5, pan: -0.6
    sleep m * 2
    sample :tabla_dhec, amp: 0.5, pan: -0.6
    sleep m
  end
  
  in_thread do
    count = 0
    16.times do
      if count != 4 and count != 12 then
        sample :drum_cymbal_closed, amp: 0.5
      end
      sleep t
    end
  end
  
  4.times do
    sample :drum_bass_soft, amp: 0.5, pan: 0.6
    sleep m
  end
end

live_loop :bass_randomizer, sync: :perc do
  flag(bass_flag)
  z = rrand_i(1, 4)
  if z == 1 then
    pattern = [sc[0]-12, :r, sc[0], :r]
  elsif z == 2 then
    pattern = [sc[2]-12, :r, sc[2], :r]
  elsif z == 3 then
    pattern = [sc[0]-12, sc[0]-12, sc[0], sc[0]]
  elsif z == 4 then
    pattern = [sc[2]-12, sc[2]-12, sc[2], sc[2]]
  end
  bass_pattern = pattern
  sleep t * 16
end

live_loop :bass, sync: :perc do
  flag(bass_flag)
  use_synth :prophet
  play bass_pattern.tick - 12, attack: 0.02, release: 0.2
  sleep t
end

live_loop :ambiance_randomizer, sync: :perc do
  flag(ambiance_flag)
  z = rrand_i(1,4)
  if z == 1 then
    pattern = [sc[5], sc[7]]
  elsif z == 2 then
    pattern = [sc[4], sc[6]]
  elsif z == 3 then
    pattern = [sc[2], sc[7]]
  elsif z == 4 then
    pattern = [sc[1], sc[3]]
  end
  ambiance_pattern = pattern
  sleep t * 16
end

live_loop :ambiance, sync: :perc do
  flag(ambiance_flag)
  use_synth :winwood_lead
  with_fx :flanger do
    with_fx :lpf, cutoff: 80 do
      play chord(ambiance_pattern.tick - 12, :m7), attack: 0.2, release: m * 5,
        amp: 0.5
    end
  end
  sleep m * 4
end

live_loop :melody, sync: :perc do
  flag(melody_flag)
  use_synth :chiplead
  notes = scale(:D4, :minor_pentatonic).shuffle
  if one_in(40) then
    sleep m * 4
  end
  if one_in(4) then
    sleep [t * 2, t].choose
  else
    if one_in(40) then
      use_synth :rodeo
      play chord(:D4, :m7), release: m * 4, amp: 0.5
    end
    use_synth :chiplead
    play notes.tick, release: rrand(0.2,0.4), amp: 0.8
    sleep [t * 2, t].choose
  end
end


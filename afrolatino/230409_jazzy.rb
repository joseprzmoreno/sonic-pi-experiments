t = 0.2

chords = :D4, :E4, :C4, :G4, :D4, :G4, :C4, :A4
qualities = :M, :m, :M, :m7, :M, :m, :M, :m7
durs = t, t*2, t, t*2, t, t*2, t, t*2
count = 0

live_loop :piano do
  use_synth :piano
  
  if one_in(4) then
    in_thread do
      3.times do
        sample :elec_bell
        sleep t
      end
    end
    chords = chords.shuffle
  end
  
  if one_in(4) then
    in_thread do
      3.times do
        sample :elec_blip
        sleep t
      end
    end
    qualities = qualities.shuffle
  end
  
  if one_in(4) then
    in_thread do
      3.times do
        sample :elec_blip2
        sleep t
      end
    end
    durs = durs.shuffle
  end
  
  if count < 4 or one_in(12) then
    if count >= 4 then
      in_thread do
        sample :ambi_choir, rate: 0.7
        sleep t
      end
    end
    chords = :D4, :E4, :C4, :G4, :D4, :G4, :C4, :A4
    qualities = :M, :m, :M, :m7, :M, :m, :M, :m7
    durs = t, t*2, t, t*2, t, t*2, t, t*2
  end
  
  for i in 0..7 do
    if i == 0 or i == 4 then
      bass(chords[i])
    end
    use_synth :piano
    play chord(chords[i], qualities[i]), pan: -0.5, release: rrand(t*2,t*4)
    sleep durs[i]
  end
  
  count = count + 1
end

define :bass do |freq|
  in_thread do
    use_synth :hollow
    play freq - 12, release: t * 4, pan: 0.5
    sleep t
  end
end

live_loop :pluck, sync: :piano do
  stop
  use_synth :pluck
  notes = scale(:C5, :dorian).shuffle + [:r]
  8.times do
    with_fx :lpf, cutoff: 120 do
      play notes.tick, amp: 0.4, pan: 0.9, release: rrand(t,t*2)
    end
    sleep t * [1,1,1,1,1,1,1,2,2,2,2,4,4].choose
  end
end

live_loop :pluck2, sync: :piano do
  stop
  use_synth :pluck
  notes = scale(:C3, :minor_pentatonic).shuffle + [:r]
  8.times do
    play notes.tick, pan: -0.9, amp: 0.2
    sleep t * [1,1,1,1,1,1,1,2,2,2,2,4,4].choose
  end
end
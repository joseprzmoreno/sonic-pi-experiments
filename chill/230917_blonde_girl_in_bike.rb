use_bpm 128

live_loop :kick do
  4.times do
    sample :bd_klub, amp: 2
    sleep 1
  end
end

live_loop :snare do
  sleep 1
  sample :sn_dolf, amp: 1
  sleep 1
end

live_loop :hihat do
  8.times do
    sample :drum_cymbal_closed, amp: 0.6
    sleep 0.5
  end
end

live_loop :bg, sync: :snare do
  use_synth :blade
  use_synth_defaults amp:1.2
  play chord(:C3, :M)
  sleep 1
  play chord(:C4, :M)
  sleep 1
  play chord(:G3, :m)
  sleep 1
  play chord(:G4, :M)
  sleep 1
end

live_loop :melody, sync: :bg do
  stop
  use_synth :piano
  use_synth_defaults amp:1.8
  sc = scale(:C4, :major)
  pat = [
    [3, 2],
    [3, 1],
    [5, 2],
    [3, 1],
    [2, 0.5],
    [1, 0.5],
    [0, 0.5],
    [1, 0.5]
  ]
  #pat = pat.shuffle
  pat.each do |chunk|
    if one_in(4) then
      play chord(sc[chunk[0]], '5'), amp: 3, release: 2
      sleep chunk[1]
    else
      play sc[chunk[0]]
      sleep chunk[1]
    end
  end
end

live_loop :finish do
  stop
  amp = 0.5
  49.times do
    set_volume! amp
    sleep 0.5
    amp = amp - 0.01
  end
end






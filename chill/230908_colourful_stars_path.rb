t = 0.25
s = scale(:D3, :minor_pentatonic, num_octaves: 2)

live_loop :chords do
  use_synth :hoover
  use_synth_defaults release: 0.3 #0.3 0.8
  use_random_seed [12,14,16,18].tick
  poss = []
  6.times do
    poss << rrand_i(0,7)
  end
  make_chord poss[0]
  """make_chord poss[1]
  make_chord poss[2]
  make_chord poss[3]
  sleep t * 8
  next"""
  sleep t * 3
  make_chord poss[1]
  make_chord poss[2]
  sleep t * 1
  make_chord poss[3]
  sleep t * 2
  make_chord poss[4]
  make_chord poss[5]
  sleep t * 2
end

define :make_chord do |pos|
  with_fx :hpf, cutoff: 80 do
    play chord(s[pos], '6'), amp: 2
  end
end

live_loop :r, sync: :chords do
  stop
  sample :perc_snap2, amp: 0.8
  sleep t
  sample :perc_snap2, amp: 0.3
  sleep t
  sample :perc_snap2, amp: 0.5
  sleep t
  sample :perc_snap2, amp: 0.2
  sleep t
end

live_loop :r2, sync: :r do
  stop
  sample :drum_cymbal_closed, amp: 0.4
  sleep t
end

live_loop :bass, sync: :chords do
  stop
  use_synth :blade
  use_random_seed 25
  use_synth_defaults release: 0.2
  ns = s.shuffle
  ds = [0,0,0,0,0,1,1,1,1,1,1,1].shuffle
  for i in 0..12 do
    with_fx :echo do
    play ns[i] - 24, amp: 3 if ds[i] == 1
  end
  sleep t
end
end

live_loop :song, sync: :chords do
  stop
  with_fx :reverb do
    use_synth :subpulse
    play chord(s.choose, 'M')
    sleep t * 2
    use_synth :dtri
    play chord(s.choose, 'M')
    sleep t * 2
    use_synth :pretty_bell
    play chord(s.choose, 'M')
    sleep t * 2
    use_synth :winwood_lead
    sleep t * 2
    play chord(s.choose, 'M')
  end
end

#set_volume! 0.5
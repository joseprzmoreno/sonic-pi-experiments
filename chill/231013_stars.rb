use_bpm 120

live_loop :met do
  sleep 4
end

rs = 50
live_loop :ambi do
  use_random_seed rs
  s = scale(:C3, :major)
  ss = s.shuffle.take(3)
  set :n, ss[0]
  4.times do
    echo ss[0]
    echo ss[1]
    echo ss[2]
    echo ss[1]
  end
  rs += 1
end

define :echo do |n|
  sleep 0.30
  use_synth :piano
  play chord(n, '6')
  play chord(n+12, :M)
  sleep 0.80
  play chord(n, '6')
  play chord(n+12, :M)
  sleep 0.90
end

live_loop :drums1, sync: :met do
  sample :drum_bass_hard, amp: 0.7
  sleep 1
end

live_loop :cymbals, sync: :met do
  sample :drum_cymbal_closed, amp: [0.3, 0.2, 0.1, 0.05].tick
  sleep 0.25
end

live_loop :ambi2, sync: :met do
  stop
  use_synth :hollow
  use_synth_defaults sustain: 8, release: 1
  n = get[:n]
  with_fx :flanger do
    play chord(n, '6'), amp: 1.5
  end
  sleep 8
end

live_loop :melody, sync: :met do
  stop
  use_synth :blade
  use_synth_defaults amp: 0.8
  ns = [:c4, :d4, :d4, :e4, :fs4, :g4, :r, :r].shuffle
  ns2 = [:d4, :e4, :r, :r, :r, :r, :r, :r].shuffle
  ns3 = [:c4, :e4, :d4, :fs4, :a4, :g4, :b4].shuffle
  ns = ns #ns2 ns3
  with_fx :echo, phase: 0.75 do #1.5 2
    play_pattern_timed(ns, 1) #[1, 0.75, 0.5, 0.75])
  end
end

vol = 1
live_loop :finish, sync: :met do
  stop
  99.times do
    set_volume! vol
    vol = vol - 0.01
    sleep 0.25
  end
end

#in the end, the the ambi piano play a long time alone without melody.
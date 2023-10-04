t = 0.5
m = t * 4

set :flag_r, 1
set :flag_r2, 1
set :flag_main, 1
set :flag_bassline, 1
set :flag_sec, 1

random_seeds = [111,222,333,444]

define :flag do |flag|
  if flag == 0 then stop end
end

live_loop :r do
  flag(get[:flag_r])
  sample :drum_bass_hard
  sleep t
end

live_loop :r2, sync: :r do
  flag(get[:flag_r2])
  sample :drum_cymbal_soft, rate: 2,
    amp: [1.2, 0.8].tick
  sleep t * 0.25
end

live_loop :main, sync: :r do
  flag(get[:flag_main])
  use_synth :dsaw
  if one_in(10) then
    change_random_seeds()
  end
  use_random_seed random_seeds.tick
  s = scale(:C4, :minor_pentatonic).shuffle
  c = 0
  durs = [t, t, t, t * 0.5, t * 0.5, t]
  6.times do
    play chord(s[c], :M)
    sleep durs[c]
    c = c + 1
  end
end

live_loop :bassline, sync: :main do
  flag(get[:flag_bassline])
  use_synth :blade
  use_synth_defaults amp: 0.5, release: 0.2
  dur = t
  if one_in(4) then
    dur = t * 0.5
  end
  play :C2, amp: 4
  sleep dur
  play :G2, amp: 4
  sleep dur
end

live_loop :sec, sync: :main do
  flag(get[:flag_sec])
  use_synth_defaults release: 0.2
  use_synth :dpulse
  s = scale(:C5, :minor_pentatonic).shuffle.take(2)
  sleep 0.02
  16.times do
    play chord(s[0], :M), amp: 0.8
    sleep t * 0.25
    play chord(s[1], :M), amp: 0.6
    sleep t * 0.25
  end
end

live_loop :hide do
  set :flag_bassline, 0 if one_in(8)
  set :flag_main, 0 if one_in(8)
  set :flag_r, 0 if one_in(8)
  set :flag_r2, 0 if one_in(8)
  set :flag_sec, 0 if one_in(8)
  sleep m
  set :flag_bassline, 1
  set :flag_main, 1
  set :flag_r, 1
  set :flag_r2, 1
  set :flag_sec, 1
  sleep m
end

define :change_random_seeds do
  random_seeds = [
    rrand_i(100,199),
    rrand_i(200,299),
    rrand_i(300,399),
    rrand_i(400,499)
  ]
end


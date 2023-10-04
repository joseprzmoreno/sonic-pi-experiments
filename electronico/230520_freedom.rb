set :finish, 0
define :check_finish do |seconds|
  if get[:finish] == 1 then
    sleep seconds
    stop
  end
end

live_loop :bg do
  check_finish(2)
  use_synth :saw #saw dtri growl
  with_fx :flanger do
    play chord(:E5, '5'),
      release: 1.5, amp: 0.5
    sleep 2
    play chord(:D5, :M),
      release: 1.5, amp: 0.3
  end
  sleep 2
end

live_loop :perc do
  check_finish(2)
  sample :drum_snare_soft,
    rate: 2, amp: rrand(0.5,0.7)
  sleep 0.25
  sample :drum_snare_hard, rate: 8,
    amp: rrand(0.05, 0.2)
  sleep 0.25
end

live_loop :bass, sync: :bg do
  stop
  check_finish(3)
  use_synth :dpulse
  ns = [:E3, :E3, :E3, :E3, :D3, :D3, :D3, :D3,
        :B2, :B2, :B2, :B2, :D3, :D3, :D3, :D3]
  n = ns.tick
  play [n, n + 7],
    amp: 0.3, release: 0.2, pan: -0.5
  sleep 0.25
end

live_loop :bass2, sync: :bass do
  stop
  check_finish(3)
  use_synth :chiplead
  ns = [:D2]
  sleep 0.05
  play ns.tick, release: 0.05, pan: -0.5
  sleep 0.20
end

define :play_timed do |notes, times, **args|
  ts = times.ring
  notes.each_with_index do |note, i|
    play note, **args
    sleep ts[i]
  end
end

ini = 0
live_loop :decider, sync: :bg do
  #ini = 2
  p1 = [:E4, :G4, :A4]
  d1 = [0.25, 0.25, 0.5]
  p2 = [:E4, :G4, :B4, :A4, :G4, :D4, :E4]
  d2 = [0.25, 0.25, 0.25, 0.75, 0.5, 0.25, 0.75]
  p3 = [:D5, :D5, :D5, :B4, :B4, :B4]
  d3 = [0.25, 0.25, 0.25, 0.25, 0.25]
  p4 = [[:E4, :A4], [:D4, :G4], [:G5, :B5],
        [:A4, :C5], [:B3, :D4], [:B3, :D4]]
  d4 = [0.5, 0.5, 0.5, 0.5, 0.25, 0.25]
  if ini == 2 then
    #improvise
    p = []
    d = []
    #D3 E3 1 1   1.5 0.5  D3 D3 E3 E3 D3 E3 7s 12 7
    set :p, [p, d]
    sleep 0.25
    next
  end
  if ini == 3 then
    p = [:E4, :E3, :E4]
    d = [1, 1, 1]
    sleep 3
    set :p, [p, d]
    set :finish, 1
  end
  if ini == 0 then
    set :p, [p1,d1]
  end
  ps = [[p1,d1],[p2,d2],[p3,d3],[p4,d4]]
  if one_in(5) then
    ini = 1
    set :p, ps.choose
  end
  sleep 0.25
end

live_loop :fg, sync: :bg do
  stop
  check_finish(1)
  use_synth_defaults amp:rrand(0.6,0.7)
  use_synth :rodeo
  with_fx :lpf, cutoff: 80 do
    with_fx :gverb, amp: 0.9 do
      p = get[:p]
      play_timed(p[0], p[1], pan: 0.5,
                 release: 0.6)
    end
  end
end

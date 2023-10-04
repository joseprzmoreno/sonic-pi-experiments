t = 0.25
ns = [:A4, :C5, :A4, :r]

define :flag do |flag|
  if flag == 0 then
    stop
  end
end

rh = 1
cow = 0
bass = 0
bg = 0
fg = 0

define :turn_off do
  rh = 0
  cow = 0
  sleep t * 4
  bg = 0
  sleep t * 4
  bass = 0
  sleep t * 16
  fg = 0
end

live_loop :rh do
  flag(rh)
  sample :drum_cymbal_closed,
    amp: [1, 0.6, 0.8, 0.3].tick
  sleep t
end

live_loop :bass, sync: :rh do
  flag(bass)
  use_synth :dull_bell
  play :Fs3, amp: 0.2, pan: -0.8
  sleep t * 2
  play :Fs3, amp: 0.2, pan: -0.8
  sleep t * 2
  play :E3, amp: 0.2, pan: -0.8
  if one_in(4) then
    play :E3, amp: 0.2, pan: -0.8
    sleep t * 2
  else
    sleep t * 4
  end
  
end

live_loop :bg_randomizer, sync: :rh do
  ns = [:A4, :C5, :A4, :r]
  if one_in(4) then
    ns = [:A4, :Fs4, :A4, :r]
  end
  if one_in(4) then
    ns = [:D4, :Fs4, :D5, :Bb4]
  end
  sleep t * 4
end

live_loop :bg, sync: :bg_randomizer do
  flag(bg)
  use_synth :prophet
  with_fx :echo, phase: t * 0.5 do
    play ns.tick, amp: 0.3, release: 0.1, pan: 0.3
  end
  sleep t * 2
end

rs = [8,7,6,5,4,3,2,1]
live_loop :cow, sync: :rh do
  flag(cow)
  if one_in(4) then
    8.times do
      r = rs.tick
      sample :drum_cowbell,
        rate: r, amp: 1 - (r * 0.10)
      sleep t
    end
  end
  sleep t * 8
end

prev = 0
n = ns.choose
durs = [t * 4, t * 4, t * 2, t * 2,
        t * 2, t * 3, t, t * 3, t].shuffle
live_loop :fg, sync: :bg do
  flag(fg)
  use_synth :hoover
  while n == prev do
    n = ns.choose
  end
  prev = n
  if n != :r then
    with_fx :flanger, depth: 0.1 do
      with_fx :hpf, cutoff: rrand_i(70,90) do
        play chord(n, :m7),
          release: t * rrand_i(4, 8),
          pan: rrand(-1, 1),
          amp: rrand(0.4, 0.6)
      end
    end
  end
  sleep durs.tick
end

#turn_off
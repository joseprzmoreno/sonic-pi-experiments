t = 0.25

live_loop :r do
  sample :drum_bass_hard
  sleep t
  sample :perc_snap
  sleep t
end

live_loop :bass, sync: :r do
  use_synth :beep
  sleep t
  play :A2
  sleep t
  play :G2
  sleep t * 2
end

live_loop :ambi, sync: :r do
  stop
  use_synth :supersaw
  ns = [:G4, :A4, :C5, :D4]
  4.times do
    play chord(ns.tick, :M), amp: 2
    sleep t * 2
  end
end

live_loop :mel, sync: :r do
  stop
  use_random_seed 44
  use_synth :tech_saws
  use_synth_defaults release: 0.15, amp: 1.5
  s = scale(:G4, :major)
  ini = rrand_i(0,4)
  cur = ini
  set :cur, s[cur]
  16.times do
    if one_in(2) then #2, 4
      play :r
    else
      with_fx :gverb do
        play s[cur] + 12
      end
      z = rrand_i(-2,2)
      cur = ini + z
    end
    sleep t
  end
end

live_loop :ambi2, sync: :mel do
  stop
  use_synth :supersaw
  cur = get[:cur] - 12
  with_fx :ixi_techno, phase: t * 16 do
    play chord(cur, :m6), sustain: t * 16
  end
  sleep t * 16
end

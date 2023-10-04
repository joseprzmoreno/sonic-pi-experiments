t = 0.25

live_loop :r do
  sample :perc_swash, rate: 2.5
  sample :drum_bass_hard
  sleep t
  sample :drum_cymbal_closed
  sleep t
  sample :drum_bass_hard, amp: 0.7
  sleep t
  sample :drum_cymbal_closed
  sleep t
end

live_loop :ambi, sync: :r do
  #stop
  use_synth :dsaw
  use_synth_defaults release: t * 3, amp: 0.7, attack: 0.02
  use_random_seed 2306  #2306 2312 2319
  4.times do
    s = scale(:D3, :dorian)
    play chord(s.choose, :M7)
    sleep t * 4
  end
end

live_loop :ambi2, sync: :r do
  #stop
  ns = [:B3, :B4, :B3, :r]
  #ns = [:Fs3, :Fs4, :Fs3, :r]
  #ns = [:D3, :D4, :D3, :r]
  use_synth :blade
  use_synth_defaults release: 0.1
  play_pattern_timed ns, t
end

live_loop :melody, sync: :r do
  #stop
  melody1
end


define :melody1 do
  use_synth :subpulse
  use_synth_defaults amp: 0.5
  with_fx :reverb do
    play 71
    sleep t * 2
    play 69
    sleep t
    play 66
    sleep t
    play 64
    sleep t
    play 62
    sleep t * 3
    3.times do
      play 66
      sleep t
    end
    sleep t
    3.times do
      play 69
      sleep t
    end
    sleep t
  end
  if one_in(4) then
    sleep t * 4
  end
end

define :melody2 do
  use_synth :subpulse
  use_synth_defaults amp: 0.5
  with_fx :reverb do
    play 69
    sleep t * 2
    play 66
    sleep t
    play 71
    sleep t
    play 74
    sleep t
    play 62
    sleep t * 3
    3.times do
      play 63
      sleep t
    end
    sleep t
    3.times do
      play 66
      sleep t
    end
    sleep t
  end
  if one_in(4) then
    sleep t * 4
  end
end

live_loop :bass, sync: :r do
  #stop
  use_synth :subpulse
  use_synth_defaults release: 0.1
  play :E2
  sleep t * 0.5
end

live_loop :echo, sync: :r do
  #stop
  use_synth :hoover
  use_synth_defaults release: 0.5, amp: 0.8
  with_fx :hpf, cutoff: 85 do
    play chord([:D3, :M7], [:G3, :M], [:D3, :M7], [:G3, :m]).tick
  end
  sleep t * 4
end



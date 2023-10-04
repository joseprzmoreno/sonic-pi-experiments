t = 0.1

live_loop :one do
  use_synth :supersaw
  use_synth_defaults release: 0.1, #0.1 0.3
    amp: 0.5
  use_random_seed 5 #5 11 19
  16.times do
    s = scale(:C3, :minor_pentatonic)
    n = s.choose
    set :n, n
    play n
    sleep t
  end
end

live_loop :two, sync: :one do
  stop
  use_synth :pulse
  use_synth_defaults sustain: 1, amp: 0.2
  n = get[:n]
  with_fx :whammy, grainsize: 0.3, mix: 0.9 do
    play [n + 12], pan: -0.6
    play [n + 19], pan: -0.9
  end
  sleep t * 4
end

live_loop :three, sync: :one do
  stop
  sample :loop_garzul, amp: 1.5
  sleep t * 16 * 4
end

live_loop :four, sync: :one do
  stop
  use_synth :prophet
  s = scale(:C3, :minor_pentatonic)
  n = s.choose
  with_fx :flanger do
    play chord(n, :M7), amp: rrand(0.8,1.2),
      sustain: t * 16, pan: rrand(-0.8,0.8)
  end
  sleep t * 16
end

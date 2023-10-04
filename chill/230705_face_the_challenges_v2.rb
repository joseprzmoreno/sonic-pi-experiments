t = 0.1

live_loop :one do
  use_synth :supersaw
  use_synth_defaults release: 0.2, #0.1 0.2
    amp: 0.9
  use_random_seed [5].tick #5 5 11 11 19 19 27 27
  16.times do
    s = scale(:C3, :minor_pentatonic)
    n = s.choose
    set :n, n
    play n, pan: -0.7
    sleep t
  end
end

live_loop :two, sync: :one do
  stop
  use_synth :pulse
  use_synth_defaults sustain: 0.3, amp: 0.1
  n = get[:n]
  with_fx :whammy, grainsize: 0.3, mix: 0.9 do
    play [n + 12], pan: 0.6
    play [n + 19], pan: 0.9
  end
  sleep t * 4
end

live_loop :three do
  stop
  sample :loop_garzul, amp: 1
  sleep t * 16 * 5
end

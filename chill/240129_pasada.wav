use_bpm 120
set_volume! 1

live_loop :main do
  sleep 4
  set :c, 0
end

live_loop :drums, sync: :main do
  c = get[:c]
  sample :drum_bass_hard if c % 4 == 0
  sample :sn_dub if c % 4 == 1 or c % 4 == 3
  with_fx :echo do
    sample :drum_cymbal_closed
  end
  sleep 1
end

live_loop :cyms, sync: :main do
  sample :drum_cymbal_pedal
  sleep 0.5
end

live_loop :ambi, sync: :main do
  use_synth :saw
  use_synth_defaults sustain: 2, release: 0.5, amp: 2
  with_fx :panslicer do
    play chord([:C3, :Fs3, :D3, :Bb3].shuffle.tick(:ns), [:M, :m, :m7, :M7].tick(:qs))
    #play chord([:C3, :Fs3, :D3, :Bb3].shuffle.tick(:ns), [:m7].tick(:qs))
  end
  sleep 2
end

live_loop :organ, sync: :main do
  use_synth :organ_tonewheel
  use_synth_defaults amp: 0.6, sustain: 0.4
  with_fx :reverb do
    play chord(:Fs8, '11+'), amp: 1
    sleep 1
    play chord(:Bb8, '11+'), amp: 0.8
    sleep 1
  end
end

live_loop :printer, sync: :main do
  sample :loop_3d_printer, amp: 0.8
  sleep 4
end

vol = 1
live_loop :finish, sync: :main do
  stop
  10000.times do
    set_volume! vol
    vol = vol - 0.01
    sleep 0.2
  end
end









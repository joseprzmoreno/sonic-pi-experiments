use_bpm 110
BASE = "~/projects/sonic-pi-experiments/samples/"

drums = 0
dolf = 0
cyms = 0
voice = 0
conga = 0
mel1 = 0
trance = 0

live_loop :drums do
  stop if drums == 0
  sample :bd_ada
  sleep 1
  sample :sn_generic, amp: 0.6
  sleep 1
end

live_loop :drums2, sync: :drums do
  stop if dolf == 0
  sample :sn_dolf
  sleep 1
end

live_loop :cyms, sync: :drums do
  stop if cyms == 0
  sample :drum_cymbal_pedal, amp: [0.8,0.2].tick(:ds) * 3
  sleep 0.25
end

live_loop :voice, sync: :drums do
  stop if voice == 0
  sample :loop_weirdo, amp: 3
  sleep 8
end

live_loop :conga, sync: :drums do
  stop if conga == 0
  conga = BASE + "conga.wav"
  durs = [0.5,1,2,0.5,0.5,1,0.5,1.5,0.5]
  durs = [0.5,1,2,0.5,0.5,1,0.5,1,1] if one_in(4)
  9.times do
    sample conga, amp: rrand(0.5, 0.8)
    sleep durs.tick(:ds2) * 0.5
  end
end

live_loop :trance, sync: :mel1 do #4.5 3.75 3
  stop if trance == 0
  rs = [4.5, 3.75, 3, 2.55]
  r = 4.5
  r = [4.5, 3.75, 3, 2.55].tick(:qs)
  sample :bass_trance_c, rate: rs[trance - 1]
  sleep 1
end

live_loop :mel1, sync: :drums do
  stop if mel1 == 0
  use_synth :pluck
  use_synth_defaults amp: 8
  4.times do
    play chord(:E4, :m)
    sleep 0.75
  end
  play chord(:Fs4, :m7)
  sleep 1
end




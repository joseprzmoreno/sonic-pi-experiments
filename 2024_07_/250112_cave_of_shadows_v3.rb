use_bpm 120
mute_drums = 0
mute_drums = 0

live_loop :main do
  int = 1
  use_random_seed [13,13,17,17,12,16,16,1].tick
  #use_random_seed [31,34].tick
  mute_drums = 0
  mute_drums = 0
  use_synth :supersaw #saw supersaw
  sc = scale(:C4, :minor_pentatonic)
  with_fx :reverb, amp: 0.6 do
    4.times do
      n = sc.choose
      use_synth :dsaw
      play [n, n+7], attack: 0.3, sustain: int, release: 0.2 #-12
      use_synth :saw if one_in 2
      #play [n-12, n+7-12], sustain: int, release: 0
      sleep int
    end
  end
end

cont = 0
live_loop :bass, sync: :main do
  stop
  stop if mute_drums == 1
  use_synth :bass_foundation
  sc = scale(:C2, :minor_pentatonic) #c3 c4 c2/2
  z = sc.choose
  z2 = sc.choose
  ns = [z,z2,z2]
  durs = [0.25]
  with_fx :reverb do
    durs.each do |d|
      play ns.choose, sustain: 0.2, release: 0
      sleep d
    end
  end
  cont += 1
end

live_loop :drums, sync: :main do
  stop
  stop if mute_drums == 1
  with_fx :reverb do
    sample :drum_splash_hard if one_in 16
    sample :drum_bass_hard
    sleep 0.5
    sample :drum_bass_soft
    sleep 0.25
    sample :drum_bass_soft
    sleep 0.25
  end
end

live_loop :effects, sync: :main do
  stop
  sample :bass_thick_c, rate: 2
  sleep 2
end

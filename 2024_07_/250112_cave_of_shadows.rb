use_bpm 120

live_loop :main do
  use_synth :supersaw #saw supersaw
  ns = [:c4, :d4, :e4, :g4]
  with_fx :reverb do
    ns.each do |n|
      use_synth :supersaw
      play [n, n+7], sustain: 4, release: 0 #-12
      use_synth :saw if one_in 2
      play [n-12, n+7-12], sustain: 4, release: 0
      sleep 4
    end
  end
end

live_loop :bass, sync: :main do
  use_synth :bass_foundation
  sc = scale(:C2, :minor_pentatonic)
  z = sc.choose
  z2 = sc.choose
  ns = [z,z2,z2]
  durs = [0.5,0.5,0.25,0.25,0.25,0.25,0.5,0.25,0.25,0.5,0.5]
  with_fx :reverb do
    durs.each do |d|
      play ns.choose, sustain: 0.2, release: 0
      sleep d
    end
  end
end

live_loop :drums, sync: :main do
  with_fx :reverb do
    sample :drum_bass_hard
    sleep 0.5
    sample :drum_bass_soft
    sleep 0.25
    sample :drum_bass_soft
    sleep 0.25
  end
end



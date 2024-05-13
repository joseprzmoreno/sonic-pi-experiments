use_bpm 120

live_loop :gb do
  with_fx :reverb do
    with_fx :panslicer do
      sample :bass_trance_c, start: 0.03,
        rate: [3,1,1.5,1].tick * 0.5, finish: 1, release: 1,
        amp: 2
      sleep 1
    end
  end
end

live_loop :m, sync: :gb do
  use_synth :saw
  use_synth_defaults amp: 1, release: 0.15
  use_random_seed [98,100,99,1070].tick(:rs)
  sc = scale([:C4, :G4].choose, :melodic_minor_asc).take(4).mirror
  sc = sc.shuffle if one_in(2)
  sc.each do |n|
    with_fx :reverb do
      play n
      sleep [0.25].tick(:durs)
    end
  end
end

live_loop :drums, sync: :gb do
  in_thread do
    sample :drum_cymbal_closed, amp: 0.6
    sleep 0.25
  end
  sample :bd_fat
  sleep 0.5
  sample :drum_bass_soft
  sleep 0.25
  sample :drum_bass_soft
  sleep 0.25
end
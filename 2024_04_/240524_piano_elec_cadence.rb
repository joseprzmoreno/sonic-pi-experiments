use_bpm 120

live_loop :r do
  sample :perc_bell, rate: [2,1,0.5,0.25].tick, amp: 0.6
  sleep 0.5
end

live_loop :pianos, sync: :r do
  use_synth :piano
  use_synth_defaults amp: 16, release: 1
  chords = [chord(:D4, :M), chord(:D4, :m),
            chord(:A3, :M), chord(:A3, :m),
            chord(:F4, :M7), chord(:F4, :m7),
            chord(:C4, :M), chord(:C4, :m)]
  chords.each do |ch|
    durs = [0.75,1.25,0.75,1.25]
    with_fx :reverb do
      with_fx :nrbpf, mix: 0.3, centre: 50 do
        n = play ch
        sleep durs.tick(:durs)
      end
    end
  end
end

live_loop :ambi2, sync: :r do
  use_synth :bass_foundation
  use_synth_defaults amp: 4, release: 0.25
  with_fx :reverb do
    play :C2
    sleep 0.55
    play :D2
    sleep 0.45
  end
end

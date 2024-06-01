use_bpm 120

live_loop :r do
  sample :perc_bell, rate: [2,1,0.5,0.25].tick, amp: 0.6
  sleep 0.5
end

live_loop :pianos, sync: :r do
  use_synth :pulse
  use_synth_defaults amp: 8, release: 0.2
  sc = scale(:D3, :minor_pentatonic)
  4.times do
    ch = sc.choose
    durs = [0.75,1.25,0.75,1.25]
    with_fx :panslicer do
      with_fx :echo do
        with_fx :echo do
          with_fx :reverb do
            with_fx :nrbpf, mix: 0.3, centre: 50 do
              2.times do
                n = play chord(ch, [:M, :m].tick(:qs))
                sleep durs.tick(:durs)
              end
            end
          end
        end
      end
    end
  end
end

live_loop :ambi2, sync: :r do
  use_synth :bass_foundation
  use_synth_defaults amp: 4, release: 1
  with_fx :reverb do
    play :C2
    sleep 0.55
    play :D2
    sleep 0.45
  end
end

live_loop :bass do
  use_synth :tech_saws
  with_fx :echo do
    play :C3, sustain: 0.1, release: 0.1
    sleep 0.5
    play :F3, sustain: 0.1, release: 0.1
    sleep 0.5
  end
end

live_loop :drums, sync: :bass do
  use_synth_defaults amp: 0.3
  in_thread do
    4.times do
      use_synth :sc808_maracas
      play [30, 40, 50, 60].tick(:freqs)
      sleep [0.7, 0.5, 0.3, 0.5].tick(:dursm)
    end
  end
  in_thread do
    2.times do
      sample :bass_woodsy_c, amp: [0, 0.1, 0.2, 0.4, 0.8].tick(:ba)
      sleep 0.5
    end
  end
  use_synth :sc808_snare
  play 20
  sleep 1
end

live_loop :piano, sync: :bass do
  use_synth :piano
  play chord(scale(:C4, :minor_pentatonic).shuffle.tick(:ch), :M)
  sleep [0.25, 0.75].tick(:durs)
end

live_loop :saw, sync: :bass do
  use_random_seed [12, 14, 16].tick(:rs)
  s = scale(:C5, :minor_pentatonic).shuffle
  durs = [4, 2, 1, 2, 4, 3]
  6.times do
    use_synth :saw
    with_fx :ping_pong do
      with_fx :panslicer do
        with_fx :flanger do
          n = s.tick(:nn)
          d = durs.tick(:dd)
          play [n, n+7], sustain: d * 0.25, release: 0
          sleep d * 0.25
        end
      end
    end
  end
end

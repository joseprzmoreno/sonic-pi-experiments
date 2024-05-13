use_bpm 90

live_loop :dr do
  path = '/home/jose/projects/sonic-pi-experiments/samples/TR808WAV/'
  bd = path + 'BD/BD5000.WAV'
  ch = path + 'CH/CH.WAV'
  in_thread do
    2.times do
      sample ch
      sleep 0.5
    end
  end
  sample bd, amp: 8
  sleep 1
end

live_loop :flutes, sync: :dr do
  use_synth :pulse
  with_fx :lpf, cutoff: 80 do
    play chord([:D3, :C3, :A3, :G3].tick(:chs), 'M'), sustain: 2
    sleep 2
  end
end

live_loop :pianos, sync: :dr do
  use_synth :piano
  sc = scale(:C5, :major)
  p = rrand_i(2,6)
  with_fx :gverb do
    2.times do
      3.times do
        play sc[p]
        sleep 0.01
        play sc[p] - 12
        sleep 0.01
        play sc[p] - 24
        sleep 0.23
        p = p + [0, -1].tick(:dds)
      end
      sleep 0.25
    end
  end
  sleep 2
end

live_loop :organs, sync: :dr do
  use_synth :dtri
  use_synth_defaults amp: 1, sustain: 0.15
  use_random_seed [1212,660,770,880].tick(:rss)
  durs = [0.5,0.5,0.5,0.5,0.25,0.25,0.25,0.25,1].shuffle
  ns = [:C5, :C5, :D5, :D5, :E5, :G5, :G5, :A5, :A5].shuffle
  ns.each do |n|
    with_fx :reverb do
      with_fx :ping_pong do
        with_fx :hpf, cutoff: 80 do
          play n
          play n - 12
          sleep durs.tick(:durs)
        end
      end
    end
  end
end

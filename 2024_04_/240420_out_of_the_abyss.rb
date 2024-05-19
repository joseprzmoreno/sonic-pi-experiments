use_bpm 120
silence = 0

live_loop :r do
  sample :bd_808, amp: 8
  sleep 1
end

live_loop :ambi, sync: :r do
  stop
  use_synth :dsaw
  use_synth_defaults amp: 0.3
  play chord([:D3, :G3].tick(:ns), 'M')
  sleep [1.5, 0.5].tick(:durs)
end

rs = 1400
live_loop :color, sync: :r do
  stop
  use_synth :chiplead
  use_synth_defaults amp: 1, sustain: 0.1, release: 0.2
  sc = scale(:D3, :minor_pentatonic, num_octaves: 2)
  use_random_seed [rs].tick  #chiplead/1/flanger rodeo/0.5/echo  #122 134 129 134(chiplead, echo)    (rodeo,flanger)99 100   6000 7000   1 2 3 4 sin drums 5 con drums 11,12 tb303
  8.times do
    with_fx :flanger do
      n = sc.choose
      play [n, n+7] if not one_in(6)
    end
    sleep 0.5
  end
  rs += 1
end

rs2 = 1500
live_loop :color2, sync: :r do
  stop
  stop if silence == 1
  use_synth :chiplead
  use_synth_defaults amp: 0.8, sustain: 0.1, release: 0.2
  sc = scale(:D3, :minor_pentatonic, num_octaves: 2)
  use_random_seed [rs2].tick  #(arr: 12, 13,   ab: 16, 17) (14 15/16 19) (1300 | 1400)
  8.times do
    with_fx :echo do
      with_fx :flanger do
        play sc.choose
        sleep [0.25,0.25,0.25,0.25,1,1,1].tick(:durs)
      end
    end
  end
  rs2 += 1
end

live_loop :b, sync: :r do
  stop
  use_synth :bass_highend
  use_synth_defaults release: 0.15, amp: 0.8
  sc = scale(:D3, :minor_pentatonic).take(4).shuffle
  with_fx :reverb do
    play chord(sc.tick(:chs), '5')
  end
  sleep [1,1,1,1,0.5,0.5,0.5,0.5].tick(:durs)
end

live_loop :drums, sync: :r do
  stop
  sample :drum_bass_soft, amp: 1
  sleep 0.5
  sample :drum_tom_lo_soft
  sleep 0.25
  sample :drum_snare_soft
  sleep 0.25
end

live_loop :violin, sync: :r do
  stop
  use_synth :pulse
  use_synth_defaults amp: 0.7
  sc = scale(:D4, :minor_pentatonic).shuffle
  with_fx :lpf, cutoff: 70 do
    play 74, sustain: 4
    sleep 4
    play 81, sustain: 4
    sleep 4
    sc.each do |n|
      play n, sustain: 1
      sleep 1
    end
  end
end

live_loop :clap, sync: :r do
  stop
  path = '/home/jose/projects/sonic-pi-experiments/samples/TR808WAV/CL/'
  sample path + 'CL.WAV', amp: 2
  sleep 4
end

fadeout = 0
vol = 1
set_volume! vol
live_loop :fadeout do
  stop if fadeout == 0
  100000.times do
    vol = vol * 0.99
    set_volume! vol
    sleep 0.05
  end
end
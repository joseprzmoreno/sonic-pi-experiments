use_bpm 120

pos = 1 # 8
live_loop :main do
  pat = [3, -5, 5] #change
  use_synth :blade
  use_synth_defaults release: 2
  s = scale(:C4, :minor_pentatonic, num_octaves: 1) #3
  with_fx :reverb do
    4.times do
      2.times do
        pos += pat[0]
        play s[pos]
        sleep 0.5
        pos += pat[1]
        play s[pos]
        sleep 0.5
      end
      pos += pat[2]
      sleep 0.5
    end
    sleep 0.5
  end
end

rs = 32
live_loop :ambi, sync: :main do
  stop
  use_synth :dark_ambience
  use_synth_defaults sustain: 1.2
  use_random_seed rs
  2.times do
    4.times do
      s = scale(:C6, :minor_pentatonic)
      play chord(s.choose, '6')
    end
  end
  rs += 1
  sleep 2
end

poss = [1, 6, 7]
live_loop :voice, sync: :main do
  stop
  s = scale(:C4, :minor_pentatonic, num_octaves: 2)
  use_synth :hollow
  use_synth_defaults sustain: 3
  with_fx :whammy do
    play s[poss.tick(:positions)]
    sleep [1,2,1].tick(:durs)
  end
  z = rrand_i(-2,2)
  poss = poss.map { |num| num + z }
end

live_loop :r, sync: :main do
  sample :bd_fat
  sleep 1
end

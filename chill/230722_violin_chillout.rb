load_synthdefs "/home/jose/projects/sonic_pi/sc/"

t= 0.25

live_loop :main do
  #stop
  use_random_seed 20
  s = scale(:C4, :minor_pentatonic).take(4).shuffle
  use_synth :violin
  n = s.tick
  4.times do
    2.times do
      play midinote: n
      play midinote: n + 4
      play midinote: n + 7
      sleep t
    end
  end
  sleep t
end

live_loop :sec, sync: :main do
  stop
  use_synth :violin
  s = scale(:C3, :minor_pentatonic, num_octaves: 2)
  p1 = [s[0], s[2], s[3]]
  d1 = [t*2, t, t]
  p2 = [s[0], s[4], s[8], s[6], s[2]]
  d2 = [t*2, t, t, t*2, t*2]
  p3 = [s[2], s[2], s[5], s[5], s[7], s[8], s[5], s[5]]
  d3 = [t * 0.5, t, t, t, t, t, t, t * 1.5]
  p4 = [s[0], s[1], s[7], s[4]]
  d4 = [t * 2, t * 2, t * 2, t * 2]
  p = p1
  d = d1
  for i in 0..p.length()-1 do
    play midinote: p[i]
    play midinote: p[i] + 12
    sleep d[1]
  end
end

live_loop :bass, sync: :main do
  stop
  use_synth :dsaw
  use_synth_defaults sustain: t * 4, amp: 0.5
  s = scale(:C3, :minor_pentatonic)
  with_fx :lpf, cutoff: 80 do
    with_fx :flanger do
      play chord(s.choose, 'M')
    end
  end
  sleep t * 4
end

count = 0
live_loop :r, sync: :main do
  stop
  path = "/home/jose/projects/sonic_pi/samples/TR808WAV/"
  bd = path + "BD/BD0025.WAV"
  cy = path + "CY/CY1000.WAV"
  clap = path + "CP/CP.WAV"
  cl = path + "CL/CL.WAV"
  sample bd if count % 2 == 0
  sample cy if count % 2 == 1
  sample clap, amp: rrand(0.1, 0.8)
  #sample cl if count % 8 == 1 or count % 8 == 3 or count % 8 == 6
  count += 1
  sleep t
end




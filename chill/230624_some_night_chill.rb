h = [1,3,4,5,7,8,10]
t = 0.25
flag_elec_blup = 0

live_loop :drums do
  count = 1
  12.times do
    if h.include?(count) then
      sample :drum_heavy_kick
    end
    sample :drum_cymbal_pedal, rate: 2
    if flag_elec_blup == 1 then
      sample :elec_blup, rate: rrand(1,3)
    end
    count += 1
    sleep t
  end
end

live_loop :main, sync: :drums do
  use_synth :beep
  s = scale(:C3, :major)
  use_random_seed [2406, 2407, 2408].tick
  durs = [t,t,t,t,t,t,t*2,t*2,t*2].shuffle
  ini = rrand_i(0,6)
  n = ini
  12.times do
    with_fx :whammy do
      play s[n]
      set :note, s[n]
    end
    z = [-2,2,1,1].choose
    n = s[n+z]
    sleep durs.tick
  end
end

live_loop :ambi, sync: :main do
  s = scale(:C4, :major)
  use_synth :dsaw
  use_synth_defaults sustain: t * 4, release: t * 0.25
  with_fx :reverb do
    with_fx :lpf, cutoff: 90 do
      play chord(get[:note], ['M', 'm7'].choose), amp: 0.7
    end
  end
  sleep t * 4
end

live_loop :voice, sync: :main do
  #stop
  audio = '/home/jose/projects/sonic_pi/audios/sentez.wav'
  audiogr = '/home/jose/projects/sonic_pi/audios/nioste.wav'
  with_fx :gverb do
    sample audio, rate: 1.1
  end
  sleep t * 36
  with_fx :gverb do
    sample audiogr, rate: 1
  end
  sleep t * 10000
end

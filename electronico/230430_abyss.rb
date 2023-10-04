t = 0.5

r1 = 0
r2 = 0
line1 = 0
line2 = 0
ambiance = 0
voice = 1

define :flag do |flag|
  if flag == 0 then
    stop
  end
end

live_loop :chunda do
  flag(r1)
  sample :drum_bass_hard
  sleep t
end

live_loop :chunda2, sync: :chunda do
  flag(r2)
  sample :drum_cymbal_soft, rate: 3, amp: 0.4
  sleep t * 0.25
end

live_loop :line1, sync: :chunda do
  flag(line1)
  use_synth :bass_highend
  s = scale(:c3, :egyptian)
  n = s.tick
  play [n, n+5], release: 0.2, pan: -0.5
  sleep [t, t * 0.5,  t * 0.5].tick
end

live_loop :line2, sync: :chunda do
  flag(line2)
  use_synth :pretty_bell
  s = scale(:c4, :egyptian).shuffle
  play s.take(3), release: 0.2, pan: 0.5
  sleep t * 0.5
end

live_loop :ambiance, sync: :chunda do
  flag(ambiance)
  s = scale(:c4, :egyptian).shuffle
  use_synth :winwood_lead
  with_fx :lpf, cutoff: 90 do
    with_fx :flanger, depth: 20 do
      play s.tick, release: t * 4, amp: 0.6
    end
  end
  sleep t * 4
end

live_loop :song, sync: :chunda do
  flag(voice)
  rate1 = 1.2
  if voice == 2 then
    rate1 = 0.8
  end
  rate2 = rate1 - 0.02
  path = "/home/jose/projects/sonic_pi/"
  sample path + "audios/pourquoi.wav", rate: rate1
  sample path + "audios/pourquoi.wav", rate: rate2
  
  sleep t * 4
  sample path + "audios/why.wav", rate: rate1
  sample path + "audios/why.wav", rate: rate2
  sleep t * 4
end
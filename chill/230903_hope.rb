t = 0.25

live_loop :bass do
  use_synth :subpulse
  use_synth_defaults release: 0.3
  ns = [:D3, :C3, :F3, :D3, :G3, :F3, :G3, :A3]
  if one_in(4) then
    ns = [:D3, :r, :D4, :r, :D3, :r, :D4, :r]
  end
  ns.each do |n|
    with_fx :reverb do
      play n
    end
    sleep t
  end
end

live_loop :r, sync: :bass do
  #stop
  sample :drum_cymbal_closed
  sleep t
  sample :drum_heavy_kick
  sleep t
end

live_loop :ambi, sync: :bass do
  #stop
  use_synth :hoover
  use_synth_defaults sustain: t * 8, release: 0, amp: 0.8
  chs = [:D3, :B2, :F3, :G3]
  play chord(chs.tick, :m7)
  sleep t * 8
end

live_loop :melody, sync: :bass do
  #stop
  use_synth :rodeo
  ref = [0, 100, 366, 2000, 5000].tick
  ns = [:D4, :r, :C4, :r, :A3, :D4, :C4, :r]
  if ref == 0 then
    ns = [:D4, :r, :C4, :r, :A3, :D4, :C4, :r]
  else
    use_random_seed ref
    ns = ns.shuffle
  end
  2.times do
    ns.each do |n|
      with_fx :octaver do
        play n, amp: 1.2
      end
      sleep t
    end
  end
end

live_loop :voice, sync: :bass do
  if one_in(6) then
    sent = '/home/jose/projects/sonic_pi/audios/there_might_be_some_hope_en.wav'
    if one_in(2) then
      sent = '/home/jose/projects/sonic_pi/audios/quiza_quede_algo_de_esperanza_es-US.wav'
    end
    with_fx :flanger do
      sample sent, amp: 2, rate: rrand(0.9, 1.1)
    end
  end
  sleep t * 8
end





































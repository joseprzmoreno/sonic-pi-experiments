use_bpm 120

#140 1400
live_loop :a do
  use_synth :tech_saws
  sc = scale(:D4, :minor_pentatonic)
  use_random_seed [140].tick(:rss)
  durs = [4,3,2,1].shuffle
  4.times do
    d = durs.tick(:durs)
    with_fx :nbpf, amp: 0.5 do
      play chord(sc.choose, [:M7, '6'].choose), sustain: d, pan: -1
    end
    sleep d
  end
end

live_loop :drs, sync: :a do
  tick
  amp = (Math.sin(look * Math::PI / 8) + 1) / 2
  use_synth_defaults amp: amp
  sample :bd_klub, amp: amp
  sleep 0.5
  
  sample :sn_generic, rate: 10, amp: amp
  sleep 0.5
end

live_loop :c, sync: :a do
  speed = 2
  use_synth_defaults amp: 0.4
  sc = scale(:D3, :major_pentatonic, num_octaves: 2)
  use_synth :hollow
  with_fx :flanger do
    with_fx :echo do
      play chord(sc.choose, '5'), sustain: speed, release: 0, pan: 1
      sleep speed
    end
  end
end


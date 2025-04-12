use_bpm 120

#140 5000 10
live_loop :a do
  use_synth :tech_saws
  sc = scale(:D4, :minor_pentatonic)
  use_random_seed [10].tick(:rss)
  durs = [4,3,2,1].shuffle
  4.times do
    d = durs.tick(:durs)
    play chord(sc.choose, [:M7, '6'].choose), sustain: d
    sleep d
  end
end

live_loop :drs, sync: :a do
  sample :bd_klub
  sleep 0.5
  sample :sn_generic, rate: 10
  sleep 0.5
end



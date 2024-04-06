use_bpm 120

live_loop :main_motif do
  use_synth :kalimba
  use_synth_defaults release: 0.4, sustain: 0.01
  pat = [2,2,1,2]
  pat = [3,1,3,4] if one_in(4)
  durs = [2,2,1,2]
  durs = [3,2,1,1] if one_in(4)
  sc = scale(:D4, :dorian)
  ini = rrand(0,5)
  with_fx :echo, phase: rrand(0.1,0.9) do
    with_fx :reverb do
      with_fx :hpf, cutoff: 110 do
        with_fx :nhpf, pre_amp: 0.9, cutoff: 100 do
          pat.each do |n|
            play sc[n + ini], amp: 0.2
            sleep durs.tick * 0.5 * 0.25
          end
        end
      end
    end
  end
end

live_loop :noise do
  #stop
  use_synth :noise
  3.times do
    play rrand_i(40,80), sustain: 4, release: 3, attack: 1,
      amp: rrand(0.3, 0.7), pan: rrand(-1,1)
  end
  sleep 4
end

live_loop :wind do
  #stop
  3.times do
    sample "/home/jose/projects/sonic-pi-experiments/samples/scary_wind.wav",
      rate: [1,0.75,1.25].choose, pan: rrand(-0.8,0.8)
  end
  sleep 2
end

set_volume! 1
vol = 1

live_loop :fadeout do
  stop
  set_volume! 1
  100000.times do
    vol = vol - 0.01
    set_volume! vol
    sleep 0.5
  end
end




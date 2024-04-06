use_bpm 120

live_loop :intro do
  sample :drum_bass_hard
  sleep 1
end


live_loop :base do
  with_fx :reverb do
    sample :ambi_drone
    sleep 2
    sample :ambi_drone, rate: 2
    sleep 2
  end
end

live_loop :ambi, sync: :base do
  use_synth :saw
  with_fx :flanger do
    play chord([:D4, :E4, :G4, :A4].tick, :M),
      sustain: 4, amp: 0.6
  end
  sleep 4
end

live_loop :melody, sync: :ambi do
  use_synth :dpulse
  use_synth_defaults release: 0.2
  ns = [:D5, :E5, :A5, :F5]
  n = ns.tick
  4.times do
    with_fx :reverb do
      with_fx :echo, phase: 0.75, max_phase: 6 do
        play n
      end
    end
    sleep [1.5,0.5].tick
  end
end

live_loop :bells, sync: :ambi do
  stop
  use_synth :pretty_bell
  use_random_seed [2,6].tick(:rs)
  sc = scale(:D4, :minor_pentatonic).shuffle.take(2)
  16.times do
    if not one_in(8) then
      play sc.tick(:ss), pan: rrand(-1,1)
    end
    sleep 0.5
  end
end




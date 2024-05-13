use_bpm 110

live_loop :base do
  sample :drum_bass_hard
  sleep 1
  sample :drum_bass_soft
  sleep 1
end

live_loop :cyms, sync: :base do
  sample :drum_cymbal_closed, amp: rrand(0.1,0.3)
  sleep 0.25
end

live_loop :splash, sync: :base do
  sample :drum_splash_hard, amp: 0.5
  sleep 16
end

live_loop :piano1, sync: :base do
  #stop
  use_synth :piano
  use_synth_defaults release: 0.6
  ns = scale(:C4, :minor_pentatonic).take(4)
  n = -2
  with_fx :reverb do
    with_fx :nbpf, mix: 0.2, amp: 1 do
      n = ns.tick
      4.times do
        play chord(n, 'M7')
        sleep 1
      end
    end
  end
end

live_loop :piano2, sync: :base do
  #stop
  use_synth :pretty_bell
  use_synth_defaults amp: 0.5
  ns = scale([:C2,:C3,:C4,:C5,:C6].tick,
             :minor_pentatonic).stretch(2)
  p = [-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10]
  with_fx :reverb do
    play_pattern_timed(ns, 0.25, pan: p.tick(:p) * 0.1)
  end
end

live_loop :melody, sync: :base do
  #stop
  use_synth :prophet
  use_synth_defaults release: 0.3
  16*4.times do
    with_fx :reverb do
      with_fx :nbpf, amp: 0.5 do
        play [:C5,:D5,:Fs5,:G5].choose, amp: 0.5 if not one_in(4)
      end
    end
    sleep [0.28,0.23].tick
    sleep 1 if one_in(4)
  end
end

live_loop :bass, sync: :main_motif do
  sample :bass_thick_c, rate: 1.3333, amp: 0.6
  sleep 2
  sample :bass_thick_c, rate: 0.6666, amp: 0.6
  sleep 2
end

live_loop :sticks, sync: :base do
  sample :bd_klub, rate: rrand_i(16,24), amp: 0.5
  sleep 0.25
end
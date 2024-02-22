use_bpm 110

live_loop :base do
  sample :bd_808, amp: 24
  sleep 1
  sample :sn_generic
  sleep 1
end

live_loop :bassline, sync: :base do
  stop
  sample :bass_thick_c, amp: 1, rate: 1
  sleep 1
end

live_loop :organ, sync: :base do
  use_synth :organ_tonewheel
  play chord([:C4, :D4, :A4, :D4].tick(:chs), 'm7'),
    sustain: 4, amp: 2 #6
  sleep 4
end

live_loop :bells, sync: :base do
  use_random_seed 112
  use_synth :pretty_bell
  ns = [:C4, :C4, :D4, :D4, :D4, :F4, :A4, :A4].shuffle
  8.times do
    n = ns.choose
    in_thread do
      sleep 0.5
      with_fx :echo, phase: 1.25 do #4.5
        play n, pan: rrand(-1,1)
      end
      play n, amp: 0.2
    end
    with_fx :echo, phase: 1.25 do #4.5
      play n, pan: rrand(-1,1), amp: 0.2
    end
    sleep 1
  end
end

set_volume! 1
vol = 1
live_loop :fadeout, sync: :base do
  stop
  10000.times do
    puts vol
    vol = vol - 0.01
    sleep 0.1
    set_volume! vol
  end
end

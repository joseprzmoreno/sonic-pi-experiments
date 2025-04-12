use_bpm 120

live_loop :ds do
  sample :drum_bass_hard
  sleep 1
end

live_loop :bs, sync: :ds do
  use_synth :beep
  notes = [:G3, :A3, :D3, :A3]
  n = notes.tick
  with_fx :reverb do
    4.times do
      play n, amp: [0.5, 0.25].tick(:aas), release: 0.1
      sleep 0.25
    end
  end
end

live_loop :acc, sync: :ds do
  use_synth :tech_saws
  ns = [:C2, :D2, :F2, :G2]
  n = ns.tick
  4.times do
    with_fx :reverb do
      with_fx :nbpf, amp: 0.5, centre: 4 do
        play chord(n + 12, '5')
      end
    end
    sleep 1
  end
end

count = 0
live_loop :sq, sync: :ds do
  use_synth :blade
  sc = scale(:D4, :minor_pentatonic)
  use_synth_defaults sustain: 0.15, release: 0
  use_random_seed 180
  count = count + 1
  16.times do
    n = sc.choose
    second = n + 7
    second = n  if count % 2 == 1
    if not one_in 12 then
      with_fx :echo, phase: 0.18 do
        play n, amp: rrand(0.8, 1.6)
        sleep 0.5
        play second, amp: rrand(0.4, 0.8)
        sleep 0.5
      end
    else
      sleep 1
    end
  end
end

fadeout = 0
vol = 2
set_volume! vol
live_loop :fadeout do
  stop if fadeout == 0
  100000.times do
    vol = vol - 0.001
    set_volume! vol
    sleep 0.01
  end
end



use_bpm 120
c = 0
d = 0
mel = 1
drums = 1
ornams = 1

live_loop :base do
  sleep 1
end

live_loop :cymbal, sync: :base do
  stop if drums == 0
  sample :drum_cymbal_closed, amp: [1,2,1,2].tick
  sleep 0.5
end

live_loop :drums, sync: :base do
  stop if drums == 0
  sample :bd_808, amp: 8
  sleep 1
  sample :sn_generic, amp: 0.5
  sleep 1
end

live_loop :bg, sync: :base do
  stop if mel == 0
  c += 1
  use_synth :saw
  use_synth_defaults attack: 0.1, release: 0.4
  with_fx :reverb, mix: 0.4, room: 0.6 do
    if c > 1 and c % 4 == 1 then
      play 64
      sleep 1.5
      play 66
      sleep 0.5
      play 64
      sleep 1
      play 67
      sleep 0.25
      play 66
      sleep 0.25
      play 64
      sleep 0.5
    else
      play 57
      sleep 1.5
      play 60
      sleep 0.5
      play 62
      sleep 1
      play 60
      sleep 1
    end
  end
end

live_loop :bg_bass, sync: :base do
  stop if mel == 0
  d += 1
  use_synth :sine
  if d > 1 and d % 4 == 1 then
    play 64 - 12
    sleep 1.5
    play 66 - 12
    sleep 0.5
    play 64 - 12
    sleep 1
    play 67 - 12
    sleep 0.25
    play 66 - 12
    sleep 0.25
    play 64 - 12
    sleep 0.5
  else
    play 57 - 12
    sleep 1.5
    play 60 - 12
    sleep 0.5
    play 62 - 12
    sleep 1
    play 60 - 12
    sleep 1
  end
end


live_loop :ambi, sync: :bg do
  stop if ornams == 0
  use_synth :dsaw
  with_fx :flanger, delay: 0.5 do
    with_fx :hpf, cutoff: 100 do
      play [69,72,77,74].tick - 12, release: 4, amp: 1
    end
    sleep 4
  end
end

live_loop :bells, sync: :bg do
  stop if ornams == 0
  use_synth :pretty_bell
  with_fx :echo, phase: [0.25, 0.5, 0.75].tick(:phs) do
    n = scale(:D4, :minor_pentatonic).choose
    with_fx :lpf, cutoff: 80 do
      play [n, n + 7], amp: 0.7, pan: rrand(-1,1)
    end
  end
  sleep 0.5
end













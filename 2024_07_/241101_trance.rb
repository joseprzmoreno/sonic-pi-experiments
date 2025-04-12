amp = 2

live_loop :trance do
  use_synth :tech_saws
  with_fx :nbpf, amp: 0.3 do
    with_fx :echo do
      play chord(:C4, 'M7')
      sleep 4
      play chord(:D4, '6')
      sleep 4
    end
  end
end

live_loop :drs, sync: :drums do
  sample :drum_bass_hard, amp: 4
  sleep 1
  sample :drum_bass_soft, amp: 4
  sleep 1
end

live_loop :drums, sync: :trance do
  sample :tabla_ghe1
  sleep 0.25
  sample :tabla_ghe3
  sample :drum_cymbal_closed
  sleep 0.25
  sample :bd_fat, amp: 2
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.25
end

live_loop :perc, sync: :drums do
  #stop
  sample :tabla_ghe3, rate: 1.2, amp: amp * 1.1, finish: 0.01
  amp = 2 if amp >= 3
  sleep 0.125
end

live_loop :saws, sync: :trance do
  #stop
  use_synth :saw
  use_synth_defaults sustain: 0.1, release: 0, pan: -1
  with_fx :echo do
    with_fx :echo do
      with_fx :echo do
        play chord(:G2, '6')
        sleep 2
        play chord(:A2, 'm7')
        sleep 2
      end
    end
  end
end

live_loop :bells, sync: :trance do
  #stop
  use_synth :pretty_bell
  use_synth_defaults sustain: 0.1, release: 0, amp: 0.3, pan: 1
  with_fx :echo do
    with_fx :echo do
      with_fx :echo do
        play chord(:G5, '5')
        sleep 2
        play chord(:A5, '5')
        sleep 2
        play chord(:D5, '5')
        sleep 1
        play chord(:C5, '5')
        sleep 1
        play chord(:A4, '5')
        sleep 1
        play chord(:B4, '5')
        sleep 1
      end
    end
  end
end

live_loop :hum, sync: :trance do
  sample :ambi_haunted_hum, amp: 1
  sleep 4
end

live_loop :sweet, sync: :trance do
  #stop
  use_synth :beep
  use_synth_defaults sustain: 0.1, release: 0, amp: 0.6
  with_fx :reverb do
    play_pattern_timed (scale(:C5, :major) + :r).shuffle, [0.25, 0.75]
  end
end

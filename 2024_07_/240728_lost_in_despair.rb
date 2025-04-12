use_bpm 120
amp_drums = 1

live_loop :main do
  sleep 4
end

live_loop :drums, sync: :main do
  sample :drum_bass_hard, amp: amp_drums
  sleep 0.5
  sample :drum_cymbal_pedal, amp: amp_drums
  sleep 0.5
end

define :play_mt do |n, q|
  play chord(n, q)
end

live_loop :main_theme, sync: :main do
  inc = 0
  inc = 12 if one_in (10)
  use_synth :saw
  use_synth_defaults release: 1.7
  with_fx :reverb do
    with_fx :panslicer do
      play_mt :B4 + inc, 'm'
      sleep 2
      play_mt :Cs5 + inc, 'sus2'
      sleep 2
      play_mt :B4 + inc, 'm'
      sleep 4
    end
  end
end

define :main_bass_pat do
  play :B2
  sleep 0.5
  play :B2
  sleep 0.5
  play :D3
  sleep 0.5
  play :E3
  sleep 0.5
end

define :alt_bass_pat do
  play :Fs3
  sleep 0.5
  play :E3
  sleep 0.5
  play :D3
  sleep 0.5
  play :E3
  sleep 0.5
end

define :alt_bass_pat_2 do
  amp_drums = 0
  2.times do
    play :B2, amp: 1.4
    sleep 0.5
    play :Fs3, amp: 1.4
    sleep 0.5
    play :B2, amp: 1.4
    sleep 0.5
    play :A3, amp: 1.4
    sleep 0.5
  end
  amp_drums = 1
end

live_loop :ambi, sync: :main do
  stop
  use_synth :organ_tonewheel
  with_fx :flanger, phase: 2, phase_offset: 0.5 do
    in_thread do
      4.times do
        next
        sc = scale(:A4, :major).shuffle
        with_fx :echo do
          play_pattern_timed chord(sc[0], '5') + chord(sc[1], '5') + chord(sc[2], '5') + chord(sc[3], '5'),
            0.5, sustain: 0.15
        end
      end
    end
    play [:D5, :Fs5], sustain: 2, release: 2
    sleep 4
    sleep 2
    play [:Gs5, :B5], sustain: 1, release: 1
    sleep 2
    play [:B4, :D5], sustain: 2, release: 2
    sleep 4
    sleep 4
  end
end

live_loop :bass, sync: :main do
  stop
  use_synth :bass_foundation
  use_synth_defaults release: 0.3, amp: 0.7
  with_fx :echo, phase: 0.15 do
    main_bass_pat
    alt_bass_pat if one_in(5)
    alt_bass_pat_2 if one_in(10)
  end
end

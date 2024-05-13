use_bpm 120

live_loop :r do
  sample :bd_fat, amp: 4
  sleep 0.5
  sample :drum_bass_soft, amp: 2
  sleep 0.5
  sample :elec_snare, amp: 0.3
  sleep 0.5
  sample :drum_bass_soft, amp: 2
  sleep 0.5
end

live_loop :ambi1, sync: :r do
  use_synth :beep
  use_synth_defaults sustain: 0.1, release: 0.5,
    amp: 0.6, pan: rrand(-1, 1)
  n = [:F4, :G4].tick
  in_thread do
    sleep 3.25
    play n
    sleep 0.25
    play n
    sleep 0.5
  end
  play :E4
  sleep 0.75
  play :E4
  sleep 3.25
end

live_loop :bass1, sync: :r do
  #stop
  sample :bass_trance_c, start: 0.02,
    finish: 0.10, amp: 0.7, rate: [0.5,1,2].choose
  sleep 0.5
end

live_loop :piano_ambi, sync: :r do
  use_synth :piano
  sc = scale(:A4, :minor_pentatonic)
  n = sc.choose
  amp = 0.8
  4.times do
    with_fx :reverb do
      play n, amp: amp, pan: rrand(-1, 1)
      sleep 1
      amp = amp * 0.5
    end
  end
end

live_loop :piano_melody, sync: :r do
  #stop
  use_synth :piano
  sc = scale(:C4, :major).pick(4)
  amp = 0.25
  run = 1
  run = 0.5 if one_in(2)
  run = 0.25 if one_in(2)
  4.times do
    with_fx :echo do
      with_fx :reverb do
        sleep 0.05 * run
        play sc.tick, amp: amp, pan: rrand(-1, 1)
        sleep 0.95 * run
        amp = amp * 1.5
      end
    end
  end
end

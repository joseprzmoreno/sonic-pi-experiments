use_bpm 120
rs = 1000

live_loop :piano1 do
  stop
  sleep 0.25
  use_synth :pretty_bell
  use_synth_defaults amp: 0.25, release: 0.15
  use_random_seed rs
  sc = scale(:D4, :dorian)
  sc = (sc + sc + sc).shuffle.take(8)
  durs = [1, 0.5, 1, 1.5]
  with_fx :reverb do
    play_pattern_timed sc, durs
  end
end

n = 0
live_loop :piano_chords, sync: :piano1 do
  use_synth :organ_tonewheel
  sc = scale(:D3, :dorian)
  use_random_seed rs
  sc = sc.shuffle
  in_thread do
    if n > 4 then
      with_fx :flanger do
        play [sc[0] + 24,
              sc[1] + 24,
        sc[2] + 24],
          sustain: 4, release: 16, amp: 0.3
      end
    end
  end
  4.times do
    play sc.tick(:ns)
    sleep [0.25, 0.5].tick(:ds)
  end
  n = n + 1
end

live_loop :drums, sync: :piano1 do
  sample :drum_snare_soft
  sleep 0.5
  s = :drum_cymbal_closed
  if one_in(20) then
    s= :drum_cymbal_open
  end
  sample s
  sleep 0.5
end


live_loop :ambi, sync: :piano1 do
  use_synth :prophet
  use_random_seed rs
  sc = scale(:D3, :dorian)
  ini = sc.choose
  use_synth_defaults release: 0.15
  with_fx :echo do
    play [ini,
          ini + 7,
          ini,
          ini + 7,
          ini,
          ini + 7,
          ini + 24,
          ini + 29].tick(:bnns)
  end
  sleep 0.25
end

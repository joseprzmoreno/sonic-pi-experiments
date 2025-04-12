use_bpm 120
ca1 = 0.2
ca2 = 0.3
ca1orig = 0.2
ca2orig = 0.3

live_loop :drums do
  if ca1 < ca1orig then
    ca1 = ca1 * 1.1
  end
  
  if ca2 < ca2orig then
    ca2 = ca2 * 1.1
  end
  
  if one_in(32)
    sleep 8
    ca1 = 0.05
    ca2 = 0.08
  end
  sample :drum_bass_hard
  sample :elec_cymbal, amp: ca1
  sleep 0.5
  sample :elec_cymbal, amp: ca2
  sleep 0.5
end

live_loop :bass, sync: :drums do
  use_synth :beep
  use_synth_defaults amp: 4, release: 0.1
  with_fx :echo, decay: 4 do
    play [:D3, :G3].tick(:b), pan: rrand(-1, 1)
    sleep 4
  end
end

live_loop :flanger, sync: :drums do
  use_synth :organ_tonewheel
  use_synth_defaults amp: 2, release: 1
  rs = 16
  rs = [12, 20, 28].tick(:rss) if one_in(4)
  use_random_seed rs
  2.times do
    4.times do
      sc = scale(:D4, :minor_pentatonic)
      with_fx :flanger, depth: 1 do
        amp = 2
        amp = 0 if one_in(32)
        play chord(sc.choose, 'M7'), amp: amp
      end
      sleep 1
    end
  end
end

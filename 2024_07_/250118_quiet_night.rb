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

live_loop :organ_solo, sync: :ds do
  stop
  use_synth :dark_ambience #organ_tonewheel + amp 0.8~1.2
  ns = [:C5, :D5, :D5, :E5, :G5, :A5, :A5].shuffle
  ns2 = [:Bb4, :Bb4, :F4, :F4, :F4, :A4, :D5].shuffle
  use_random_seed 16 #7000
  durs = [1, 1.5, 1.5, 1.5, 0.5, 0,5, 1.5].shuffle
  durs.each do |d|
    with_fx :flanger do
      play chord(ns.tick(:ns), ['5'].tick(:qs)),
        amp: rrand(2.8,3.2), sustain: d#, release: 0.5 if not one_in 4
      sleep d
    end
  end
end




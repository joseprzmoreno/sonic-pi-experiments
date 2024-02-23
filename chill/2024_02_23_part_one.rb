use_bpm 130

count = 0
live_loop :r do
  sample :bd_fat, amp: 8
  #sample :glitch_perc3, amp: 1.2 if count % 4 == 0
  sleep 1
  count += 1
end

live_loop :bass, sync: :r do
  stop
  use_synth :bass_foundation
  use_synth_defaults release: 0.6
  notes = [:A2, :A2, :A2, :r, :E2, :E2, :E2,
           :A2, :A2, :A2, :r, :E2, :E2, :E2,
           :A2, :A2, :A2, :r, :E2, :E2, :E2,
           :D2, :D2, :D2, :r, :r, :r, :r]
  durs = [0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5]
  notes.each do |n|
    with_fx :distortion, distort: rrand(0.4, 0.7) do
      play n
    end
    sleep durs.tick(:durs)
  end
end

live_loop :organ, sync: :bass do
  stop
  use_synth :organ_tonewheel
  with_fx :hpf, cutoff: 80 do
    with_fx :ping_pong do
      with_fx :ixi_techno, phase: 0.25 , depth: 19  do
        play chord([:A5, :E5, :A5, :E5, :A5, :E5, :D5, :G5].tick(:chords),
                   'M'), sustain: 2
        sleep 2
      end
    end
  end
end

live_loop :cyms, sync: :r do
  stop
  sample :drum_cymbal_closed, amp: [0.5, 0.25].tick(:cyms)
  sleep [0.55, 0.45].tick(:sl)
end

live_loop :blade, sync: :r do
  #stop
  use_synth :dtri #dtri dpulse tech_saws
  use_random_seed [12,12,12,16].tick(:rs)   #12 16 7000 9000
  use_synth_defaults release: 0.2 #0.3
  ns = [:C5, :C5, :F5, :C6, :C6, :C6, :C5, :r, :r, :r].shuffle
  ns = scale(:C5, :minor_pentatonic, num_octaves: 2) +
    scale(:C5, :minor_pentatonic, num_octaves: 2).shuffle
  durs = [0.5, 0.5, 1, 1, 0.5, 0.5, 1, 1, 1, 1].shuffle
  ns.each do |n|
    with_fx :reverb, pre_amp: 2, mix: 0.7, room: 0.6 do
      if one_in(10000) then #10000 4 2
        next
      end
      #with_fx :echo, phase: [0.25, 0.5, 0.75, 1].tick(:echo) do
      play n - 3 - 12, amp: 2, pan: rrand(-1,1) #-0
      #end
    end
    sleep durs.tick(:ds) * 0.5
  end
end

live_loop :ambi, sync: :r do
  stop
  sample :ambi_glass_hum, amp: 2
  sleep 1
end


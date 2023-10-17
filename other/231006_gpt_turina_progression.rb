use_bpm 90
use_synth :piano
use_random_seed 118

chords = [
  chord(:e, :major),
  chord(:a, :minor),
  chord(:e, :major),
  chord(:b, :minor),
  chord(:e, '5'),
  chord(:a, 'm+5'),
  chord(:e, '5'),
  chord(:b, 'm+5'),
]

melody = [:e5, :f5, :g5, :e5, :d5, :c5, :b4, :a4,
          :b4, :d5, :b4, :e5, :c5, :f5, :d5, :a4]

live_loop :chords do
  with_synth :piano do
    4.times do
      chords.each do |chord_notes|
        play_chord chord_notes
        sleep 1
      end
    end
  end
end

live_loop :melody do
  #stop
  with_synth :piano do
    count = 0
    melody.each do |note|
      if one_in(2) and count == 11 then
        play :e5
        sleep 0.125
        play :a5
        sleep 0.125
        play :g5
        sleep 0.125
        play :f5
        sleep 0.125
      else
        play note
        sleep 0.5
      end
      count += 1
    end
  end
end






























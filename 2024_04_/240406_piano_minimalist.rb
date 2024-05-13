use_bpm 100

live_loop :mel do
  use_synth :piano
  sc = scale(:D4, :dorian).take(4).mirror.shuffle
  sc.each do |n|
    play_pattern_timed chord(n, '6'), 0.5
    play_pattern_timed chord(n, 'm7'), 0.25
  end
end



n = 0
prev = 0

live_loop :main do
  sample :drum_bass_hard, amp: [0.8, 0.4].tick
  sleep 0.5
end

live_loop :sawloop, sync: :main do
  use_synth :supersaw
  s = scale(:G3, :dorian).take(4)
  play chord(s.tick, '5')
  sleep 1
end

live_loop :melody, sync: :main do
  crease = 0
  instrument = :blade
  use_synth_defaults attack:0.05, sustain: 0.25, release: 0
  s = scale(:D4, :dorian).shuffle
  sequence = generate_sequence(10, rrand_i(1,5))
  if one_in(3) then
    instrument = :pluck
    crease = -12
  end
  for x in 0..sequence.length()-1
    use_synth instrument
    with_fx :gverb do
    play s[x] + crease, amp: 0.5
  end
  sleep 0.25
end
sleep 0.5
end

def generate_sequence(length, seed)
  sequence = []
  current_row = Array.new(length, 0)
  current_row[length / 2] = seed
  
  length.times do
    sequence << current_row.map { |cell| cell * 5 }
    next_row = Array.new(length, 0)
    
    (1..length-2).each do |i|
      left = current_row[i - 1]
      center = current_row[i]
      right = current_row[i + 1]
      next_row[i] = (left == 1 && center == 0 && right == 0) ||
        (left == 0 && center == 1 && right == 1) ||
        (left == 0 && center == 1 && right == 0) ? 1 : 0
    end
    
    current_row = next_row
  end
  
  sequence
end

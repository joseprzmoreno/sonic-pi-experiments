t = 0.25

live_loop :organ do
  use_synth :organ_tonewheel
  s = scale(:D4, :dorian).take(4).shuffle
  use_random_seed 12
  with_fx :flanger do
    s.each do |n|
      play chord(n, :M)
      sleep t * 4
    end
  end
end

live_loop :r, sync: :organ do
  stop
  sample :loop_3d_printer, amp: 0.5
  sleep t * 16
end

live_loop :bells, sync: :organ do
  stop
  use_random_seed [12,14,16,18].tick
  use_synth :pretty_bell
  use_synth_defaults amp: 0.5, pan: rrand(-0.5,0.5)
  s = scale(:D4, :dorian)
  play s.choose
  sleep t
  play chord(s.choose, 'm7b5')
  sleep t * 2
  play s.choose
  sleep t
end

live_loop :bells2, sync: :organ do
  stop
  s = scale(:D4, :dorian)
  use_random_seed [12,14,16,18].tick
  use_synth :pretty_bell
  4.times do
    with_fx :echo do
      play chord(s.choose, ['M','m7b5','M', 'm'].tick)
      sleep t * 2
    end
  end
end

live_loop :ambi, sync: :organ do
  stop
  use_synth :dsaw
  use_synth_defaults sustain: t * 6, amp: 0.2
  use_random_seed [12,14].tick
  s = scale(:D3, :dorian).shuffle.take(2)
  s.each do |n|
    with_fx :flanger, depth: 20 do
      play n
      sleep t * 4
      play n + 12, amp: 0.1
      sleep t * 4
    end
  end
end

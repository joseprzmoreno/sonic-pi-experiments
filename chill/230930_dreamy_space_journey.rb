t = 0.25
effect = 1

c = 0
live_loop :ambiance do
  use_synth :dsaw
  use_synth_defaults sustain: t * 4
  s = scale(:D3, :dorian)
  with_fx :hpf, cutoff: 80 do
    with_fx :flanger, depth: 20 do
      s.each do |n|
        if c % 2 == 0 then
          play chord(n, :m7)
          sleep t * 4
        end
        c += 1
      end
    end
  end
end

live_loop :melody, sync: :ambiance do
  use_synth :prophet
  use_synth_defaults attack: t * 0.5, sustain: t * 3, release: t * 4
  s = scale(:C4, :dorian).reverse
  use_random_seed 230701
  ds = [t, t, t, t, t*2, t*2, t*4].shuffle
  4.times do
    with_fx :lpf, cutoff: 90 do
      play s.choose
    end
    sleep ds.tick * 2
  end
end

live_loop :line, sync: :ambiance do
  use_synth :zawa
  ini = [:C4, :F4].choose
  ns = scale(ini, :dorian).reverse.take(4)
  time = t
  ns.each do |n|
    with_fx :echo, phase: t * 0.25 do
      play n, release: 0.2, amp: 0.5
    end
    sleep time
    time = time * 0.7
  end
  sleep t * 4
end

live_loop :effects do
  if effect == 1 then
    sample :loop_weirdo, amp: 3
    effect = 0
  end
  sleep t
end


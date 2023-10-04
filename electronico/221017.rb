sleep1 = 1  #1, 0.5
sleep2 = 0.5 #0.5, 0.125
echo = 0

live_loop :bd do
  sleep sleep1
  sample :bd_tek, cutoff: 120, amp: 1.8
end

live_loop :tom, sync: :bd do
  sleep sleep1 * 0.5 + sleep2
  if dice(12) > 1
    sample :drum_tom_hi_soft, amp: 1, release: 0.1
  end
end

live_loop :bass, sync: :bd do
  use_synth :bass_foundation
  if echo == 1
    with_fx :echo, phase: 0.125 do
      play scale(:d2, :egyptian).shuffle.tick, attack: 0.01, release: 0.2, amp: 0.9
    end
  else
    play scale(:d2, :egyptian).shuffle.tick, attack: 0.01, release: 0.2, amp: 0 #1.5
  end
  sleep 0.25
end

live_loop :melo1, sync: :bd do
  use_synth [:pretty_bell, :prophet, :dsaw].choose
  3.times do
    stop
    sleep 1
    s = scale(:d5, :egyptian).shuffle
    with_fx :wobble do
      play ([s[0], s[1], s[2]])
    end
  end
  sleep 1
end

use_bpm 120

live_loop :bg do
  use_synth :dsaw
  use_synth_defaults sustain: 4, release: 2
  ns = [:D3, :F3, :G3, :Bb3]
  play chord(ns.tick, :m7)
  sleep 4
end

live_loop :drums, sync: :bg do
  if one_in(4) then
    8.times do
      sample :bd_ada, amp: rrand(0.6,1.2)
      sleep 0.25
    end
  else
    sample :bd_klub
    sleep 1
    sample :bd_haus
    sleep 1
  end
end

live_loop :ambi, sync: :bg do
  use_synth :pluck
  ns = [:r, :f4, :eb4, :f4]
  ns = [:r, :c5, :bb4, :c5] if one_in(4)
  amp = 2
  4.times do
    ns.each do |n|
      play n, amp: amp
      sleep 0.25
    end
    amp -= 0.4
  end
  sleep 4
end

live_loop :organ, sync: :bg do  use_synth :organ_tonewheel
  with_fx :flanger do
    play chord([:C6, :D6, :G5, :Bb5].tick, 'm7'), sustain: 4
  end
  sleep 4
end

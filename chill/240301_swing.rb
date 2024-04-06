#https://www.youtube.com/watch?v=eb8KO-ZA7l8
use_bpm 120

live_loop :r do
  #stop
  sample :bd_ada, amp: 8
  sleep 1
end

live_loop :b, sync: :r do
  #stop
  sample :bass_drop_c
  sleep 1
  sample :bass_drop_c, rate: 0.33
  sleep 1
  sample :bass_drop_c, rate: 0.66
  sleep 2
end

amp = ring(2,3,4,5,6,7,8,9,10,9,8,7,6,5,4,3)
live_loop :c, sync: :r do
  #stop
  use_synth :tech_saws
  use_synth_defaults sustain: 1
  notes = [:C3, :D3, :F3, :A3]
  for note in notes do
    with_fx :nrhpf, cutoff: rrand_i(10,100) do
    play chord(note, '5'), amp: amp.tick
  end
  sleep 1
end
end

live_loop :d, sync: :r do
  #stop
  use_synth :supersaw
  use_synth_defaults sustain: 0.2, release: 0
  sc = scale(:C4, :major_pentatonic).shuffle
  8.times do
    with_fx :reverb do
      play sc.tick, amp: 3, pan: rrand(-1, 1)
      sleep 0.25
    end
  end
end





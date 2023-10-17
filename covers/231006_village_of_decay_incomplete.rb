use_bpm 90

live_loop :r do
  use_synth :noise
  use_synth_defaults release: 0.2, amp: 0.7
  3.times do
    play 60
    sleep 1
  end
  play 60
  sleep 0.25
  play 60
  sleep 0.75
end

live_loop :bg1, sync: :r do
  use_synth :zawa
  use_synth_defaults release: 1.3, note_slide: 1, amp: 0.6
  ns = [:a2, :e3, :d3, :e3, :g3, :fs3, :g3, :fs3, :e3, :d3]
  ds = [0.5, 0.25, 0.25, 0.5, 0.5, 0.25, 0.25, 0.5, 0.5, 0.5]
  play ns.tick(:notes) + 12
  sleep ds.tick(:durs)
end

live_loop :bass, sync: :r do
  use_synth :winwood_lead
  play [:a2, :e2, :a2, :e3].tick
  sleep 1
end

live_loop :song, sync: :r do
  stop
  use_synth :prophet
  use_synth_defaults amp:2
  ns1 = [:a4, :e5, :e5, :d5, :c5, :d5, :r]
  ds1 = [1]
  play ns1.tick(:notes)
  sleep ds1.tick(:durs)
end


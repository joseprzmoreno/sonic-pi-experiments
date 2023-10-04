use_bpm 120
rs = 49000

drums = 1
ambi = 1
bass = 1
arp = 1

count = 0

define :flag do |flag|
  stop if flag == 0
end

live_loop :r do
  flag drums
  sample :bd_808, amp: 16
  sleep 1
end

live_loop :ambi do
  flag ambi
  use_synth :hoover
  use_synth_defaults release: 3
  use_random_seed rs
  s = scale(:d4, :dorian)
  4.times do
    n = s.choose
    set :note, n
    play chord(n, '6'), amp: 1.5
    sleep 2
  end
  rs += 1 if count % 4 == 0
end

live_loop :bass, sync: :ambi do
  flag bass
  use_synth :pulse
  use_synth_defaults release: 2
  n = get[:note]
  with_fx :whammy, grainsize: 0.15, mix: 0.9 do
    2.times do
      play n - 24, pan: rrand(-1, 1), amp: 0.9
      play n - 12.2, pan: rrand(-1, 1), amp: 0.9
      sleep 1
    end
  end
end

live_loop :arp, sync: :ambi do
  flag arp
  use_synth :bass_foundation
  n = get[:note]
  play chord(n, :M7) + 12, amp: 6 if not one_in(6)
  sleep 1
end


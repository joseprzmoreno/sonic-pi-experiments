use_bpm 120

n = 0
live_loop :chunda do
  sample :bd_808, amp: 16
  sample :drum_splash_soft, rate: 1.2 if n % 4 == 0
  sleep 1
  n += 1
end

live_loop :saws, sync: :chunda do
  use_random_seed 18
  use_synth_defaults amp: 2
  use_synth :tech_saws
  sc = scale(:D4, :minor_pentatonic)
  ns = sc.shuffle.take(2)
  play chord(ns[0], 'M'), pan: -1
  sleep 1
  play chord(ns[1], 'M'), pan: 1
  sleep 3
end

live_loop :magic, sync: :chunda do
  use_synth :prophet
  use_synth_defaults release: 0.2, amp: 2
  degrees1 = [4,2,1,2,4,0,1,0]
  degrees2 = [4,3,2,1,4,2,3,1]
  degrees3 = [1,1,1,1,-1,4,3,2]
  degrees = [degrees1, degrees2, degrees3, degrees3].tick(:ds)
  sc = scale(:D3, :minor_pentatonic)
  degrees.each do |d|
    with_fx :reverb do
      play sc[d] if d != -1
      sleep 0.5
    end
  end
end

live_loop :drums, sync: :chunda do
  sample :drum_cymbal_pedal, amp: [0.5, 0.25].tick(:p)
  sleep 0.25
end

live_loop :magic2, sync: :chunda do
  use_synth :pretty_bell
  use_synth_defaults amp: 2, release: 0.125 * 0.75
  sc = scale(:D3, :minor_pentatonic, num_octaves: 4)
  4.times do
    with_fx :reverb do
      n = sc.choose
      play n, amp: rrand(0.8,1.2) if n < 84
      play chord(n, '5'), release: 4, amp: 0.6 if one_in(64)
      sleep 0.125
    end
  end
end

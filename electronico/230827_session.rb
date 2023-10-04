t = 0.25

live_loop :ambi do
  use_synth :dsaw
  play chord([:D2, :D2, :D2, :D2, :G2, :G2, :G2, :G2].tick, :m7), sustain: t * 6, amp: 0.25
  sleep t * 4
end

live_loop :piano, sync: :ambi do
  stop
  use_synth :piano
  use_synth_defaults pan: -0.4, release: 0.3
  n = [:C3, :D3, :G3, :A3].tick
  with_fx :gverb, dry: 2, mix: 0.8, pre_amp: 0.5 do
    play chord(n, :m7), amp: 2
    sleep t * 2
    play chord(n, :m7), amp: 1.4
    sleep t * 2
  end
end

live_loop :r, sync: :piano do
  sample :drum_cymbal_closed, amp: [1, 0.5].tick
  sleep t * 0.5
end

live_loop :dr, sync: :r do
  sleep t
  sample :drum_heavy_kick
  sleep t * 2
  sample :drum_heavy_kick
  sleep t
end

live_loop :mel, sync: :r do
  use_synth :blade
  use_synth_defaults release: 0.15, attack: 0.05
  use_random_seed 1000 #1000 1002 1011
  ns_1 = [:C6, :r, :Bb5, :G5, :F5, :D5, :r, :r]
  ns_2 = [:C5, :r, :F5, :r, :G5, :r, :D5, :r]
  ns_3 = [:Bb4, :D5, :F5, :E5, :r, :C5, :r, :Bb5]
  ns_4 = [:C5, :r, :G5, :r, :D5, :r, :r, :Bb5]
  ns_5 = (scale(:F4, :major) + [:r]).shuffle
  ns_6 = [:G4, :r, :F5, :r, :G4, :r, :F5, :r]
  ns_7 = [:D5, :r, :A4, :r, :G4, :r, :F5, :r]
  ns_8 = [:r]
  ns = ns_8
  ds = [t]
  ns.each do |n|
    with_fx :gverb do
      with_fx :wobble do
        if n == :E5 then
          in_thread do
            use_synth :pretty_bell
            play chord(:F5, :M7), release: t * 6, amp: 0.4
          end
        end
        use_synth :blade
        play n, amp: 0.6, pan: 0.4
      end
    end
    sleep ds.tick
  end
end


v = 2.4
12.times do
  set_mixer_control! amp: v
  v = v - 0.2
  sleep t * 2
end







































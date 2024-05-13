use_bpm 120

live_loop :bells do
  use_synth_defaults amp: 1
  play chord(:C4, 'M')
  sleep 0.5
  play chord(:D4, 'm')
  sleep 1.5
end

live_loop :mel, sync: :bells do
  stop
  add = 0
  use_synth_defaults amp: 0.5
  use_synth :pretty_bell
  ns = [:C4, :D4, :F4, :D4].shuffle
  with_fx :ping_pong do
    with_fx :reverb do
      play ns[0] + add
      sleep 0.5
      play ns[1] + add
      sleep 0.5
      play ns[2] + add
      sleep 0.5
      play ns[3] + add
      sleep [0.5, 2.5, 2.5, 2.5].choose
    end
  end
end

live_loop :ambi2, sync: :bells do
  stop
  use_synth :tech_saws
  use_synth_defaults amp: 1
  sc = scale(:C4, :minor_pentatonic)
  play chord(sc.choose, 'M'), sustain: 0.25,
    pan: rrand(-1, 1)
  sleep 1
end

live_loop :ambi, sync: :bells do
  stop
  use_synth :dark_ambience
  use_synth_defaults amp: 2
  with_fx :lpf, cutoff: 70 do
    play :C3, sustain: 6
    sleep 6
    play :G3, sustain: 2
    sleep 2
    play :A3, sustain: 2
    sleep 2
    play :E3, sustain: 2
    sleep 2
    play :D3, sustain: 4
    sleep 4
  end
end

live_loop :drums, sync: :bells do
  stop
  sample :drum_bass_soft
  sleep 0.5
  sample :drum_cymbal_pedal
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.25
  sleep 0.25
end

live_loop :solo, sync: :bells do
  stop
  use_random_seed 164
  use_synth :piano
  sc = scale(:D4, :minor_pentatonic, num_octaves: 2)
  with_fx :reverb do
    64.times do
      n = sc.choose
      if not one_in(2) then
        if one_in(4) then
          in_thread do
            play chord(n, '5'), release: 1, amp: 1.25
          end
        end
        play n, amp: [0.75, 1.25].choose
      end
      sleep 0.25
    end
  end
end

use_bpm 120
path = '/home/jose/projects/sonic-pi-experiments/samples/'
conga = path + 'conga2.wav'

live_loop :main do
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_soft
  sleep 1
end

live_loop :hats, sync: :main do
  sample :drum_cymbal_closed, amp: [0.75, 0.5].tick
  sleep 0.5
end

live_loop :conga, sync: :main do
  if one_in(7) then
    sample conga
  end
  sleep 0.25
end

live_loop :bass, sync: :main do
  stop
  sc = scale(:C2, :egyptian)
  use_synth :bass_foundation
  use_synth_defaults sustain: 3.90, release: 0.05, amp: 0.5  #3.90 0.90 0.20
  use_random_seed 13 #13 16 20 (ab: 4/1/0.25)
  4.times do
    with_fx :flanger do
      play sc.choose
    end
    sleep 4
  end
end

live_loop :gr, sync: :main do
  stop
  use_synth :tech_saws
  use_synth_defaults amp: 4, release: 0.3
  use_random_seed [12,16].tick  #12/16 (16)24/26 (16)7000/8000 (24)10000,12000
  sc = scale(:C4, :egyptian)
  8.times do
    if not one_in(6) then
      with_fx :echo do
        with_fx :reverb do
          play chord(sc.choose, 'M')
        end
      end
    end
    sleep 0.5
  end
end

live_loop :orns, sync: :main do
  stop
  use_synth :prophet
  play [72, 76]
  sleep 1
  play [77, 81]
  sleep 3
end

live_loop :bells, sync: :main do
  stop
  use_synth :pretty_bell #pretty_bell saw chiplead
  sc = scale(:C4, :egyptian, num_octaves: 2)
  play [sc.tick, sc.tick, sc.tick], amp: 1
  sleep 0.25 #4
end

fadeout = 0
amp = 1
live_loop :fadeout, sync: :main do
  set_volume! amp
  stop if fadeout == 0
  100000.times do
    set_volume! amp
    amp = amp * 0.99
    sleep 0.1
  end
end





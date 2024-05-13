use_bpm 120
drums = 1

live_loop :bass do
  use_synth :pluck
  use_synth_defaults sustain: 0.25,
    release: 0.25, amp: 4
  use_random_seed [16,16,16,16,12,12,12,12].tick(:rss)
  #use_random_seed [1019].tick
  sc = scale(:D3, :dorian)
  4.times do
    with_fx :reverb do
      with_fx :nlpf do
        play chord(sc.choose, '6')
        sleep [0.75, 1.25].tick(:chs)
      end
    end
  end
end

live_loop :bass2 do
  #stop
  sample :bass_trance_c, rate: [1.25,1.875].tick(:bl),
    amp: 0.4
  sleep 1
end

live_loop :drum, sync: :bass do
  sample :drum_heavy_kick if drums == 1
  sleep 1
end

live_loop :d, sync: :bass do
  sample :elec_cymbal, rate: 1.75,
    amp: [0.5, 0.25].tick(:amps), pan: [-1,1].tick(:pans) if drums == 1
  sleep 0.5
end

live_loop :voice, sync: :bass do
  #stop
  factor = 1
  base = '/home/jose/projects/sonic-pi-experiments/audios/'
  spa = base + 'todo_puede_ocurrir.wav'
  eng = base + 'everything_goes.wav'
  sample eng, rate: 1 * factor, pan: rrand(-1,1)
  sample eng, rate: 0.98 * factor, pan: rrand(-1,1)
  sample eng, rate: 1.02 * factor, pan: rrand(-1,1)
  sleep 4
  sample spa, rate: 1 * factor, pan: rrand(-1,1)
  sample spa, rate: 0.98 * factor, pan: rrand(-1,1)
  sample spa, rate: 1.02 * factor, pan: rrand(-1,1)
  sleep 12
end

live_loop :reson, sync: :bass do
  use_synth :hollow
  use_synth_defaults amp: 4
  play :D6
  sleep 1
  play :D6
  sleep 3
end


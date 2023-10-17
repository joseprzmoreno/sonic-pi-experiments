use_bpm 120

drums = 0
drums2 = 0
harmonics = 0
blup_chime = 0
waves = 0

define :flag do |flag|
  stop if flag == 0
end

live_loop :r do
  flag drums
  sample :drum_bass_hard
  sleep 1
  sample :elec_blip2
  sleep 1
end

live_loop :r2 do
  flag drums2
  with_fx :reverb do
    rand = rrand(0.5, 2.5)
    sample :elec_bell, rate: rand
    sample :elec_bell, rate: rand * 0.66
  end
  sleep 0.5
end

live_loop :noise, sync: :r do
  flag harmonics
  rate = [0.1, 0.3, 0.2, 0.4, 0.8, 0.6, 0.5, 0.7]
  rt = rate.tick
  s = :guit_harmonics
  sample s, pan: rrand(-1,1), rate: rt, amp: 1.5
  sleep 0.5
end

live_loop :blups, sync: :r do
  flag blup_chime
  pat = [0,1,0,1,0,1,0,1,
         1,1,1,1,0,1,0,1,
         1,0,1,0,0,0,1,0,
         1,1,1,0,0,1,0,1]
  pat.each do |p|
    if p == 1 then
      sample [:elec_blup, :elec_chime].choose
    end
    sleep 0.5
  end
end

rs = 1200
live_loop :waves, sync: :r do
  freqs = [rrand_i(200,300), rrand_i(400,500), rrand_i(600,700), rrand_i(900,1000)]
  play_freqs freqs
  freqs2 = freqs.map { |freq| freq + (freq * 1.5) }
  play_freqs freqs2
  freqs3= freqs.map { |freq| freq + (freq * 0.7) }
  play_freqs freqs3
  freqs4 = freqs.map { |freq| freq + (freq * 1.2) }
  play_freqs freqs4
  rs += 1
end

define :play_freqs do |freqs|
  flag waves
  use_synth :dsaw
  use_synth_defaults sustain: 8
  with_fx :gverb, damp: 0.5, dry: 0.9, amp: 0.7 do
    with_fx :panslicer, amp_max: 0.99, amp_min: 0.01 do
      with_fx :flanger do
        freqs.each do |f|
          play hz_to_midi(f), amp: 0.25
        end
      end
    end
  end
  sleep 8
end


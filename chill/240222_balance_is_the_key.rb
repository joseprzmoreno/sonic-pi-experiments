use_bpm 144
ns1 = [:C4, :Fs4, :D4, :Gs4]
ns2 = [:Ab5, :C5, :E5, :Fs5]
ns3 = [:Eb5, :A4, :C4, :Gs3]

live_loop :r do
  sample :bd_fat, amp: 8
  sleep 1
end

live_loop :ambi, sync: :r do
  use_synth :tech_saws
  q = 'M'
  ns = [ns1, ns2, ns3].choose
  use_synth_defaults release: 0, attack: 0, release: 0
  chords = [
    chord(ns[0], q),
    chord(ns[1], q),
    chord(ns[2], q),
    chord(ns[3], q)
  ]
  chords.each do |ch|
    play ch, amp: rrand(2,4), sustain: rrand(0.6,1) if one_in(3)
    sleep 0.5
  end
end

live_loop :bass do
  sample :bass_hit_c
  sleep 0.5
end

live_loop :piano, sync: :r do
  use_synth :tri
  use_random_seed [200,3000,5000,6000].tick(:rs)
  use_synth_defaults amp: 3, release: 0.3
  sc = scale(:Gs3, :minor_pentatonic).shuffle.take(2)
  4.times do
    with_fx :reverb do
      with_fx :echo, phase: 0.5, max_phase: 3 do
        play sc[0]
        sleep 2
        with_fx :echo, phase: [1,0.5,0.75,0.25].tick(:ec) do
          play sc[1], pan: rrand(-1,1)
        end
        sleep 2
      end
    end
  end
end

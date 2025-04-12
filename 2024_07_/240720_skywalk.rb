use_bpm 140
main = :D4 #D4 Bb4 G4 D4

live_loop :drums do
  sample :drum_snare_hard, amp: 0.7
  sleep 0.5
  sample :drum_cymbal_pedal, amp: 0.7
  sleep 0.5
  sample :drum_bass_soft, amp: 0.7
  sleep 0.5
  sample :drum_cymbal_pedal, amp: 0.7
  sleep 0.5
end

live_loop :pluck, sync: :drums do
  stop
  use_synth :pluck
  use_random_seed [2,4,7,8].tick(:rss)
  sc = scale(main, :minor_pentatonic).shuffle.take(4)
  4.times do
    4.times do
      with_fx :reverb do
        with_fx :echo, phase: 1 do
          play sc.tick, amp: [1,2,3].choose
          sleep 1
        end
      end
    end
  end
  sleep 8
end

i = 0
live_loop :saws, sync: :drums do
  stop
  use_synth :tech_saws
  sc = scale(main, :minor_pentatonic, num_octaves: 2).take(10)
  with_fx :lpf, cutoff: 110 do
    play [sc[i], sc[i+2], sc[i+4], sc+[i+6]], sustain: 2
  end
  i = i + 1
  sleep 2
end


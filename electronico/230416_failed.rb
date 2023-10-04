live_loop :perc do
  sample :drum_bass_hard, rate: 1.2, amp: 0.5
  sleep 0.25
  sample :drum_cymbal_pedal, rate: 0.8, amp: 0.5
  sleep 0.25
end

bg2_flag = 1
melody_flag = 1
r_pattern = [0.2,0.2,0.2] #222 842 242 141 181 222

define :flag do |fv|
  if fv == 0 then
    stop
  end
end

live_loop :bg, sync: :perc do
  use_synth :square
  with_fx :flanger do
    with_fx :lpf, cutoff: 80 do
      play :G3, release: 0.75, amp: 0.8
      sleep 1
      play :F3, release: 0.75, amp: 0.6
      sleep 1
      play :G3, release: 0.75, amp: 0.7
      sleep 2
    end
  end
end

live_loop :bg2, sync: :bg do
  flag(bg2_flag)
  use_synth :hoover
  sleep 0.01
  play :C3, release: 1.5, amp: 0.8
  sleep 1
  play :D3, release: 1.5, amp: 0.6
  sleep 1
  play :G3, release: 1.5, amp: 0.7
  sleep 2
end

live_loop :melody, sync: :perc do
  flag(melody_flag)
  use_synth :prophet
  sc = scale(:C4, :major, num_octaves: 2)
  notes = sc.shuffle.take(8)
  notes = notes + notes
  z = rrand_i(1,8)
  if z == 4 then
    with_fx :reverb do
      16.times do
        play notes.tick, release: r_pattern.tick,
          amp: rrand(0.6,1)
        sleep [0.125, 0.25, 0.5].tick
      end
    end
  else
    sleep 0.25
  end
end

live_loop :voice do
  if one_in(6) then
    sample :ambi_drone, rate: 1.5
  end
  sleep 1
end







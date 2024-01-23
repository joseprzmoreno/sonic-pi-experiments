t = 0.25

live_loop :ambi do
  use_synth :hoover
  use_synth_defaults sustain: t, release: t * 3
  ns = [:D4, :G4, :F4, :C5]
  ns.each do |n|
    use_synth :hoover
    play chord(n, ['6'].tick(:notes)), amp: 1  # + 4
    if one_in(1) then
      with_fx :echo do
        use_synth :pretty_bell
        play n + 7.3, amp: 0.8 # + 4
      end
    end
    sleep t * 4
  end
end

live_loop :r, sync: :ambi do
  #stop
  4.times do
    sample :drum_cymbal_closed
    sleep t
    sample :drum_bass_hard
    sleep t
  end
end

rs = 49000
count = 0
live_loop :bass, sync: :ambi do
  use_synth :chiplead
  #stop
  if count % 2 == 0 then
    rs = rs + 1
  end
  use_random_seed rs #12 19
  pattern = [3,:r,5,:r,4,:r,6,:r,3,:r,5,:r,7,:r,11,:r].shuffle
  if one_in(6) then
    pattern = [3,:r,5,:r,4,:r,6,:r,3,:r,5,:r,7,:r,6,:r,
               3,:r,5,:r,4,:r,6,:r,3,:r,5,:r,7,:r,11,:r]
    count += 1
  end
  scl = scale(:C4, :major, num_octaves: 2)
  pattern.each do |pos|
    if pos != :r then
      play scl[pos], amp: 0.8 #  + 4
      play scl[pos+12.2], amp: 0.8
    end
    sleep t
  end
  count += 1
end

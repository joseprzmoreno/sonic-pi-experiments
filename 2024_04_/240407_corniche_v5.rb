t = 0.25

live_loop :ambi do
  use_synth :hoover
  use_synth_defaults sustain: t, release: t * 3
  ns = [:D4, :G4, :F4, :G4]
  ns.each do |n|
    use_synth :hoover
    play chord(n, '5'), amp: 1.2  # + 4
    if one_in([0,0,0,0,1,1,1,1].tick(:bells)) then
      with_fx :echo do
        use_synth :pretty_bell
        play n + 7, amp: 0.8  # + 4
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

rs = 100000
live_loop :bass, sync: :ambi do
  use_random_seed rs #12 19
  pattern = [3,:r,5,:r,4,:r,6,:r,3,:r,5,:r,7,:r,6,:r].shuffle
  pattern = [3,:r,5,:r,4,:r,6,:r,3,:r,5,:r,7,:r,6,:r] if one_in(16)
  use_synth :blade
  scl = scale(:C3, :major)
  pattern.each do |pos|
    if pos != :r then
      play scl[pos], amp: 4  #  + 4
    end
    sleep t
  end
  rs += 1
end

fadeout = 0
vol = 1
set_volume! 1
live_loop :fadeout, sync: :r do
  stop if fadeout == 0
  100000.times do
    vol = vol * 0.99
    set_volume! vol
  end
  sleep 0.1
end



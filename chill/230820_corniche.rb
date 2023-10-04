t = 0.25

live_loop :ambi do
  use_synth :hoover
  use_synth_defaults sustain: t, release: t * 3
  ns = [:D4, :G4, :F4, :G4]
  ns.each do |n|
    use_synth :hoover
    play chord(n, :M7), amp: 0.8  # + 4
    if one_in(2) then
      with_fx :echo do
        use_synth :pretty_bell
        play n + 7, amp: 0.4   # + 4
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

live_loop :bass, sync: :ambi do
  #stop
  use_random_seed 12 #12 19
  pattern = [3,:r,5,:r,4,:r,6,:r,3,:r,5,:r,7,:r,6,:r] #.shuffle`
  use_synth :blade
  scl = scale(:C3, :major)
  pattern.each do |pos|
    if pos != :r then
      play scl[pos]  #  + 4
    end
    sleep t
  end
end





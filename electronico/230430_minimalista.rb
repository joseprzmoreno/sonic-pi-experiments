
t = 0.125
sc = scale(:C3, :minor_pentatonic, num_octaves: 2)
sc2 = sc.shuffle.take(3)
live_loop :melody do
  if one_in(2) then
    sc2 = sc.shuffle.take(4)
  end
  if one_in(4) then
    use_synth :hoover
    play sc2 + 24, release: 2, amp: rrand(0.1,0.3)
  end
  sleep t
end
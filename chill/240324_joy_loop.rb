use_bpm 140
sc = scale(:C4, :diatonic)

live_loop :base do
  sample :drum_bass_hard, amp: 0.5
  sleep 1
  sample :bd_fat, amp: 2
  sleep 1
end

live_loop :piano_rep, sync: :base do
  use_random_seed 55 #59
  use_synth :piano
  nums = [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6]
  v1 = nums.shuffle.take(4)
  durs = [0.75, 1.25, 1.5, 0.5]
  qs = ['M', '6', 'M', '6']
  ns = [sc[v1[0]], sc[v1[1]], sc[v1[2]], sc[v1[3]]]
  use_synth_defaults amp: 1.2, release: 0.6, sustain: 0.1
  ns.each do |n|
    with_fx :reverb do
      in_thread do
        next
        use_synth :pluck
        play_pattern_timed chord(n, qs.tick(:qs2)), 0.5
      end
      use_synth :piano
      play chord(n, qs.tick(:qs)), amp: [1,1,1,1].tick(:as)
    end
    sleep durs.tick(:durs)
  end
end





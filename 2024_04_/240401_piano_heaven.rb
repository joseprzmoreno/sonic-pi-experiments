live_loop :ambi do
  ts = [1,2,1,4]
  t = ts.tick(:durs)
  use_synth :dsaw
  ns = [:D3, :E3, :F3, :A3]
  ns.each do |n|
    play chord(n, ['M', 'm'].tick(:qs)), sustain: t
    sleep t
  end
end

live_loop :epic, sync: :ambi do
  do_play = 12
  do_not_play = 16 - do_play
  use_synth :piano
  use_synth_defaults amp: 1, release: 0.75
  sc = scale(:D4, :minor_pentatonic)
  use_random_seed [22, 25, 27, 32].tick(:rss)
  pat = []
  do_play.times do
    pat << 1
  end
  do_not_play.times do
    pat << 0
  end
  pat = pat.shuffle
  
  pat.each do |p|
    with_fx :nhpf do
      play sc.choose if p == 1
    end
    sleep 0.25
  end
end

amp = 1
live_loop :voices, sync: :ambi do
  amp = amp * 0.9
  amp = 1 if amp < 0.3
  4.times do
    with_fx :reverb do
      sample :ambi_choir, rate: 1.25, pan: -1, amp: amp
      sample :ambi_choir, rate: 1.25 * 0.5, pan: 1, amp: amp
      sleep 0.25
    end
  end
end


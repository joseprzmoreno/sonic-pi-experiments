use_bpm 110

live_loop :br do
  sample :bd_ada, amp: 8
  sleep 1
end

live_loop :bl, sync: :br do
  use_synth :piano
  use_synth_defaults amp: 4
  play :D3
  sleep 0.75
  play :A2
  sleep 0.75
  play :G2
  sleep 2
  play :A2
  sleep 0.75
  play :F2
  sleep 0.75
  play :D2
  sleep 2
end

live_loop :organ, sync: :br do
  #stop
  use_synth :organ_tonewheel
  use_synth_defaults amp: 2, sustain: 3
  with_fx :flanger do
    chs = [:D5,:D5,:D5,:F5,:F5,:G5]
    play chord(chs.tick(:chs), :M)
    sleep 3
  end
end

live_loop :sq, sync: :br do
  #stop
  use_synth :square
  use_synth_defaults release: 0.2
  if not one_in(4) then
    4.times do
      ns = [:eb4, :d4, :c4, :bb3]
      f = [2,4,9].choose
      sl = [0.25, 0.25, 0.75].choose
      ns.each do |n|
        with_fx :nbpf, centre: 1000, amp: 1,
        pre_amp: 2 do
          #with_fx :echo do
          play n + f, pan: rrand(-1,1)
          #end
          sleep sl
        end
      end
    end
  end
  sleep 1
end

























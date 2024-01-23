use_bpm 70
rs = 12
ornams = 0

live_loop :drums do
  if ornams == 1 then
    in_thread do
      4.times do
        sample :elec_beep, start: 0.20, finish: 0.50,
          amp: rrand(0.8,1.3)
        sleep 0.125
      end
    end
  end
  sample :bd_zome, amp: 1
  sleep 0.25
  sample :bd_ada, amp: 8
  sleep 0.25
end

live_loop :mel, sync: :drums do
  use_random_seed rs
  use_synth :pluck
  sc = scale(:D4, :dorian, num_octaves: 2)
  n = 7
  16.times do
    with_fx :reverb, amp: 3 do
      play chord(sc[n], 'M7'), release: 0.2, amp: 4 if not one_in(8)
    end
    sleep 0.25
    z = rrand_i(-2,2)
    n = n + z
  end
end

live_loop :ambi, sync: :drums do
  use_synth :prophet
  use_random_seed rs
  sc = scale(:D3, :dorian)
  4.times do
    with_fx :reverb do
      with_fx :panslicer do
        with_fx :ixi_techno, cutoff_max: 90, cutoff_min: 80 do
          n = sc.choose
          set :n, n
          play n, sustain: 1
        end
      end
    end
    sleep 1
  end
end


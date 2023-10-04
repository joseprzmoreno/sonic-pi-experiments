t = 0.3

live_loop :rhythm do
  sleep t * 0.5
  sample :drum_bass_soft, rate: 0.8
  sleep t * 2
  sample :drum_heavy_kick
  sleep t * 1.5
end

live_loop :bass, sync: :rhythm do
  use_synth :bass_foundation
  play [:E1, :E2].tick
  sleep t
end

live_loop :lead, sync: :rhythm do
  stop
  use_synth :pretty_bell
  use_synth_defaults release: 0.2
  s = scale(:E4, :dugah)
  use_random_seed [10,11,12,13].tick
  durs = [t * 0.5, t, t, t * 0.5, t,
          t * 0.5, t, t, t * 0.5, t]
  for d in 0..durs.length()-1 do
    n = s.choose
    if d == 0 then
      use_synth :hoover
      with_fx :flanger do
        play [n - 12, n - 5], amp: 0,
          attack: t * 0.25, sustain: t * 8, release: 0.4
      end
      sleep t * 0.25
    end
    use_synth :pretty_bell
    with_fx :gverb, amp: rrand(0.2,0.8) do
    play n
  end
  sleep durs[d]
end
end

#quitar stop
#amp 0 a 0.2

#hoover
#winwood_lead
#dsaw

#ferahnak
#12,13
#volver atrás
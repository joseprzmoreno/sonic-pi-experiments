use_bpm 120

define :main_motif do
  use_synth :hollow
  use_synth_defaults release: 0.3
  use_random_seed [129,12,129,156].tick
  sc = scale(:D4, :melodic_minor_asc, num_octaves: 2)
  4.times do
    with_fx :reverb do
      play sc.pick(4), amp: 4 if not one_in(16)
      sleep 0.5
    end
  end
end

live_loop :main do
  main_motif
end

live_loop :bass do
  use_synth :kalimba
  play_pattern_timed chord(:D4, :m7) + chord(:G4, :M7).shuffle, [1,0.5], amp: 8
end



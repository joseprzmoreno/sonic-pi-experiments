use_bpm 120

define :main_motif do |random_seeds|
  use_synth :hollow
  use_synth_defaults release: 0.3
  4.times do
    use_random_seed random_seeds.tick
    sc = scale(:D4, :melodic_minor_asc, num_octaves: 2)
    4.times do
      with_fx :reverb do
        play sc.pick(4), amp: 4 if not one_in(16)
        sleep 0.5
      end
    end
  end
end

live_loop :main do
  main_motif [129,12,129,156]
  main_motif [10,40,10,50]
  main_motif [1,3,1,7]
  main_motif [129,3,129,7]
end

live_loop :bass do
  use_synth :kalimba
  play_pattern_timed chord(:D4, :m7) + chord(:G4, :M7).shuffle, [1,0.5], amp: 8
end



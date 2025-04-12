use_bpm 120
set_volume! 2

live_loop :drums do
  with_fx :reverb do
    #sample :drum_bass_hard, amp: 1.5
    use_synth :sc808_claves
    play 30
    sleep 1
  end
end

live_loop :tech, sync: :drums do
  use_synth :tech_saws
  #with_fx :nhpf, amp: 0.1 do
  play chord(:D4, :major)
  sleep 2
  play chord(:A4, '6')
  sleep 1
  play chord(:F4, '5')
  sleep 1
  #end
end

live_loop :claps, sync: :drums do
  stop
  with_fx :reverb do
    use_synth :sc808_clap
    play 60
    sleep [1,2,1].tick
  end
end

live_loop :melody, sync: :drums do
  stop
  use_synth :rhodey
  #with_fx :reverb do
    use_synth_defaults amp: 0.3, release: 0.1
    play_pattern_timed scale(:D4, :minor_pentatonic)
    .stretch([2,1].tick(:b)), 0.25
  #end
end

fadeout = 0
live_loop :fadeout do
  stop if fadeout == 0
  vol = 2
  100000.times do
    set_volume! vol
    vol = vol * 0.99
    sleep 0.1
  end
end


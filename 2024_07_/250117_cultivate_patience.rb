use_bpm 120

live_loop :ts do
  use_synth :tech_saws
  play chord(:C4, 'M')
  sleep 1
  play chord(:D4, '6')
  sleep 2
  play chord(:G4, 'm')
  sleep 0.5
end

live_loop :ds, sync: :ts do
  sample :drum_bass_hard
  sleep 1
end

live_loop :bs, sync: :ts do
  use_synth :beep
  notes = [:G3, :A3, :D3]
  n = notes.tick
  with_fx :reverb do
    4.times do
      play n, release: 0.2
      sleep 0.5
    end
  end
end

live_loop :piano, sync: :ts do
  build_four_melody
end

define :build_four_melody do
  use_synth :piano
  use_random_seed [17,13,12,18].tick(:rs)
  #use_random_seed [100,103,106,109].tick(:rs)
  sc = scale(:D3, :minor_pentatonic)
  with_fx :echo do
    with_fx :reverb do
      durs = [0.5,1.5,1,1].shuffle
      #durs = [0.5,1.5,0.5,0.5,0.5].shuffle
      4.times do
        z = [1,2,3].choose
        play sc.choose if z < 3
        play chord(sc.choose, 'M'), amp: 2 if z == 3
        sleep durs.tick(:ds)
      end
    end
  end
end


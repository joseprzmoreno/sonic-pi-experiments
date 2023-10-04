t = 0.25
set :master_volume, 1
set :end_mode, 0

live_loop :bg do
  amp = 1
  if get[:end_mode] == 1 then
    set :master_volume, get[:master_volume] - 0.1
    amp = get[:master_volume]
  end
  use_synth_defaults release: 0.2, amp: amp
  use_synth :prophet
  4.times do
    play chord(:D4, :m7), pan: [-0.5, 0.5].tick
    sleep t
  end
  4.times do
    play chord(:G4, '6'), pan: [-0.5, 0.5].tick
    sleep t
  end
  if one_in(4) then
    4.times do
      play chord(:A4, :m7), pan: [-0.5, 0.5].tick
      sleep t
    end
    4.times do
      play chord(:C5, '6'), pan: [-0.5, 0.5].tick
      sleep t
    end
  end
end

live_loop :main, sync: :bg do
  amp = 1
  instrument = :blade
  ns = [:A4, :D5, :A5, :G5, :F5, :E5, :D5]
  if one_in(3) then
    amp = 1.4
    instrument = :pluck
    ns = ns.shuffle
  end
  if get[:end_mode] == 1 then
    amp = get[:master_volume]
  end
  use_synth_defaults release: 0.2, amp: amp
  use_synth instrument
  durs = [t, t, t, t*2, t, t, t]
  for i in 0..ns.length()-1
    play ns[i]
    sleep durs[i]
  end
end





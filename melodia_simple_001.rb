set :bt, 0.25

define :rhythm1 do |vol|
  if vol == -1
    amp = rand(0.4) + 0.4
  else
    amp = vol
  end
  amp = rand(0.2) + 0.4
  use_synth :prophet
  play :C4, amp: amp, pan: -0.2
  sleep get[:bt]
  play :D4, amp: amp, pan: -0.2
  sleep get[:bt]
  play :F4, amp: amp, pan: -0.2
  sleep get[:bt]
  play :G4, amp: amp, pan: -0.2
  sleep get[:bt]
end

define :lead1 do
  use_synth :dsaw
  play chord(choose([:C3, :D3, :A3]), :m7), attack: 0.2,
    release: get[:bt] * 4 - 0.2, amp: 0.8, pan: 0.2
  sleep get[:bt] * 4
end

define :chunk1 do
  in_thread do
    16.times do
      rhythm1(-1)
    end
  end
  sleep get[:bt] * 4 * 4
  12.times do
    lead1
  end
  vol = 0.4
  4.times do
    rhythm1(vol)
    vol = vol - 0.1
    print vol
  end
end

chunk1


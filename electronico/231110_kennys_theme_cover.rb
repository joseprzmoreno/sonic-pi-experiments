use_bpm 110

live_loop :main do
  sleep 1
end

live_loop :base, sync: :main do
  if one_in(10) then
    sample :drum_splash_hard
    sleep 2
    next
  end
  in_thread do
    4.times do
      cym_2
    end
  end
  sample :elec_snare, amp: 0.5
  sleep 1
  sample :bd_ada
  sleep 1
end

define :cym_1 do
  sample :drum_cymbal_closed, amp: 0.5
  sleep 0.5
end

define :cym_2 do
  2.times do
    sample :drum_cymbal_closed, amp: 0.4
    sleep 0.25
  end
end

live_loop :melody, sync: :main do
  ins = :prophet
  melody_1 ins
  melody_1 ins
  melody_2 ins
  melody_2 ins
  melody_3 ins
end

define :melody_1 do |ins|
  with_fx :reverb do
    use_synth ins
    use_synth_defaults pan: 0.2
    play chord(:Fs4, '5')
    sleep 0.75
    play chord(:Fs4, '5')
    sleep 0.75
    play chord(:E5, '6')
    sleep 1
    play chord(:E5, '6')
    sleep 0.75
    play chord(:Eb5, :m7)
    sleep 0.75
  end
end

define :melody_2 do |ins|
  with_fx :reverb do
    use_synth ins
    use_synth_defaults pan: 0.2, release: 2
    play chord(:Fs4, '5')
    sleep 1.5
    play chord(:E5, '6')
    sleep 1
    play chord(:Eb5, :m)
    sleep 1.5
  end
end

live_loop :bassline_1, sync: :melody do
  use_synth :hoover
  use_synth_defaults amp: 0.7, pan: -0.3
  play :Fs2, sustain: 2
  sleep 2
  play :B2, sustain: 2
  sleep 2
  play :E2, sustain: 3
  sleep 3
  play :F2, sustain: 1
  sleep 1
end



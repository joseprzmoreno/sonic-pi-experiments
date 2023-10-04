# lmms/project1

s = [62, 64, 65, 67, 69, 70]
s2 = [62, 64, 65, 67, 69, 70]

live_loop :midi do
  play_midi s.choose - 36, 2.4,
    'midi_through_midi_through_port-0_14_0'
end

c = 0
live_loop :midi2, sync: :midi do
  if c % 16 == 0 then
    s2 = s2.shuffle
  end
  play_midi s2.tick, [0.2, 0.3, 0.1].tick,
    'lmms_harmonium_129_1'
  c = c + 1
end

live_loop :r do
  sample :ambi_dark_woosh
  sleep 2.4
end

live_loop :midi3, sync: :midi do
  play_midi [57-12, 62-12, 67-12, 69-12].tick,
    2.4,
    'lmms_move_your_body_129_2'
end

define :play_midi do |freq, dur, port|
  midi_note_on freq, port: port
  sleep dur
  midi_note_off freq, port: port
end

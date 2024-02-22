use_bpm 120

set_volume! 0.6

val = 500
fac = 1
live_loop :main do
  use_synth :dsaw
  sc = scale(:D3, :dorian, num_octaves: 3).ring
  with_fx :nlpf, cutoff: 60 do
    val = 500 if val < 400
    mus = (Math.cos(val) * 100).abs.floor
    mus2 = (Math.sin(val) * 100).abs.floor
    puts mus
    puts mus2
    in_thread do
      use_synth :winwood_lead
      with_fx :reverb do
        play sc[mus2] * fac, amp: 1, sustain: 0.5
        sleep 0.5
        play sc[mus2+9] * fac, amp: 1, sustain: 0.5
        sleep 0.5
      end
    end
    in_thread do
      use_synth :prophet
      mus3 = (Math.tan(val) * 10 * Math::PI).abs.floor
      puts mus3
      play [sc[mus3]-24 * fac, sc[mus3+7]-24 * fac], sustain: 1, amp: 2
    end
    use_synth :dsaw
    play sc[mus]
    play sc[mus+2] * fac, sustain: 1.5, amp: 1
    play sc[mus+4] * fac, sustain: 1.5, amp: 1
    play sc[mus+6] * fac, sustain: 1.5, amp: 1
    val = val - 1
  end
  sleep 1
end

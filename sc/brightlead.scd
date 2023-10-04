(
SynthDef(\brightlead, {
  arg freq = 74, amp = 1.0, rate = 1.2;
	var sig = VarSaw.ar(freq.midicps, 6, 0.04, 0.1);
	var saw = Vibrato.ar(sig, 8, rate);
	var env = Env.new([0.0, 0.8, 0.0], [0.1, 1.3]);
	var gen = EnvGen.ar(env, 1, doneAction: 2);
	var pan = Pan2.ar(saw * gen * amp, 0);
	Out.ar(0, pan);
}).writeDefFile("/home/jose/projects/sonic_pi/sc")
)
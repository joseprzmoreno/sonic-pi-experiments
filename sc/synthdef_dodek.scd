(
SynthDef.new(\dodek, {
	arg freq = 62, release = 3;
	var f = freq;
	var sig = Saw.ar([f.midicps, (f+4).midicps, (f+7).midicps,], 0.6);
	var env = EnvGen.ar(Env.new([0.1, 0.9, 0],[0.1, release]), doneAction: 2);
	sig = sig * env;
	sig = Mix.new(sig);
	sig = Vibrato.ar(sig);
	sig = Pan2.ar(sig);
	Out.ar(0, sig);
}).writeDefFile("/home/jose/projects/sonic_pi/sc");
)

`
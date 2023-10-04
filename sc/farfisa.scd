(
SynthDef(\violin, {
	| midinote=60, amp= 0.5 |
	var env = EnvGen.kr(Env.new([0.1, 1, 0.1],[0.05, 0.4]), doneAction:2);
	var sig = VarSaw.ar(
		midinote.midicps,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = Vibrato.ar(sig, 4, 0.01, 0.1);
	sig = sig * env * amp;
	Out.ar(0, sig!2);
}).writeDefFile("/home/jose/projects/sonic_pi/sc");
)
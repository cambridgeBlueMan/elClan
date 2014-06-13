(
var theFiles; // an array of file names derived using .pathMatch method
~myClock = TempoClock.new(0.48);

// first get the array of files
//theDir= (thisProcess.nowExecutingPath.dirname ++ "/your/direcotry").pathMatch;
theFiles= ("/Volumes/work/elClan/samples/gitPerc*.wav").pathMatch.postln;
theFiles.postln;
// ************************************************************************************
//                     load buffers and organise housekeeping
// ************************************************************************************
~theBuffers = List.new(0);
CmdPeriod.add({
	~theBuffers.do ({|item, i|
		item.free;
	});
});
s.waitForBoot({
	theFiles.do({|path, i|
		Buffer.read(
			s,
			path,
			action:{|buffer|
				~theBuffers.add(buffer);
				if (i == (theFiles.size-1),
					{

						"buffers loaded!".postln;
					"/Volumes/work/elClan/elClanData1.scd".load;}
				); // end if
			} // end action
		);
	});
}); // end wait for boot

)


// SCRATCH
(
Pbind(
	\instrument, \buffPlayer,
	\bufnum, Pseq([ ~theBuffers[1], \rest, ~theBuffers[2], \rest], inf),
	\dur, Pseq([1/4, Rest(1/4), 1/4, Rest(1/4)], 2)
).play(~myClock)
)


// ***************************************
// bongo pattern is there s from the start
~percDurs1 = Pseq([Rest(3/16), 1/16, Rest(1/8), 1/8], inf);
~percNotes1 = Pseq([\rest, ~theBuffers[0], \rest, ~theBuffers[0]], inf);
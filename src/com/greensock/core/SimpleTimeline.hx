package com.greensock.core;

/**
 * SimpleTimeline is the base class for TimelineLite and TimelineMax, providing the most basic timeline functionality and it is used for the root timelines in TweenLite but is only intended for internal use in the GreenSock tweening platform. It is meant to be very fast and lightweight.
 */

#if (js)
@:native("SimpleTimeline")
#end
extern class SimpleTimeline extends Animation {
	
	/**
	 * Constructor
	 * @param	vars (default = null) — Object containing configuration variables like onComplete, onUpdate, onStart, data, etc.
	 */
	public function new(?vars:Dynamic);
	
	/**
	 * If true, child tweens/timelines will be removed as soon as they complete.
	 */
	public var autoRemoveChildren : Bool;
	
	/**
	 * Controls whether or not child tweens/timelines are repositioned automatically (changing their startTime) in order to maintain smooth playback when properties are changed on-the-fly.
	 */
	public var smoothChildTiming : Bool;
	
	/**
	 * Add
	 * Adds a TweenLite, TweenMax, TimelineLite, or TimelineMax instance to the timeline at a specific time.
	 * @param	child TweenLite, TweenMax, TimelineLite, or TimelineMax instance to insert
	 * @param	position (default = +=0) — The position at which the tween/timeline should be inserted which can be expressed as a number (for an absolute time as seconds or frames for frames-based timelines) or a string, using "+=" or "-=" prefix to indicate a relative value (relative to the END of the timeline). For example, myTimeline.insert(myTween, 3) would insert myTween 3 seconds into the timeline.
	 * @param	align (default = normal) — Determines how the tweens/timelines/callbacks/labels will be aligned in relation to each other before getting inserted. Options are: "sequence" (aligns them one-after-the-other in a sequence), "start" (aligns the start times of all of the objects (ignoring delays)), and "normal" (aligns the start times of all the tweens (honoring delays)). The default is "normal".
	 * @param	stagger (default = 0) — Staggers the inserted objects by a set amount of time (in seconds) (or in frames for frames-based timelines). For example, if the stagger value is 0.5 and the "align" parameter is set to "start", the second one will start 0.5 seconds after the first one starts, then 0.5 seconds later the third one will start, etc. If the align property is "sequence", there would be 0.5 seconds added between each tween. Default is 0.
	 * @return this timeline instance (useful for chaining like myTimeline.add(...).add(...))
	 */
	public function add(child : Animation, ?position: Dynamic, ?align : String, ?stagger : Float) : SimpleTimeline;
	
	/**
	 * renders
	 * @param	time the time
	 * @param	suppressEvents (default = false)
	 * @param	force (default = false)
	 */
    public function render(time:Float, ?suppressEvents:Bool, ?force:Bool):Void;
}


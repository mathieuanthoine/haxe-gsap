package com.greensock.core;

/**
 * Base class for all TweenLite, TweenMax, TimelineLite, and TimelineMax classes, providing core methods/properties/functionality, but there is no reason to create an instance of this class directly.
 */

#if (js)
@:native("Animation")
#end
extern class Animation {
	
	/**
	 * Constructor
	 * @param	duration (default = 0) — duration in seconds (or frames for frames-based tweens)
	 * @param	vars configuration variables (for example, {x:100, y:0, opacity:0.5, onComplete:myFunction})
	 */
    public function new(?duration:Float, ?vars:Dynamic);
	
	/**
	 * A place to store any data you want (initially populated with vars.data if it exists).
	 */
	public var data:Dynamic;
	
	/**
	 * Parent timeline. Every animation is placed onto a timeline (the root timeline by default) and can only have one parent. An instance cannot exist in multiple timelines at once.
	 */
	public var timeline (default,null) :SimpleTimeline;
	
	/**
	 * The vars object passed into the constructor which stores configuration variables like onComplete, onUpdate, etc. as well as tweening properties like opacity, x, y or whatever.
	 */
	public var vars:Dynamic;
	
	/**
	 * Gets or sets the animation's initial delay which is the length of time in seconds (or frames for frames-based tweens) before the animation should begin.
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function delay(?value:Float):Dynamic;
	
	/**
	 * Gets or sets the animation's duration, not including any repeats or repeatDelays (which are only available in TweenMax and TimelineMax).
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function duration(?value:Float):Dynamic;
	
	/**
	 * Gets or sets an event callback like "onComplete", "onUpdate", "onStart", "onReverseComplete" or "onRepeat" (onRepeat only applies to TweenMax or TimelineMax instances) along with any parameters that should be passed to that callback.
	 * @param	type The type of event callback, like "onComplete", "onUpdate", "onStart" or "onRepeat". This is case-sensitive.
	 * @param	callback (default = null) — The function that should be called when the event occurs.
	 * @param	params (default = null) — An array of parameters to pass the callback. Use "{self}" to refer to the animation instance itself. Example: ["param1","{self}"]
	 * @param	scope (default = null) — The scope in which the callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only pertains to the JavaScript and AS2 versions; it is omitted in AS3.
	 * @return Omitting the all but the first parameter returns the current value (getter), whereas defining more than the first parameter sets the callback (setter) and returns the instance itself for easier chaining.
	 */
    public function eventCallback(type:String, ?callback:Void->Void, ?params:Array<Dynamic>, ?scope:Dynamic):Dynamic;
	
	/**
	 * Clears any initialization data (like starting/ending values in tweens) which can be useful if, for example, you want to restart a tween without reverting to any previously recorded starting values.
	 * @return self (makes chaining easier)
	 */
    public function invalidate():Animation;
	
	/**
	 * Indicates whether or not the animation is currently active (meaning the virtual playhead is actively moving across this instance's time span and it is not paused, nor are any of its ancestor timelines).
	 * @return 
	 */
    public function isActive():Bool;
	
	/**
	 * Kills the animation entirely or in part depending on the parameters.
	 * @param	vars (default = null) — To kill only specific properties, use a generic object containing enumerable properties corresponding to the ones that should be killed, like {x:true, y:true}. The values assigned to each property of the object don't matter - the sole purpose of the object is for iteration over the named properties (in this case, x and y). If no object (or null) is defined, ALL properties will be killed.
	 * @param	target (default = null) — To kill only aspects of the animation related to a particular target (or targets), reference it here. For example, to kill only parts having to do with myObject, do kill(null, myObject) or to kill only parts having to do with myObject1 andmyObject2, do kill(null, [myObject1, myObject2]). If no target is defined, ALL targets will be affected.
	 * @return self (makes chaining easier)
	 */
    public function kill(?vars:Dynamic, ?target:Dynamic):Animation;
	
	/**
	 * Pauses the instance, optionally jumping to a specific time.
	 * @param	atTime (default = null) — The time (or label for TimelineLite/TimelineMax instances) that the instance should jump to before pausing (if none is defined, it will pause wherever the playhead is currently located).
	 * @param	suppressEvents default = true) — If true (the default), no events or callbacks will be triggered when the playhead moves to the new position defined in the atTime parameter.
	 * @return self (makes chaining easier)
	 */
    public function pause(?atTime:Dynamic, ?suppressEvents:Bool):Animation;
	
	/**
	 * Gets or sets the animation's paused state which indicates whether or not the animation is currently paused.
	 * @param	value (default = false) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function paused(?value:Bool):Dynamic;
	
	/**
	 * Begins playing forward, optionally from a specific time (by default playback begins from wherever the playhead currently is).
	 * @param	from (default = null) — The time (or label for TimelineLite/TimelineMax instances) from which the animation should begin playing (if none is defined, it will begin playing from wherever the playhead currently is).
	 * @param	suppressEvents (default = true) — If true (the default), no events or callbacks will be triggered when the playhead moves to the new position defined in the from parameter.
	 * @return self (makes chaining easier)
	 */
    public function play(?from:Dynamic, ?suppressEvents:Bool):Animation;
	
	/**
	 * Gets or sets the animations's progress which is a value between 0 and 1 indicating the position of the virtual playhead (excluding repeats) where 0 is at the beginning, 0.5 is at the halfway point, and 1 is at the end (complete).
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @param	suppressEvents (default = false) — If true, no events or callbacks will be triggered when the playhead moves to the new position.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function progress(?value:Dynamic, ?suppressEvents:Bool):Dynamic;
	
	/**
	 * Restarts and begins playing forward from the beginning.
	 * @param	includeDelay (default = false) — Determines whether or not the delay (if any) is honored when restarting. For example, if a tween has a delay of 1 second, like new TweenLite(mc, 2, {x:100, delay:1}); and then later restart() is called, it will begin immediately, butrestart(true) will cause the delay to be honored so that it won't begin for another 1 second.
	 * @param	suppressEvents (default = true) — If true (the default), no events or callbacks will be triggered when the playhead moves to the new position defined in the time parameter.
	 * @return self (makes chaining easier)
	 */
    public function restart(?includeDelay:Bool, ?suppressEvents:Bool):Animation;
	
	/**
	 * Resumes playing without altering direction (forward or reversed), optionally jumping to a specific time first.
	 * @param	from (default = null) — The time (or label for TimelineLite/TimelineMax instances) that the instance should jump to before resuming playback (if none is defined, it will resume wherever the playhead is currently located).
	 * @param	suppressEvents (default = true) — If true (the default), no events or callbacks will be triggered when the playhead moves to the new position defined in the from parameter.
	 * @return self (makes chaining easier)
	 */
    public function resume(?from:Dynamic, ?suppressEvents:Bool):Animation;
	
	/**
	 * Reverses playback so that all aspects of the animation are oriented backwards including, for example, a tween's ease.
	 * @param	from (default = null) — The time (or label for TimelineLite/TimelineMax instances) from which the animation should begin playing in reverse (if none is defined, it will begin playing from wherever the playhead currently is). To begin at the very end of the animation, use 0. Negative numbers are relative to the end of the animation, so -1 would be 1 second from the end.
	 * @param	suppressEvents Boolean (default = true) — If true (the default), no events or callbacks will be triggered when the playhead moves to the new position defined in the from parameter.
	 * @return self (makes chaining easier)
	 */
    public function reverse(?from:Dynamic, ?suppressEvents:Bool):Animation;
	
	/**
	 * Gets or sets the animation's reversed state which indicates whether or not the animation should be played backwards.
	 * @param	value (default = false) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function reversed(?value:Bool):Dynamic;
	
	/**
	 * 
	 * @param	time The time (or label for TimelineLite/TimelineMax instances) to go to.
	 * @param	suppressEvents (default = true) — If true (the default), no events or callbacks will be triggered when the playhead moves to the new position defined in the time parameter
	 * @return self (makes chaining easier)
	 */
    public function seek(time:Dynamic, ?suppressEvents:Bool = true):Animation;
	
	/**
	 * Gets or sets the time at which the animation begins on its parent timeline (after any delay that was defined).
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function startTime(?value:Float):Dynamic;
	
	/**
	 * Gets or sets the local position of the playhead (essentially the current time), described in seconds (or frames for frames-based animations) which will never be less than 0 or greater than the animation's duration.
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining. Negative values will be interpreted from the END of the animation.
	 * @param	suppressEvents (default = false) — If true, no events or callbacks will be triggered when the playhead moves to the new position defined in the value parameter.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function time(value:Float, ?suppressEvents:Bool):Dynamic;
	
	/**
	 * Factor that's used to scale time in the animation where 1 = normal speed (the default), 0.5 = half speed, 2 = double speed, etc.
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function timeScale(?value:Float):Dynamic;
	
	/**
	 * Gets or sets the animation's total duration including any repeats or repeatDelays (which are only available in TweenMax and TimelineMax).
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function totalDuration(?value:Float):Dynamic;
	
	/**
	 * Gets or sets the animation's total duration including any repeats or repeatDelays (which are only available in TweenMax and TimelineMax).
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @param	suppressEvents (default = false) — If true, no events or callbacks will be triggered when the playhead moves to the new position.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function totalProgress(?value:Float,?suppressEvents:Bool):Dynamic;
	
	/**
	 * Gets or sets the position of the playhead according to the totalDuration which includes any repeats and repeatDelays (only available in TweenMax and TimelineMax).
	 * @param	time (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining. Negative values will be interpreted from the END of the animation.
	 * @param	suppressEvents (default = false) — If true, no events or callbacks will be triggered when the playhead moves to the new position defined in the time parameter.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
    public function totalTime(?time:Float, ?suppressEvents:Bool):Dynamic;
}
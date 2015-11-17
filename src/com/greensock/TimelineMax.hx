package com.greensock;
import com.greensock.core.Animation;

/**
 * TimelineMax extends TimelineLite, offering exactly the same functionality plus useful (but non-essential) features like repeat, repeatDelay, yoyo, currentLabel(), addCallback(), removeCallback(), tweenTo(), tweenFromTo(), getLabelAfter(), getLabelBefore(), getActive() (and probably more in the future). It is the ultimate sequencing tool that acts like a container for tweens and other timelines, making it simple to control them as a whole and precisely manage their timing.
 */

@:native("TimelineMax")
extern class TimelineMax extends TimelineLite 
{

	/**
	 * Constructor
	 * @param	vars (default = null) — The vars parameter allows you to configure a TimelineMax with a variety of options using the following syntax: new TimelineMax({repeat:1, onRepeat:repeatHandler, paused:true});  
	 */
	public function new( ?vars: Dynamic ); 
	
	/**
	 * Returns the most recently added child tween/timeline/callback regardless of its position in the timeline.
	 * @return instance of Animation
	 */
	public function recent ():Animation;
	
	/**
	 * Inserts a callback at a particular position.
	 * @param	callback The function to be called
	 * @param	position The time in seconds (or frames for frames-based timelines) or label at which the callback should be inserted. For example, myTimeline.addCallback(myFunction, 3) would call myFunction() 3 seconds into the timeline, and myTimeline.addCallback(myFunction, "myLabel") would call it at the "myLabel" label.myTimeline.addCallback(myFunction, "+=2") would insert the callback 2 seconds after the end of the timeline.
	 * @param	params (default = null) — An Array of parameters to pass the callback
	 * @param	scope (default = null) — The scope in which the callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only pertains to the JavaScript and AS2 versions; it is omitted in AS3.
	 * @return self (makes chaining easier)
	 */
	public function addCallback(callback:Void->Void, position:Dynamic, ?params:Array<Dynamic>, ?scope:Dynamic):TimelineMax;

	/**
	 * Gets the closest label that is at or before the current time, or jumps to a provided label (behavior depends on whether or not you pass a parameter to the method).
	 * @param	value (default = null) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
	public function currentLabel(?value:String):Dynamic;
	
	/**
	 * Seamlessly transfers all tweens, timelines, and [optionally] delayed calls from the root timeline into a new TimelineLite so that you can perform advanced tasks on a seemingly global basis without affecting tweens/timelines that you create after the export.
	 * @param	vars (default = null) — The vars parameter that's passed to the TimelineLite's constructor which allows you to define things like onUpdate, onComplete, etc. TheuseFrames special property determines which root timeline gets exported. There are two distinct root timelines - one for frames-based animations (useFrames:true) and one for time-based ones. By default, the time-based timeline is exported.
	 * @param	omitDelayedCalls (default = true) — If true (the default), delayed calls will be left on the root rather than wrapped into the new TimelineLite. That way, if youpause() or alter the timeScale, or reverse(), they won't be affected. However, in some situations it might be very useful to have them included.
	 * @return A new TimelineLite instance containing the root tweens/timelines
	 */
	static public function exportRoot (?vars:Dynamic, ?omitDelayedCalls:Bool):TimelineLite;

	/**
	 * Returns the tweens/timelines that are currently active in the timeline, meaning the timeline's playhead is positioned on the child tween/timeline and the child isn't paused.
	 * @param	nested (default = true) — Determines whether or not tweens and/or timelines that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
	 * @param	tweens (default = true) — Determines whether or not tweens (TweenLite and TweenMax instances) should be included in the results
	 * @param	timelines (default = false) — Determines whether or not child timelines (TimelineLite and TimelineMax instances) should be included in the results
	 * @return an Array of active tweens/timelines
	 */
	public function getActive(?nested:Bool, ?tweens:Bool, ?timelines:Bool):Array<Animation>;

	/**
	 * Returns the next label (if any) that occurs after the time parameter.
	 * @param	time (default = NaN) — Time after which the label is searched for. If you do not pass a time in, the current time will be used.  
	 * @return Name of the label that is after the time passed to getLabelAfter()
	 */
	public function getLabelAfter(?time:Float):String;

	/**
	 * Returns the previous label (if any) that occurs before the time parameter.
	 * @param	time (default = NaN) — Time before which the label is searched for. If you do not pass a time in, the current time will be used.  
	 * @return Name of the label that is before the time passed to getLabelBefore()
	 */
	public function getLabelBefore(?time:Float):String;

	/**
	 * Returns an Array of label objects, each with a "time" and "name" property, in the order that they occur in the timeline.
	 * @return An array of generic objects (one for each label) with a "name" property and a "time" property in the order they occur in the TimelineMax.
	 */
	public function getLabelsArray():Array<Dynamic>;

	/**
	 * Removes a callback from a particular position.
	 * @param	callback callback function to be removed
	 * @param	timeOrLabel (default = null) — the time in seconds (or frames for frames-based timelines) or label from which the callback should be removed. For example,myTimeline.removeCallback(myFunction, 3) would remove the callback from 3-seconds into the timeline, and myTimeline.removeCallback(myFunction, "myLabel")would remove it from the "myLabel" label, and myTimeline.removeCallback(myFunction, null) would remove ALL callbacks of that function regardless of where they are on the timeline.
	 * @return self (makes chaining easier)
	 */
	public function removeCallback(callback:Void->Void, ?timeOrLabel:Dynamic):TimelineMax;

	/**
	 * Gets or sets the number of times that the timeline should repeat after its first iteration.
	 * @param	value (default = 0) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
	public function repeat(?value:Float):Dynamic;

	/**
	 * Gets or sets the amount of time in seconds (or frames for frames-based timelines) between repeats.
	 * @param	value (default = 0) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
	public function repeatDelay(?value:Float):Dynamic;

	/**
	 * Creates a linear tween that essentially scrubs the playhead from a particular time or label to another time or label and then stops.
	 * @param	fromPosition The beginning time in seconds (or frame if the timeline is frames-based) or label from which the timeline should play. For example, myTimeline.tweenTo(0, 5) would play from 0 (the beginning) to the 5-second point whereas myTimeline.tweenFromTo("myLabel1", "myLabel2") would play from "myLabel1" to "myLabel2".
	 * @param	toPosition The destination time in seconds (or frame if the timeline is frames-based) or label to which the timeline should play. For example, myTimeline.tweenTo(0, 5)would play from 0 (the beginning) to the 5-second point whereas myTimeline.tweenFromTo("myLabel1", "myLabel2") would play from "myLabel1" to "myLabel2".
	 * @param	vars (default = null) — An optional vars object that will be passed to the TweenLite instance. This allows you to define an onComplete, ease, delay, or any other TweenLite special property. onInit is the only special property that is not available (tweenFromTo() sets it internally)
	 * @return TweenLite instance that handles tweening the timeline between the desired times/labels.
	 */
	public function tweenFromTo(fromPosition:Dynamic, toPosition:Dynamic, ?vars:Dynamic):TweenLite;

	/**
	 * Creates a linear tween that essentially scrubs the playhead to a particular time or label and then stops.
	 * @param	position The destination time in seconds (or frame if the timeline is frames-based) or label to which the timeline should play. For example, myTimeline.tweenTo(5) would play from wherever the timeline is currently to the 5-second point whereas myTimeline.tweenTo("myLabel") would play to wherever "myLabel" is on the timeline.
	 * @param	vars (default = null) — An optional vars object that will be passed to the TweenLite instance. This allows you to define an onComplete, ease, delay, or any other TweenLite special property.
	 * @return A TweenLite instance that handles tweening the timeline to the desired time/label.
	 */
	public function tweenTo(position:Dynamic, ?vars:Dynamic):TweenLite;
	
	/**
	 * Gets or sets the timeline's yoyo state, where true causes the timeline to go back and forth, alternating backward and forward on each repeat.
	 * @param	value (default = false) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
	public function yoyo(?value:Bool):Dynamic;
	
}
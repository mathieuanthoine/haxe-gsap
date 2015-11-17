package com.greensock;

import com.greensock.core.Animation;
import com.greensock.core.SimpleTimeline;

/**
 *
 */

@:native("TimelineLite")
extern class TimelineLite extends SimpleTimeline 
{
	
	public function new();
	
	/**
	 * Adds a label to the timeline, making it easy to mark important positions/times.
	 * @param	label The name of the label
	 * @param	position Controls the placement of the label in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the label 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the label inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the label 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the label there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @return self (makes chaining easier)
	 */
	public function addLabel(label:String, position:Dynamic):TimelineLite;
	
	/**
	 * Inserts a special callback that pauses playback of the timeline at a particular time or label.
	 * @param	position (default = +=0) — Controls the placement of the pause in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @param	callback (default = null) — An optional callback that should be called immediately after the timeline is paused.
	 * @param	params (default = null) — An optional array of parameters to pass the callback.
	 * @param	scope (default = null) — The scope in which the callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only exists in the JavaScript and AS2 versions.
	 * @return self (makes chaining easier)
	 */
	public function addPause (?position:Dynamic, ?callback:Void->Void, ?params:Array<Dynamic>, ?scope:Dynamic ) :TimelineLite;
	
	/**
	 * Adds a callback to the end of the timeline (or elsewhere using the "position" parameter) - this is a convenience method that accomplishes exactly the same thing as add( TweenLite.delayedCall(...) ) but with less code.
	 * @param	callback Function to call
	 * @param	params (default = null) — An Array of parameters to pass the function.
	 * @param	scope (default = null) — The scope in which the callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only exists in the JavaScript and AS2 versions.
	 * @param	position (default = +=0) — Controls the placement of the callback in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the callback 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the callback inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the callback 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the callback there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @return self (makes chaining easier)
	 */
    public function call(callback:Void->Void, ?params:Array<Dynamic>, ?scope:Dynamic, ?position:Float):TimelineLite;
	
	/**
	 * Empties the timeline of all tweens, timelines, and callbacks (and optionally labels too).
	 * @param	labels (default = true) — If true (the default), labels will be cleared too.  
	 * @return self (makes chaining easier)
	 */
    public function clear(?labels:Bool):TimelineLite;

	/**
	 * Seamlessly transfers all tweens, timelines, and [optionally] delayed calls from the root timeline into a new TimelineLite so that you can perform advanced tasks on a seemingly global basis without affecting tweens/timelines that you create after the export.
	 * @param	vars Seamlessly transfers all tweens, timelines, and [optionally] delayed calls from the root timeline into a new TimelineLite so that you can perform advanced tasks on a seemingly global basis without affecting tweens/timelines that you create after the export.
	 * @param	omitDelayedCalls (default = true) — If true (the default), delayed calls will be left on the root rather than wrapped into the new TimelineLite. That way, if youpause() or alter the timeScale, or reverse(), they won't be affected. However, in some situations it might be very useful to have them included.
	 * @return A new TimelineLite instance containing the root tweens/timelines
	 */
    static public function exportRoot(?vars:Dynamic, omitDelayedCalls:Bool = true):TimelineLite;
	
	/**
	 * Adds a TweenLite.from() tween to the end of the timeline (or elsewhere using the "position" parameter) - this is a convenience method that accomplishes exactly the same thing as add( TweenLite.from(...) ) but with less code.
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if the timeline is frames-based)
	 * @param	vars An object defining the starting value for each property that should be tweened as well as any special properties like onComplete, ease, etc. For example, to tween element's left from 100 and element's top from 200 and then call myFunction, do this: myTimeline.from(element, 1, {left:100, top:200, onComplete:myFunction});
	 * @param	position (default = +=0) — Controls the placement of the tween in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @return self (makes chaining easier)
	 */
    public function from(target:Dynamic, duration:Float, ?vars:Dynamic, ?position:Dynamic):TimelineLite;

	/**
	 * Adds a TweenLite.fromTo() tween to the end of the timeline - this is a convenience method that accomplishes exactly the same thing as add( TweenLite.fromTo(...) ) but with less code.
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if the timeline is frames-based)
	 * @param	fromVars An object defining the starting value for each property that should be tweened. For example, to tween element's left from 100 and element's top from 200,fromVars would look like this: {left:100, top:200}.
	 * @param	toVars An object defining the end value for each property that should be tweened as well as any special properties like onComplete, ease, etc. For example, to tween element's left from 0 to 100 and element's top from 0 to 200 and then call myFunction, do this: myTimeline.fromTo(element, 1, {left:0, top:0}, {left:100, top:200, onComplete:myFunction});
	 * @param	position (default = +=0) — Controls the placement of the tween in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @return self (makes chaining easier)
	 */
    public function fromTo(target:Dynamic, duration:Float, ?fromVars:Dynamic, ?toVars:Dynamic, ?position:Dynamic):Dynamic;
	
	/**
	 * Returns an array containing all the tweens and/or timelines nested in this timeline.
	 * @param	nested (default = true) — Determines whether or not tweens and/or timelines that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
	 * @param	tweens (default = true) — Determines whether or not tweens (TweenLite and TweenMax instances) should be included in the results
	 * @param	timelines (default = true) — Determines whether or not timelines (TimelineLite and TimelineMax instances) should be included in the results
	 * @param	ignoreBeforeTime Number (default = -9999999999) — All children with start times that are less than this value will be ignored.
	 * @return Returns an array containing all the tweens and/or timelines nested in this timeline. Callbacks (delayed calls) are considered zero-duration tweens.
	 */
    public function getChildren(?nested:Bool, ?tweens:Bool, ?timelines:Bool, ?ignoreBeforeTime:Float):Array<Animation>;
	
	/**
	 * Returns the time associated with a particular label.
	 * @param	label Label name
	 * @return Time associated with the label (or -1 if there is no such label)
	 */
    public function getLabelTime(label:String):Float;
	
	/**
	 * Returns the tweens of a particular object that are inside this timeline.
	 * @param	target The target object of the tweens
	 * @param	nested (default = true) — Determines whether or not tweens that are inside nested timelines should be returned. If you only want the "top level" tweens/timelines, set this to false.
	 * @return an Array of TweenLite and/or TweenMax instances
	 */
    public function getTweensOf(target:Dynamic, ?nested:Bool ):Array<Animation>;
	
	/**
	 * Removes a tween, timeline, callback, or label (or array of them) from the timeline.
	 * @param	value The tween, timeline, callback, or label that should be removed from the timeline (or an array of them)
	 * @return self (makes chaining easier)
	 */
    public function remove(value:Dynamic):TimelineLite;
	
	/**
	 * Removes a label from the timeline and returns the time of that label.
	 * @param	label The name of the label to remove  
	 * @return Time associated with the label that was removed
	 */
    public function removeLabel(label:String):Dynamic;
	
	/**
	 * Adds a zero-duration tween to the end of the timeline (or elsewhere using the "position" parameter) that sets values immediately (when the virtual playhead reaches that position on the timeline) - this is a convenience method that accomplishes exactly the same thing as add( TweenLite.to(target, 0, {...}) ) but with less code.
	 * @param	target Target object (or array of objects) whose properties will be set.
	 * @param	vars An object defining the value to which each property should be set. For example, to set element's left to 100 and element's top to 200, do this:myTimeline.set(element, {left:100, top:200});
	 * @param	position (default = +=0) — Controls the placement of the zero-duration tween in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like"myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient.
	 * @return self (makes chaining easier)
	 */
    public function set(target:Dynamic, vars:Dynamic, ?position:Dynamic):TimelineLite;
	
	/**
	 * Shifts the startTime of the timeline's children by a certain amount and optionally adjusts labels too.
	 * @param	amount Number of seconds (or frames for frames-based timelines) to move each child.
	 * @param	adjustLabels (default = false) — If true, the timing of all labels will be adjusted as well.
	 * @param	ignoreBeforeTime (default = 0) — All children that begin at or after the startAtTime will be affected by the shift (the default is 0, causing all children to be affected). This provides an easy way to splice children into a certain spot on the timeline, pushing only the children after that point back to make room.
	 * @return self (makes chaining easier)
	 */
    public function shiftChildren(amount:Float, ?adjustLabels:Bool, ?ignoreBeforeTime:Float):TimelineLite;
	
	/**
	 * Tweens an array of targets from a common set of destination values (using the current values as the destination), but staggers their start times by a specified amount of time, creating an evenly-spaced sequence with a surprisingly small amount of code.
	 * @param	targets An array of objects whose properties should be affected. When animating DOM elements, the targets can be: an array of elements, a jQuery object (or similar), or a CSS selector string like “.myClass” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if the timeline is frames-based)
	 * @param	vars An object defining the beginning value for each property that should be tweened as well as any special properties like ease. For example, to tween left from 100 and top from 200 for element1, element2, and element3, staggering their start time by 0.25 seconds and then call myFunction when they last one has finished, do this:myTimeline.staggerFrom([element1, element2, element3], 1, {left:100, top:200}, 0.25, 0, null, myFunction}).
	 * @param	stagger (default = 0) — Amount of time in seconds (or frames if the timeline is frames-based) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: myTimeline.staggerTo([element1, element2, element3, element4, element5], 1, {top:"+=100", opacity:0}, 0.2).
	 * @param	position (default = +=0) — Controls the placement of the first tween in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @param	onCompleteAll (default = null) — A function to call as soon as the entire sequence of tweens has completed
	 * @param	onCompleteAllParams (default = null) — An array of parameters to pass the onCompleteAll method.
	 * @param	onCompleteAllScope The scope for the onCompleteAll function call (what "this" should refer to inside that function)
	 * @return self (makes chaining easier)
	 */
    public function staggerFrom(targets:Array<Dynamic>, duration:Float, vars:Dynamic, stagger:Float, ?position:Dynamic, ?onCompleteAll:Void->Void, ?onCompleteAllParams:Array<Dynamic>, ?onCompleteAllScope:Dynamic):TimelineLite;

	/**
	 * Tweens an array of targets from and to a common set of values, but staggers their start times by a specified amount of time, creating an evenly-spaced sequence with a surprisingly small amount of code.
	 * @param	targets An array of objects whose properties should be affected. When animating DOM elements, the targets can be: an array of elements, a jQuery object (or similar), or a CSS selector string like “.myClass” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if the timeline is frames-based)
	 * @param	fromVars An object defining the starting value for each property that should be tweened. For example, to tween left from 100 and top from 200, fromVars would look like this: {left:100, top:200}.
	 * @param	toVars An object defining the end value for each property that should be tweened as well as any special properties like ease. For example, to tween left from 0 to 100 and top from 0 to 200, staggering the start times by 0.2 seconds and then call myFunction when they all complete, do this: myTimeline.staggerFromTo([element1, element2, element3], 1, {left:0, top:0}, {left:100, top:200}, 0.2, 0, null, myFunction});
	 * @param	stagger (default = 0) — Amount of time in seconds (or frames if the timeline is frames-based) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: myTimeline.staggerTo([element1, element2, element3, element4, element5], 1, {top:"+=100", opacity:0}, 0.2).
	 * @param	position (default = +=0) — Controls the placement of the first tween in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @param	onCompleteAll (default = null) — A function to call as soon as the entire sequence of tweens has completed
	 * @param	onCompleteAllParams (default = null) — An array of parameters to pass the onCompleteAll method.
	 * @param	onCompleteAllScope The scope for the onCompleteAll function call (what "this" should refer to inside that function)
	 * @return self (makes chaining easier)
	 */
    public function staggerFromTo(targets:Array<Dynamic>, duration:Float, fromVars:Dynamic, toVars:Dynamic, ?stagger:Float, ?position:Dynamic, ?onCompleteAll:Dynamic, ?onCompleteAllParams:Array<Dynamic>, ?onCompleteAllScope:Dynamic):TimelineLite;

	/**
	 * Tweens an array of targets to a common set of destination values, but staggers their start times by a specified amount of time, creating an evenly-spaced sequence with a surprisingly small amount of code.
	 * @param	targets An array of objects whose properties should be affected. When animating DOM elements, the targets can be: an array of elements, a jQuery object (or similar), or a CSS selector string like “.myClass” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if the timeline is frames-based)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties like ease. For example, to tween left to 100 and topto 200 for element1, element2, and element3, staggering their start time by 0.25 seconds and then call myFunction when they last one has finished, do this:myTimeline.staggerTo([element1, element2, element3], 1, {left:100, top:200}, 0.25, 0, null, myFunction}).
	 * @param	stagger (default = 0) — Amount of time in seconds (or frames if the timeline is frames-based) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: myTimeline.staggerTo([element1, element2, element3, element4, element5], 1, {top:"+=100", opacity:0}, 0.2).
	 * @param	position (default = +=0) — Controls the placement of the first tween in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @param	onCompleteAll (default = null) — A function to call as soon as the entire sequence of tweens has completed
	 * @param	onCompleteAllParams (default = null) — An array of parameters to pass the onCompleteAll method.
	 * @param	onCompleteAllScope The scope for the onCompleteAll function call (what "this" should refer to inside that function)
	 * @return self (makes chaining easier)
	 */
    public function staggerTo(targets:Array<Dynamic>, duration:Float, vars:Dynamic, stagger:Float, ?position:Dynamic, ?onCompleteAll:Void->Void, ?onCompleteAllParams:Array<Dynamic>, ?onCompleteAllScope:Dynamic):TimelineLite;

	/**
	 * Adds a TweenLite.to() tween to the end of the timeline (or elsewhere using the "position" parameter) - this is a convenience method that accomplishes exactly the same thing as add( TweenLite.to(...) ) but with less code.
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if the timeline is frames-based)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties like onComplete, ease, etc. For example, to tween element's left to 100 and element's top to 200 and then call myFunction, do this: myTimeline.to(element, 1, {left:100, top:200, onComplete:myFunction}).
	 * @param	position (default = +=0) — Controls the placement of the tween in the timeline (by default, it's the end of the timeline, like "+=0"). Use a number to indicate an absolute time in terms of seconds (or frames for frames-based timelines), or you can use a string with a "+=" or "-=" prefix to offset the insertion point relative to the END of the timeline. For example, "+=2" would place the tween 2 seconds after the end, leaving a 2-second gap. "-=2" would create a 2-second overlap. You may also use a label like "myLabel" to have the tween inserted exactly at the label or combine a label and a relative offset like "myLabel+=2" to insert the tween 2 seconds after "myLabel" or "myLabel-=3" to insert it 3 seconds before "myLabel". If you define a label that doesn't exist yet, it will automatically be added to the end of the timeline before inserting the tween there which can be quite convenient. Be sure to read our tutorial Understanding the Position Parameter which includes interactive timeline visualizations and a video.
	 * @return self (makes chaining easier)
	 */
    public function to(target:Dynamic, duration:Float, ?vars:Dynamic, ?position:Dynamic):TimelineLite;
	
	/**
	 * If true, the timeline's timing mode is frames-based instead of seconds.
	 */
    public var usesFrames (default,null) : Bool;
	
}
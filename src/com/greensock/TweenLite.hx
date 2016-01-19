package com.greensock; 

import com.greensock.core.Animation;
import com.greensock.easing.Ease;

/**
 * TweenLite is an extremely fast, lightweight, and flexible animation tool that serves as the foundation of the GreenSock Animation Platform (GSAP). A TweenLite instance handles tweening one or more properties of any object (or array of objects) over time. TweenLite can be used on its own to accomplish most animation chores with minimal file size or it can be used in conjunction with advanced sequencing tools like TimelineLite or TimelineMax to make complex tasks much simpler.
 */

#if (js)
@:native("TweenLite")
#end
extern class TweenLite extends Animation 
{

	/**
	 * TweenLite Constructor creates a tween.
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties like onComplete, ease, etc. For example, to tween mc.x to 100 and mc.y to 200 and then callmyFunction, do this: new TweenLite(mc, 1, {x:100, y:200, onComplete:myFunction}). Learn more about the properties that can be passed into the vars object below.
	 */
	public function new(target:Dynamic,duration:Float,vars:Dynamic);	
	
	/**
	 * Provides An easy way to change the default easing equation. Choose from any of the GreenSock eases in the com.greensock.easing package.
	 * The default value is Power1.easeOut.
	 */
	public static var defaultEase : Ease;
	
	/**
	 * Provides An easy way to change the default overwrite mode. Choose from any of the following: "auto", "all", "none", "allOnStart", "concurrent", "preexisting".
	 * The default value is "auto".
	 */
	public static var defaultOverwrite : String;
	
	/**
	 * A function that should be called when any tween gets overwritten by another tween (great for debugging). The following parameters will be passed to that function:
	 * 1) overwrittenTween : Animation - the tween that was just overwritten
	 * 2) overwritingTween : Animation - the tween did the overwriting
	 * 3) target : Object [only passed if the overwrite mode was "auto" because that's the only case when portions of a tween can be overwritten rather than the entire thing] - the target object whose properties were overwritten. This is usually the same as overwrittenTween.target unless that's an array and the overwriting targeted a sub-element of that array. For example, TweenLite.to([obj1, obj2], 1, {x:100}) and then TweenLite.to(obj2, 1, {x:50}), the target would be obj2.
	 * 4) overwrittenProperties : Array [only passed if the overwrite mode was "auto" because that's the only case when portions of a tween can be overwritten rather than the entire thing] - an array of property names that were overwritten, like ["x","y","opacity"].
	 * Note: there is also an onOverwrite special property that you can apply on a tween-by-tween basis like TweenLite.to(... {x:100, onOverwrite:yourFunction}).
	 */
	public static var onOverwrite : Animation -> Animation -> Dynamic -> ?Array<String> -> Void;
	
	/**
	 * The selector engine (like jQuery) that should be used when a tween receives a string as its target, like TweenLite.to("#myID", 1, {x:"100px"}).
	 */
	public static var selector: Dynamic;
	
	/**
	 * The object that dispatches a "tick" event each time the engine updates, making it easy for you to add your own listener(s) to run custom logic after each update (great for game developers).
	 */
	public static var ticker: Dynamic;
	
	/**
	 * [READ-ONLY] Target object (or array of objects) whose properties the tween affects.
	 */
	public var target (default, null): Dynamic;
  
    /**
     * Provides a simple way to call a function after a set amount of time (or frames).
     * @param	delay Delay in seconds (or frames if useFrames is true) before the function should be called
     * @param	callback Function to call
     * @param	params (default = null) — An Array of parameters to pass the function (optional).
     * @param	scope (default = null) — The scope in which the callback should be called (basically, what "this" refers to in the function).
     * @param	useFrames (default = false) — If the delay should be measured in frames instead of seconds, setuseFrames to true (default is false)
     * @return
     */
    static public function delayedCall(delay:Float, callback:Void->Void, ?params:Array<Dynamic>, ?scope:Dynamic, ?useFrames:Bool):TweenLite;
	
	/**
	 * Returns the time at which the animation will finish according to the parent timeline's local time.
	 * @param	includeRepeats (default = true) — by default, repeats are included when calculating the end time but you can pass false to prevent that.
	 * @return TweenLite instance
	 */
	public function endTime (?includeRepeats:Bool): Float;
	
	/**
	 * Static method for creating a TweenLite instance that tweens backwards - you define the BEGINNING values and the current values are used as the destination values which is great for doing things like animating objects onto the screen because you can set them up initially the way you want them to look at the end of the tween and then animate in from elsewhere.
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	vars An object defining the starting value for each property that should be tweened as well as any special properties like onComplete, ease, etc. For example, to tween obj.x from 100 and obj.y from 200 and then call myFunction, do this: TweenLite.from(obj, 1, {x:100, y:200, onComplete:myFunction});
	 * @return TweenLite instance
	 */
    static public function from(target:Dynamic, duration:Float, vars:Dynamic):TweenLite;
	
	/**
	 * Static method for creating a TweenLite instance that allows you to define both the starting and ending values (as opposed to to() and from() tweens which are based on the target's current values at one end or the other).
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	fromVars An object defining the starting value for each property that should be tweened. For example, to tween mc.x from 100 and mc.y from 200, fromVars would look like this: {x:100, y:200}.
	 * @param	toVars An object defining the end value for each property that should be tweened as well as any special properties likeonComplete, ease, etc. For example, to tween mc.x from 0 to 100 and mc.y from 0 to 200 and then call myFunction, do this:TweenLite.fromTo(mc, 1, {x:0, y:0}, {x:100, y:200, onComplete:myFunction});
	 * @return TweenLite instance
	 */
    static public function fromTo(target:Dynamic, duration:Float, fromVars:Dynamic, toVars:Dynamic):TweenLite;
	
	/**
	 * Returns an array containing all the tweens of a particular target (or group of targets) that have not been released for garbage collection yet which typically happens within a few seconds after the tween completes.
	 * @param	target The target whose tweens should be returned, or an array of such targets
	 * @param	onlyActive (default = false) — If true, only tweens that are currently active will be returned (a tween is considered "active" if the virtual playhead is actively moving across the tween and it is not paused, nor are any of its ancestor timelines paused).
	 * @return An array of tweens
	 */
    public static function getTweensOf(target:Dynamic,?onlyActive:Bool):Array<TweenLite>;
	
	/**
	 * Immediately kills all of the delayedCalls to a particular function.
	 * @param	func The function for which all delayedCalls should be killed/cancelled.
	 */
    static public function killDelayedCallsTo(func:Void->Void):Void;
	
	/**
	 * Kills all the tweens (or specific tweening properties) of a particular object or delayedCalls to a particular function.
	 * @param	target Object whose tweens should be killed immediately or selector text to feed the selector engine to find the target(s).
	 * @param	onlyActive (default = false) — If true, only tweens that are currently active will be killed (a tween is considered "active" if the virtual playhead is actively moving across the tween and it is not paused, nor are any of its ancestor timelines paused).
	 * @param	vars (default = null) — To kill only specific properties, use a generic object containing enumerable properties corresponding to the ones that should be killed like {x:true, y:true}. The values assigned to each property of the object don't matter - the sole purpose of the object is for iteration over the named properties (in this case, x and y). If no object (or null) is defined, all matched tweens will be killed in their entirety.
	 */
    static public function killTweensOf(target:Dynamic, ?onlyActive:Bool, ?vars:Dynamic):Void;
	
	/**
	 * Permits you to control what happens when too much time elapses between two ticks (updates) of the engine, adjusting the core timing mechanism to compensate and avoid "jumps".
	 * @param	threshold Amount of lag (in millisecond) after which the engine will adjust the internal clock to act like the adjustedLag elapsed instead. The lower the number, the more likely (and frequently) lagSmoothing() will be triggered. For example, if the threshold is 500 and the adjustedLag is 33 (those are the defaults), the only time an adjustment will occur is when more than 500ms elapses between two ticks in which case it will act as though only 33ms elapsed. So if the CPU bogs down for 2 full seconds (yikes!), your animations will move 33ms worth of time on the next render instead of jumping a full 2-seconds. Note: this has no affect on the device’s performance or true frame rate – this merely affects how GSAP reacts when the browser drops frames.
	 * @param	adjustedLag The new (adjusted) amount of time (in milliseconds) from the previous tick. Typically it is best to set this to at least 16 because that's the normal amount of time between ticks when the engine is running at 60 frames per second. It is more common to set it to at least 33 (which is 2 normal "ticks"). If you set the threshold and the adjustedLag too low, your animations can appear to slow down under heavy pressure. The higher the adjustedLag, the more of a "jump" you'll see when lagSmoothing kicks in.
	 */
	static public function lagSmoothing (threshold:Float, adjustedLag:Float ):Void;
	
	/**
	 * Forces a render of all active tweens which can be useful if, for example, you set up a bunch of from() tweens and then you need to force an immediate render (even of "lazy" tweens) to avoid a brief delay before things render on the very next tick.
	 */
	static public function render():Void;
	
	/**
	 * Immediately sets properties of the target accordingly - essentially a zero-duration to() tween with a more intuitive name.
	 * @param	target Target object (or array of objects or selector text) whose properties will be affected.
	 * @param	vars An object defining the value for each property that should be set. For example, to set mc.x to 100 and mc.y to 200, do this: TweenLite.set(mc, {x:100, y:200});  You may also define any of the special properties baked into GSAP like delay, onComplete, etc.
	 * @return A TweenLite instance (with a duration of 0) which can optionally be inserted into a TimelineLite/Max instance (although it's typically more concise to just use the timeline's set() method).
	 */
    static public function set(target:Dynamic, vars:Dynamic):TweenLite;
	
	/**
	 * Static method for creating a TweenLite instance that animates to the specified destination values (from the current values).
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties like onComplete, ease, etc. For example, to tween mc.x to 100 and mc.y to 200 and then call myFunction, do this: TweenMax.to(mc, 1, {x:100, y:200, onComplete:myFunction}); Below is a full list of special properties.
	 * @return TweenLite instance
	 */
    static public function to(target:Dynamic, duration:Float, vars:Dynamic):TweenLite;
	
}
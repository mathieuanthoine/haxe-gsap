package com.greensock;
import com.greensock.core.Animation;
import com.greensock.TweenLite;

/**
 * TweenMax extends TweenLite, adding many useful (but non-essential) features like repeat(), repeatDelay(), yoyo(), and more. It also includes many extra plugins by default, making it extremely full-featured. Any of the plugins can work with TweenLite too, but TweenMax saves you the step of loading the common ones like CSSPlugin, RoundPropsPlugin, BezierPlugin, AttrPlugin, DirectionalRotationPlugin as well as EasePack, TimelineLite, and TimelineMax. Since TweenMax extends TweenLite, it can do ANYTHING TweenLite can do plus more. The syntax is identical. You can mix and match TweenLite and TweenMax in your project as you please, but if file size is a concern it is best to stick with TweenLite unless you need a particular TweenMax-only feature. 
 */

@:native("TweenMax") 
extern class TweenMax extends TweenLite {

	/**
	 * Constructor 
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties likeonComplete, ease, etc. For example, to tween mc.x to 100 and mc.y to 200 and then call myFunction, do this: new TweenMax(mc, 1, {x:100, y:200, onComplete:myFunction}). Below is a list of all special properties.
	 */
	public function new(target: Dynamic, duration: Float, vars: Dynamic); 
			
	/**
	 * Provides a simple way to call a function after a set amount of time (or frames).
	 * @param	delay Delay in seconds (or frames if useFrames is true) before the function should be called
	 * @param	callback Function to call
	 * @param	params (default = null) — An Array of parameters to pass the function (optional).
	 * @param	scope (default = null) — The scope in which the callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only pertains to the JavaScript and AS2 versions; it is omitted in AS3.
	 * @param	useFrames (default = false) — If the delay should be measured in frames instead of seconds, set useFrames to true
	 * @return TweenMax instance
	 */
	static public function delayedCall(delay:Float, callback:Void->Void, ?params:Array<Dynamic>, ?scope:Dynamic, ?useFrames:Bool):TweenMax;	
	
	/**
	 * Static method for creating a TweenMax instance that tweens backwards - you define the BEGINNING values and the current values are used as the destination values which is great for doing things like animating objects onto the screen because you can set them up initially the way you want them to look at the end of the tween and then animate in from elsewhere.
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	vars An object defining the starting value for each property that should be tweened as well as any special properties like onComplete, ease, etc. For example, to tween mc.x from 100 and mc.y from 200 and then call myFunction, do this:TweenMax.from(mc, 1, {x:100, y:200, onComplete:myFunction});
	 * @return TweenMax instance
	 */
	static public function from (target: Dynamic, duration: Float, vars: Dynamic) : TweenMax;
	
	/**
	 * Static method for creating a TweenMax instance that allows you to define both the starting and ending values (as opposed to to() and from() tweens which are based on the target's current values at one end or the other).
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	fromVars An object defining the starting value for each property that should be tweened. For example, to tween mc.xfrom 100 and mc.y from 200, fromVars would look like this: {x:100, y:200}.
	 * @param	toVars An object defining the end value for each property that should be tweened as well as any special properties likeonComplete, ease, etc. For example, to tween mc.x from 0 to 100 and mc.y from 0 to 200 and then call myFunction, do this:TweenMax.fromTo(mc, 1, {x:0, y:0}, {x:100, y:200, onComplete:myFunction});
	 * @return TweenMax instance
	 */
    static public function fromTo(target:Dynamic, duration:Float, fromVars:Dynamic, toVars:Dynamic):TweenMax;
	
	/**
	 * Returns an array containing all tweens (and optionally timelines too, excluding the root timelines).
	 * @param	includeTimelines (default = false) — If true, TimelineLite and TimelineMax instances will also be included.
	 * @return Array of tweens/timelines
	 */
    static public function getAllTweens(?includeTimelines:Bool):Array<Animation>;
	
	/**
	 * Returns an array containing all the tweens of a particular target (or group of targets) that have not been released for garbage collection yet which typically happens within a few seconds after the tween completes.
	 * @param	target The target whose tweens should be returned, or an array of such targets
	 * @param	onlylActive (default = false) — If true, only tweens that are currently active will be returned (a tween is considered "active" if the virtual playhead is actively moving across the tween and it is not paused, nor are any of its ancestor timelines paused).
	 */
    static public function getTweensOf(target:Dynamic, onlyActive:Bool):Void;
	
	/**
	 * Gets or sets the global timeScale which is a multiplier that affects ALL animations equally. This is a great way to globally speed up or slow down all animations at once.
	 * @param	value A multiplier that affects all animations, so 1 is normal speed, 0.5 is half-speed, 2 is double-speed, etc. Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter).
	 */
	static public function globalTimeScale(value:Float):Void;
		
	/**
	 * Reports whether or not a particular object is actively tweening.
	 * @param	target Target object whose tweens you're checking
	 * @return Value indicating whether or not any active tweens were found
	 */
	static public function isTweening(target:Dynamic):Bool;
	
	/**
	 * Kills all tweens and/or delayedCalls/callbacks, and/or timelines, optionally forcing them to completion first.
	 * @param	complete (default = false) — Determines whether or not the tweens/delayedCalls/timelines should be forced to completion before being killed.
	 * @param	tweens (default = true) — If true, all tweens will be killed (TweenLite and TweenMax instances)
	 * @param	delayedCalls (default = true) — If true, all delayedCalls will be killed. TimelineMax callbacks are treated the same as delayedCalls.
	 * @param	timelines (default = true) — If true, all delayedCalls will be killed. TimelineMax callbacks are treated the same as delayedCalls.
	 */
	static public function killAll (?complete:Bool, ?tweens:Bool, ?delayedCalls:Bool, ?timelines:Bool) : Void;
	
	/**
	 * Kills all tweens of the children of a particular DOM element, optionally forcing them to completion first.
	 * @param	parent The parent DOM element whose children's tweens should be killed. Or selector text that gets passed to TweenLite.selector. For example, if ".myClass" is used (and jQuery or similar is used as TweenLite.selector), tweens of the children of any elements with the "myClass" class applied would be killed.
	 * @param	complete (default = false) — If true, the tweens will be forced to completion before being killed.
	 */
	static public function killChildTweensOf(parent:Dynamic, ?complete:Bool):Void;
	
	/**
	 * Immediately kills all of the delayedCalls to a particular function.
	 * @param	func The function for which all delayedCalls should be killed/cancelled.
	 */
	static public function killDelayedCallsTo(func:Void->Void):Void;
	
	/**
	 * Kills all the tweens (or specific tweening properties) of a particular object or the delayedCalls to a particular function.
	 * @param	target Object whose tweens should be killed immediately or selector text to feed the selector engine to find the target(s). You may also pass in an array of targets.
	 * @param	vars (default = null) — To kill only specific properties, use a generic object containing enumerable properties corresponding to the ones that should be killed like {x:true, y:true}. The values assigned to each property don't matter - the sole purpose of the object is for iteration over the named properties (in this case, x and y). If no object (or null) is defined, all matched tweens will be killed in their entirety.
	 */
	static public function killTweensOf(target:Dynamic, ?vars:Dynamic):Void;
	
	/**
	 * Permits you to control what happens when too much time elapses between two ticks (updates) of the engine, adjusting the core timing mechanism to compensate and avoid "jumps".
	 * @param	threshold Amount of lag (in millisecond) after which the engine will adjust the internal clock to act like the adjustedLag elapsed instead. The lower the number, the more likely (and frequently) lagSmoothing() will be triggered. For example, if the threshold is 500 and the adjustedLag is 33 (those are the defaults), the only time an adjustment will occur is when more than 500ms elapses between two ticks in which case it will act as though only 33ms elapsed. So if the CPU bogs down for 2 full seconds (yikes!), your animations will move 33ms worth of time on the next render instead of jumping a full 2-seconds. Note: this has no affect on the device’s performance or true frame rate – this merely affects how GSAP reacts when the browser drops frames.
	 * @param	adjustedLag The new (adjusted) amount of time (in milliseconds) from the previous tick. Typically it is best to set this to at least 16 because that's the normal amount of time between ticks when the engine is running at 60 frames per second. It is more common to set it to at least 33 (which is 2 normal "ticks"). If you set the threshold and the adjustedLag too low, your animations can appear to slow down under heavy pressure. The higher the adjustedLag, the more of a "jump" you'll see when lagSmoothing kicks in.
	 */
	static public function lagSmoothing(threshold:Float, adjustedLag:Float):Void ;
	
	/**
	 * [deprecated] Pauses all tweens and/or delayedCalls/callbacks and/or timelines.
	 * @param	tweens (default = true) — If true, all tweens will be paused.
	 * @param	delayedCalls (default = true) — If true, all delayedCalls will be paused. timeline callbacks are treated the same as delayedCalls.
	 * @param	timelines (default = true) — If true, all TimelineLite and TimelineMax instances will be paused (at least the ones who haven't finished and been removed from their parent timeline)
	 */
	static public function pauseAll(?tweens:Bool, ?delayedCalls:Bool, ?timelines:Bool):Void;
	
	/**
	 * Gets or sets the number of times that the tween should repeat after its first iteration.
	 * @param	value (default = 0) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
	public function repeat(?value:Int):Dynamic;
	
	/**
	 * Gets or sets the amount of time in seconds (or frames for frames-based tweens) between repeats.
	 * @param	value (default = NaN) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
	public function repeatDelay(?value:Float):Dynamic;
	
	/**
	 * [deprecated] Resumes all paused tweens and/or delayedCalls/callbacks and/or timelines.
	 * @param	tweens (default = true) — If true, all tweens will be resumed.
	 * @param	delayedCalls (default = true) — If true, all delayedCalls will be resumed. timeline callbacks are treated the same as delayedCalls.
	 * @param	timelines (default = true) — If true, all TimelineLite and TimelineMax instances will be resumed (at least the ones who haven't finished and been removed from their parent timeline)
	 */
	static public function resumeAll (tweens:Bool,?delayedCalls:Bool,?timelines:Bool):Void;
	
	/**
	 *  Immediately sets properties of the target accordingly - essentially a zero-duration to() tween with a more intuitive name.
	 * @param	target Target object (or array of objects or selector text) whose properties will be affected.
	 * @param	vars An object defining the value for each property that should be set. For example, to set mc.x to 100 and mc.y to 200, do this: TweenMax.set(mc, {x:100, y:200}); You may also define any of the special properties baked into GSAP like delay, onComplete, etc.
	 * @return A TweenMax instance (with a duration of 0) which can optionally be inserted into a TimelineLite/Max instance (although it's typically more concise to just use the timeline's set() method).
	 */
	static public function set( target:Dynamic, vars:Dynamic) : TweenMax;
	
	/**
	 * Tweens an array of targets from a common set of destination values (using the current values as the destination), but staggers their start times by a specified amount of time, creating an evenly-spaced sequence with a surprisingly small amount of code.
	 * @param	targets An array of objects whose properties should be affected. When animating DOM elements, the targets can be: an array of elements, a jQuery object (or similar), or a CSS selector string like “.myClass” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is defined in the vars parameter)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties likeease. For example, to tween x to 100 and y to 200 for mc1, mc2, and mc3, staggering their start time by 0.25 seconds and then call myFunction when they last one has finished, do this: TweenMax.staggerTo([mc1, mc2, mc3], 1, {x:100, y:200}, 0.25, myFunction}).
	 * @param	stagger (default = 0) — Amount of time in seconds (or frames for frames-based tweens) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: TweenMax.staggerTo([mc1, mc2, mc3, mc4, mc5], 1, {y:"+=100", opacity:0}, 0.2).
	 * @param	onCompleteAll (default = null) — A function to call as soon as the entire sequence of tweens has completed
	 * @param	onCompleteAllParams (default = null) — An array of parameters to pass the onCompleteAll method.
	 * @param	onCompleteAllScope (default = null) — The scope in which the onCompleteAll callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only pertains to the JavaScript and AS2 versions; it is omitted in AS3.
	 * @return  An array of TweenMax instances (one for each object in the targets array)
	 */
	static public function staggerFrom(targets:Array<Dynamic>, duration:Float, vars:Dynamic, ?stagger:Float, ?onCompleteAll:Void->Void, ?onCompleteAllParams:Array<Dynamic>, ?onCompleteAllScope:Dynamic):Array<TweenMax>;
	
	/**
	 * Tweens an array of targets from a common set of destination values to a common set of destination values, but staggers their start times by a specified amount of time, creating an evenly-spaced sequence with a surprisingly small amount of code.
	 * @param	targets An array of objects whose properties should be affected. When animating DOM elements, the targets can be: an array of elements, a jQuery object (or similar), or a CSS selector string like “.myClass” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll(
	 * @param	duration Duration in seconds (or frames if useFrames:true is defined in the vars parameter)
	 * @param	fromVars An object defining the starting value for each property that should be tweened. For example, to tween xfrom 100 and y from 200, fromVars would look like this: {x:100, y:200}.
	 * @param	toVars An object defining the end value for each property that should be tweened as well as any special properties likeease. For example, to tween x to 100 and y to 200 for mc1, mc2, and mc3, staggering their start time by 0.25 seconds and then call myFunction when they last one has finished, do this: TweenMax.staggerTo([mc1, mc2, mc3], 1, {x:100, y:200}, 0.25, myFunction}).
	 * @param	stagger (default = 0) — Amount of time in seconds (or frames for frames-based tweens) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: TweenMax.staggerTo([mc1, mc2, mc3, mc4, mc5], 1, {y:"+=100", opacity:0}, 0.2).
	 * @param	onCompleteAll (default = null) — A function to call as soon as the entire sequence of tweens has completed
	 * @param	onCompleteAllParams (default = null) — An array of parameters to pass the onCompleteAll method.
	 * @param	onCompleteAllScope (default = null) — The scope in which the onCompleteAll callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only pertains to the JavaScript and AS2 versions; it is omitted in AS3.
	 * @return An array of TweenMax instances (one for each object in the targets array)
	 */
	static public function staggerFromTo(targets:Array<Dynamic>, duration:Float, fromVars:Dynamic, toVars:Dynamic, ?stagger:Float, ?onCompleteAll:Void->Void, ?onCompleteAllParams:Array<Dynamic>, ?onCompleteAllScope:Dynamic):Array<TweenMax>;
	
	/**
	 * Tweens an array of targets to a common set of destination values, but staggers their start times by a specified amount of time, creating an evenly-spaced sequence with a surprisingly small amount of code.
	 * @param	targets An array of objects whose properties should be affected. When animating DOM elements, the targets can be: an array of elements, a jQuery object (or similar), or a CSS selector string like “.myClass” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll(
	 * @param	duration Duration in seconds (or frames if useFrames:true is defined in the vars parameter)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties likeease. For example, to tween x to 100 and y to 200 for mc1, mc2, and mc3, staggering their start time by 0.25 seconds and then call myFunction when they last one has finished, do this: TweenMax.staggerTo([mc1, mc2, mc3], 1, {x:100, y:200}, 0.25, myFunction}).
	 * @param	stagger (default = 0) — Amount of time in seconds (or frames for frames-based tweens) to stagger the start time of each tween. For example, you might want to have 5 objects move down 100 pixels while fading out, and stagger the start times by 0.2 seconds - you could do: TweenMax.staggerTo([mc1, mc2, mc3, mc4, mc5], 1, {y:"+=100", opacity:0}, 0.2).
	 * @param	onCompleteAll (default = null) — A function to call as soon as the entire sequence of tweens has completed
	 * @param	onCompleteAllParams (default = null) — An array of parameters to pass the onCompleteAll method.
	 * @param	onCompleteAllScope (default = null) — The scope in which the onCompleteAll callback should be called (basically, what "this" refers to in the function). NOTE: this parameter only pertains to the JavaScript and AS2 versions; it is omitted in AS3.
	 * @return An array of TweenMax instances (one for each object in the targets array)
	 */
	static public function staggerTo(targets:Array<Dynamic>, duration:Float, vars:Dynamic, ?stagger:Float, ?onCompleteAll:Void->Void, ?onCompleteAllParams:Array<Dynamic>, ?onCompleteAllScope:Dynamic):Array<Dynamic>;
	
	/**
	 * Static method for creating a TweenMax instance that animates to the specified destination values (from the current values).
	 * @param	target Target object (or array of objects) whose properties should be affected. When animating DOM elements, the target can be: a single element, an array of elements, a jQuery object (or similar), or a CSS selector string like “#feature” or “h2.author”. GSAP will pass selector strings to a selector engine like jQuery or Sizzle (if one is detected or defined through TweenLite.selector), falling back to document.querySelectorAll().
	 * @param	duration Duration in seconds (or frames if useFrames:true is set in the vars parameter)
	 * @param	vars An object defining the end value for each property that should be tweened as well as any special properties likeonComplete, ease, etc. For example, to tween obj.x to 100 and obj.y to 200 and then call myFunction, do this:TweenMax.to(obj, 1, {x:100, y:200, onComplete:myFunction});
	 * @return TweenMax instance
	 */
	static public function to ( target: Dynamic, duration: Float, properties: Dynamic ) : TweenMax;
	
	/**
	 * Updates tweening values on the fly so that they appear to seamlessly change course even if the tween is in-progress.
	 * @param	vars Object containing properties with the destination values that should be udpated. You do NOT need to redefine all of the original vars values - only the ones that should be updated (although if you change a plugin value, you will need to fully define it). For example, to update the destination x value to 300 and the destination y value to 500, pass: {x:300, y:500}.
	 * @param	resetDuration (default = false) — If the tween has already started (or finished) and resetDuration is true, the tween will restart. If resetDuration is false, the tween's timing will be honored (no restart) and each tweening property's starting value will be adjusted so that it appears to seamlessly redirect to the new destination value.
	 * @return self (makes chaining easier)
	 */
	public function updateTo(vars:Dynamic, ?resetDuration:Bool):TweenMax;
	
	/**
	 * Gets or sets the tween's yoyo state, where true causes the tween to go back and forth, alternating backward and forward on each repeat.
	 * @param	value (default = false) — Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 * @return Omitting the parameter returns the current value (getter), whereas defining the parameter sets the value (setter) and returns the instance itself for easier chaining.
	 */
	public function yoyo ( ?value : Bool ) : Dynamic;
	
}
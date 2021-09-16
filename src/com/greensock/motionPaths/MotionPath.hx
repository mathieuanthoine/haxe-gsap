  /**
 * VERSION: 0.6
 * DATE: 2011-08-19
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com
 **/  
package com.greensock.motionPaths;

import flash.display.Shape;
import flash.events.Event;

/**
 * [AS3 only] A MotionPath defines a path along which a PathFollower can travel, making it relatively simple to do 
 * things like tween an object in a circular path. A PathFollower's position along the path is described using
 * its <code>progress</code> property, a value between 0 and 1 where 0 is at the beginning of the path, 0.5 is in
 * the middle, and 1 is at the very end of the path. So to tween a PathFollower along the path, you can simply
 * tween its <code>progress</code> property. To tween ALL of the followers on the path at once, you can
 * tween the MotionPath's <code>progress</code> property. PathFollowers automatically wrap so that if 
 * the <code>progress</code> value exceeds 1 or drops below 0, it shows up on the other end of the path
 *  
 * <p>Since MotionPath extends the Shape class, you can add an instance to the display list to see a line representation
 * of the path drawn which can be helpful especially during the production phase. Use <code>lineStyle()</code> 
 * to adjust the color, thickness, and other attributes of the line that is drawn (or set the MotionPath's 
 * <code>visible</code> property to false or don't add it to the display list if you don't want to see the line 
 * at all). You can also adjust all of its properties like <code>scaleX, scaleY, rotation, width, height, x,</code> 
 * and <code>y</code> just like any DisplayObject. That means you can tween those values as well to achieve very 
 * dynamic, complex effects with ease.</p>
 * 
 * <listing version="3.0">
import com.greensock.~~;
import com.greensock.plugins.~~;
import com.greensock.motionPaths.~~;
TweenPlugin.activate([CirclePath2DPlugin]); //only needed once in your swf, and only if you plan to use the circlePath2D tweening feature for convenience

//create a circle motion path at coordinates x:150, y:150 with a radius of 100
var circle:CirclePath2D = new CirclePath2D(150, 150, 100);

//tween mc along the path from the bottom (90 degrees) to 315 degrees in the counter-clockwise direction and make an extra revolution
TweenLite.to(mc, 3, {circlePath2D:{path:circle, startAngle:90, endAngle:315, autoRotate:true, direction:Direction.COUNTER_CLOCKWISE, extraRevolutions:1}});

//tween the circle's rotation, scaleX, scaleY, x, and y properties:
TweenLite.to(circle, 3, {rotation:180, scaleX:0.5, scaleY:2, x:250, y:200});

//show the path visually by adding it to the display list (optional)
this.addChild(circle);


//--- Instead of using the plugin, you could manually manage followers and tween their "progress" property...
 
//make the MovieClip "mc2" follow the circle and start at a position of 90 degrees (this returns a PathFollower instance)
var follower:PathFollower = circle.addFollower(mc2, circle.angleToProgress(90));

//tween the follower clockwise along the path to 315 degrees
TweenLite.to(follower, 2, {progress:circle.followerTween(follower, 315, Direction.CLOCKWISE)});

//tween the follower counter-clockwise to 200 degrees and add an extra revolution
TweenLite.to(follower, 2, {progress:circle.followerTween(follower, 200, Direction.COUNTER_CLOCKWISE, 1)});
</listing>
 * 
 * <p><strong>NOTES</strong></p>
 * <ul>
 * 		<li>All followers are automatically updated when you alter the MotionPath that they're following.</li>
 * 		<li>To tween all followers along the path at once, simply tween the MotionPath's <code>progress</code> 
 * 			property which will provide better performance than tweening each follower independently.</li>
 * </ul>
 * 
 * <p><strong>Copyright 2010-2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("MotionPath")
#end
extern class MotionPath extends Shape
{
	/**
	 * Identical to <code>progress</code> except that the value is not re-interpolated between 0 and 1.
	 * For example, if you set the motion path's <code>rawProgress</code> to 2.1, <code>progress</code>
	 * would be 0.1 (the corresponding value between 0 and 1), essentially wrapping it. If <code>rawProgress</code>
	 * is set to -3.4, <code>progress</code> would be 0.6. Setting <code>progress</code> affects <code>rawProgress</code>
	 * and vice versa. For example:
	 *
	 * <listing version="3.0">
myPath.progress = 2.1;
trace(myPath.progress); //traces "0.1"
trace(myPath.rawProgress); //traces "2.1"
</listing>
	 *
	 * <p>Either property can be used to move all followers along the path. Unlike a PathFollower's
	 * <code>progress</code> or <code>rawProgress</code>, this value is not absolute for motion paths - it simply
	 * facilitates relative movement of followers together along the path in a way that performs better than
	 * tweening each follower independently (plus it's easier). If your goal is to tween all followers around
	 * a CirclePath2D twice completely, for example, you could just add 2 to the <code>progress</code> or
	 * <code>rawProgress</code> value or use a relative value in the tween, like: </p><p><code>
	 *
	 * TweenLite.to(myCircle, 5, {rawProgress:"2"}); //or myCircle.rawProgress + 2
	 *
	 * </code></p>
	 * @see #progress
	 **/
	public var rawProgress:Float;


	/**
	 * A value between 0 and 1 that can be used to move all followers along the path. <code>progress</code>
	 * is identical to <code>rawProgress</code> except that the <code>rawProgress</code> is not re-interpolated
	 * between 0 and 1. For example, if you set the motion path's <code>rawProgress</code> to 2.1, <code>progress</code>
	 * would be 0.1 (the corresponding value between 0 and 1), essentially wrapping it. If <code>rawProgress</code>
	 * is set to -3.4, <code>progress</code> would be 0.6. You may set <code>progress</code> to any value but it will
	 * be re-interpolated to its corresponding value between 0 and 1 very much like a DisplayObject's "rotation"
	 * property in Flash where setting it to 270 works fine but when you trace() the rotation value it will report
	 * as -90 instead because rotation is always interpolated to be between 180 and -180. Setting <code>progress</code>
	 * affects <code>rawProgress</code> too. For example:
	 *
	 * <listing version="3.0">
myPath.progress = 2.1;
trace(myPath.progress); //traces "0.1"
trace(myPath.rawProgress); //traces "2.1"
</listing>
	 *
	 * <p>Either property can be used to move all followers along the path. Unlike a PathFollower's
	 * <code>progress</code> or <code>rawProgress</code>, this value is not absolute for motion paths - it simply
	 * facilitates movement of followers together along the path in a way that performs better than
	 * tweening each follower independently (plus it's easier). If your goal is to tween all followers around
	 * a CirclePath2D twice completely, you could just add 2 to the <code>progress</code> or
	 * <code>rawProgress</code> value or use a relative value in the tween, like: </p><p><code>
	 *
	 * TweenLite.to(myCircle, 5, {progress:"2"}); //or myCircle.progress + 2</code></p>
	 *
	 * <p>Also note that if you set <code>progress</code> to any value <i>outside</i> of the 0-1 range,
	 * <code>rawProgress</code> will be set to that exact value. If <code>progress</code> is
	 * set to a value <i>within</i> the typical 0-1 range, it will only affect the decimal value of
	 * <code>rawProgress</code>. For example, if <code>rawProgress</code> is 3.4 and then you
	 * set <code>progress</code> to 0.1, <code>rawProgress</code> will end up at 3.1 (notice
	 * the "3" integer was kept). But if <code>progress</code> was instead set to 5.1, since
	 * it exceeds the 0-1 range, <code>rawProgress</code> would become 5.1. This behavior was
	 * adopted in order to deal most effectively with wrapping situations. For example, if
	 * <code>rawProgress</code> was tweened to 3.4 and then later you wanted to fine-tune
	 * where things were positioned by tweening <code>progress</code> to 0.8, it still may be
	 * important to be able to determine how many loops/wraps occurred, so <code>rawProgress</code>
	 * should be 3.8, not reset to 0.8. Feel free to use <code>rawProgress</code> exclusively if you
	 * prefer to avoid any of the re-interpolation that occurs with <code>progress</code>.</p>
	 *
	 * @see #rawProgress
	 **/
	public var progress:Float;

	/** Returns an array of all PathFollower instances associated with this path **/
	public var followers:Array<PathFollower>;

	/** Returns an array of all target instances associated with the PathFollowers of this path **/
	public var targets:Array<Dynamic>;

	/** @private **/
	public function new();

	/**
	 * Adds a follower to the path, optionally setting it to a particular progress position. If
	 * the target isn't a PathFollower instance already, one will be created for it. The target
	 * can be any object that has x and y properties.
	 * 
	 * @param target Any object that has x and y properties that you'd like to follow the path. Existing PathFollower instances are allowed.
	 * @param progress The progress position at which the target should be placed initially (0 by default)
	 * @param autoRotate When <code>autoRotate</code> is <code>true</code>, the target will automatically be rotated so that it is oriented to the angle of the path. To offset this value (like to always add 90 degrees for example), use the <code>rotationOffset</code> property.
	 * @param rotationOffset When <code>autoRotate</code> is <code>true</code>, this value will always be added to the resulting <code>rotation</code> of the target.
	 * @return A PathFollower instance associated with the target (you can tween this PathFollower's <code>progress</code> property to move it along the path).
	 */
	public function addFollower(target:Dynamic, progress:Float = 0, autoRotate:Bool = false, rotationOffset:Float = 0):PathFollower;
	
	/**
	 * Removes the target as a follower. The target can be a PathFollower instance or the target associated
	 * with one of the PathFollower instances.
	 * 
	 * @param target the target or PathFollower instance to remove.
	 */
	public function removeFollower(target:Dynamic):Void;
	
	/** Removes all followers. **/
	public function removeAllFollowers():Void;
	
	/**
	 * Distributes objects evenly along the MotionPath. You can optionally define minimum and maximum 
	 * <code>progress</code> values between which the objects will be distributed. For example, if you want them 
	 * distributed from the very beginning of the path to the middle, you would do:<p><code>
	 * 
	 * path.distribute([mc1, mc2, mc3], 0, 0.5);</code></p>
	 * 
	 * <p>As it loops through the <code>targets</code> array, if a target is found for which a PathFollower
	 * doesn't exist, one will automatically be created and added to the path. The <code>targets</code> 
	 * array can be populated with PathFollowers or DisplayObjects or Points or pretty much any object. </p>
	 * 
	 * @param targets An array of targets (PathFollowers, DisplayObjects, Points, or pretty much any object) that should be distributed evenly along the MotionPath. As it loops through the <code>targets</code> array, if a target is found for which a PathFollower doesn't exist, one will automatically be created and added to the path.
	 * @param min The minimum <code>progress</code> value at which the targets will begin being distributed. This value will always be between 0 and 1. For example, if the targets should be distributed from the midpoint of the path through the end, the <code>min</code> parameter would be 0.5 and the <code>max</code> parameter would be 1.
	 * @param max The maximum <code>progress</code> value where the targets will end distribution. This value will always be between 0 and 1. For example, if the targets should be distributed from the midpoint of the path through the end, the <code>min</code> parameter would be 0.5 and the <code>max</code> parameter would be 1.
	 * @param autoRotate When <code>autoRotate</code> is <code>true</code>, the target will automatically be rotated so that it is oriented to the angle of the path. To offset this value (like to always add 90 degrees for example), use the <code>rotationOffset</code> property.
	 * @param rotationOffset When <code>autoRotate</code> is <code>true</code>, this value will always be added to the resulting <code>rotation</code> of the target. For example, to always add 90 degrees to the autoRotation, <code>rotationOffset</code> would be 90.
	 */
	public function distribute(targets:Array<Dynamic> = null, min:Float = 0, max:Float = 1, autoRotate:Bool = false, rotationOffset:Float = 0):Void;

	/**
	 * Returns the PathFollower instance associated with a particular target or null if none exists.
	 * 
	 * @param target The target whose PathFollower instance you want returned.
	 * @return PathFollower instance
	 */
	public function getFollower(target:Dynamic):PathFollower;
	
	/** 
	 * Forces the MotionPath to re-render itself and all of its followers.
	 * 
	 * @param event An optional Event that is accepted just to make it easier for use as an event handler (to have it update automatically on every frame, for example, you could add an ENTER_FRAME listener and point it to this method).  **/
	public function update(event:Event = null):Void;
	
	/**
	 * Positions any object with x and y properties on the path at a specific progress position. 
	 * For example, to position <code>mc</code> in the middle of the path, you would do:<p><code>
	 * 
	 * myPath.renderObjectAt(mc, 0.5);</code></p>
	 * 
	 * <p>Some paths have methods to translate other meaningful information into a progress value, like
	 * for a <code>CirclePath2D</code> you can get the progress associated with the 90-degree position with the
	 * <code>angleToPosition()</code> method like this:</p><p><code>
	 * 
	 * myCircle.renderObjectAt(mc, myCircle.angleToProgress(90));
	 * 
	 * </code></p>
	 * 
	 * @param target The target object to position
	 * @param progress The progress value (typically between 0 and 1 where 0 is the beginning of the path, 0.5 is in the middle, and 1 is at the end)
	 * @param autoRotate When <code>autoRotate</code> is <code>true</code>, the target will automatically be rotated so that it is oriented to the angle of the path. To offset this value (like to always add 90 degrees for example), use the <code>rotationOffset</code> property.
	 * @param rotationOffset When <code>autoRotate</code> is <code>true</code>, this value will always be added to the resulting <code>rotation</code> of the target.
	 */
	public function renderObjectAt(target:Dynamic, progress:Float, autoRotate:Bool = false, rotationOffset:Float = 0):Void;
	
	/**
	 * Sets the line style for the path which you will only see if you add the path to the display list
	 * with something like addChild() and make sure the visible property is true. For example, to make
	 * a CirclePath2D visible with a red line red that's 3 pixels thick, you could do: 
	 * 
	 * <listing version="3.0">
var myCircle:CirclePath2D = new CirclePath2D(150, 150, 100);
myCircle.lineStyle(3, 0xFF0000);
addChild(myCircle);
</listing>
	 * 
	 * @param thickness line thickness
	 * @param color line color
	 * @param alpha line alpha
	 * @param pixelHinting pixel hinting
	 * @param scaleMode scale mode
	 * @param caps caps
	 * @param joints joints
	 * @param miterLimit miter limit
	 * @param skipRedraw if true, the redraw will be skipped.
	 */
	public function lineStyle(thickness:Float = 1, color:Int = 0x666666, alpha:Float = 1, pixelHinting:Bool = false, scaleMode:String = "none", caps:String = null, joints:String = null, miterLimit:Float = 3, skipRedraw:Bool = false):Void;

}

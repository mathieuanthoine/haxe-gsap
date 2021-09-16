/**
 * VERSION: 0.5
 * DATE: 2012-02-16
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com
 **/
package com.greensock.motionPaths;

import flash.geom.Point;


/**
 * [AS3 only] A LinePath2D defines a path (using as many Points as you want) on which a PathFollower can be 
 * placed and animated. A PathFollower's position along the path is described using the PathFollower's 
 * <code>progress</code> property, a value between 0 and 1 where 0 is at the beginning of the path, 
 * 0.5 is in the middle, and 1 is at the very end. To tween a PathFollower along the path, simply tween its
 * <code>progress</code> property. To tween ALL of the followers on the path at once, you can tween the 
 * LinePath2D's <code>progress</code> property which performs better than tweening every PathFollower's 
 * <code>progress</code> property individually. PathFollowers automatically wrap so that if the 
 * <code>progress</code> value exceeds 1 it continues at the beginning of the path, meaning that tweening
 * its <code>progress</code> from 0 to 2 would have the same effect as tweening it from 0 to 1 twice 
 * (it would appear to loop).
 *  
 * <p>Since LinePath2D extends the Shape class, you can add an instance to the display list to see a line representation
 * of the path drawn which can be particularly helpful during the production phase. Use <code>lineStyle()</code> 
 * to adjust the color, thickness, and other attributes of the line that is drawn (or set the LinePath2D's 
 * <code>visible</code> property to false or don't add it to the display list if you don't want to see the line 
 * at all). You can also adjust all of its properties like <code>scaleX, scaleY, rotation, width, height, x,</code> 
 * and <code>y</code>. That means you can tween those values as well to achieve very dynamic, complex effects 
 * with ease.</p>
 * 
 * <listing version="3.0">
import com.greensock.~~;
import com.greensock.easing.~~;
import com.greensock.motionPaths.~~;
import flash.geom.Point;

//create a LinePath2D with 5 Points
var path:LinePath2D = new LinePath2D([new Point(0, 0), 
  new Point(100, 100), 
  new Point(350, 150),
  new Point(50, 200),
  new Point(550, 400)]);

//add it to the display list so we can see it (you can skip this if you prefer)
addChild(path);

//create an array containing 30 blue squares
var boxes:Array = [];
for (var i:int = 0; i &lt; 30; i++) {
boxes.push(createSquare(10, 0x0000FF));
}

//distribute the blue squares evenly across the entire path and set them to autoRotate
path.distribute(boxes, 0, 1, true);

//put a red square exactly halfway through the 2nd segment
path.addFollower(createSquare(10, 0xFF0000), path.getSegmentProgress(2, 0.5));

//tween all of the squares through the path once (wrapping when they reach the end)
TweenMax.to(path, 20, {progress:1});

//while the squares are animating through the path, tween the path's position and rotation too!
TweenMax.to(path, 3, {rotation:180, x:550, y:400, ease:Back.easeOut, delay:3});

//method for creating squares
function createSquare(size:Number, color:uint=0xFF0000):Shape {
var s:Shape = new Shape();
s.graphics.beginFill(color, 1);
s.graphics.drawRect(-size / 2, -size / 2, size, size);
s.graphics.endFill();
this.addChild(s);
return s;
}
</listing>
 * 
 * <p><strong>NOTES</strong></p>
 * <ul>
 * 		<li>All followers' positions are automatically updated when you alter the MotionPath that they're following.</li>
 * 		<li>To tween all followers along the path at once, simply tween the MotionPath's <code>progress</code> 
 * 			property which will provide better performance than tweening each follower independently.</li>
 * </ul>
 * 
 * <p><strong>Copyright 2010-2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("LinePath2D")
#end
extern class LinePath2D extends MotionPath
{
	public var totalLength:Float;
	public var points:Array<PathPoint>;

	/** If true, the LinePath2D will analyze every Point whenever it renders to see if any Point's x or y value has changed, thus making it possible to tween them dynamically. Setting <code>autoUpdatePoints</code> to <code>true</code> increases the CPU load due to the extra processing, so only set it to <code>true</code> if you plan to change one or more of the Points' position. **/
	public var autoUpdatePoints:Bool;
	
	/**
	 * Constructor
	 * 
	 * @param points An array of Points that define the line
	 * @param x The x coordinate of the origin of the line
	 * @param y The y coordinate of the origin of the line
	 * @param autoUpdatePoints If true, the LinePath2D will analyze every Point whenever it renders to see if any Point's x or y value has changed, thus making it possible to tween them dynamically. Setting <code>autoUpdatePoints</code> to <code>true</code> increases the CPU load due to the extra processing, so only set it to <code>true</code> if you plan to change one or more of the Points' position.
	 */
	public function new(points:Array<Dynamic> = null, x:Float = 0, y:Float = 0, autoUpdatePoints:Bool = false);
	
	/** 
	 * Adds a Point to the end of the current LinePath2D (essentially redefining its end point).
	 * 
	 * @param point A Point describing the local coordinates through which the line should be drawn.
	 **/
	public function appendPoint(point:Point):Void;
	
	/** 
	 * Inserts a Point at a particular index value in the <code>points</code> array, similar to splice() in an array.
	 * For example, if a LinePath2D instance has 3 Points already and you want to insert a new Point right after the
	 * first one, you would do:
	 * <listing version="3.0">
var path:LinePath2D = new LinePath2D([new Point(0, 0), 
	 new Point(100, 50), 
	 new Point(200, 300)]); 
path.insertPoint(new Point(50, 50), 1); 
</listing>
	 * 
	 * @param point A Point describing the local coordinates through which the line should be drawn.
	 * @param index The index value in the <code>points</code> array at which the Point should be inserted.
	 **/
	public function insertPoint(point:Point, index:Int = 0):Void;
	

	/**
	 * Appends multiple Points to the end of the <code>points</code> array. Identical to 
	 * the <code>appendPoint()</code> method, but accepts an array of Points instead of just one.
	 * 
	 * @param points An array of Points to append.
	 */
	public function appendMultiplePoints(points:Array<Dynamic>):Void;
	
	/**
	 * Inserts multiple Points into the <code>points</code> array at a particular index/position.
	 * Identical to the <code>insertPoint()</code> method, but accepts an array of points instead of just one.
	 * 
	 * @param points An array of Points to insert.
	 * @param index The index value in the <code>points</code> array at which the Points should be inserted.
	 */
	public function insertMultiplePoints(points:Array<Dynamic>, index:Int = 0):Void;
	
	/**
	 * Removes a particular Point instance from the <code>points</code> array.
	 * 
	 * @param point The Point object to remove from the <code>points</code> array.
	 */
	public function removePoint(point:Point):Void;
	
	/**
	 * Removes the Point that resides at a particular index/position in the <code>points</code> array. 
	 * Just like in arrays, the index is zero-based. For example, to remove the second Point in the array, 
	 * do <code>removePointByIndex(1)</code>;
	 * 
	 * @param index The index value of the Point that should be removed from the <code>points</code> array.
	 */
	public function removePointByIndex(index:Int):Void;

	/**
	 * Translates the progress along a particular segment of the LinePath2D to an overall <code>progress</code>
	 * value, making it easy to position an object like "halfway along the 2nd segment of the line". For example:
	 * <p><code>
	 * 
	 * path.addFollower(mc, path.getSegmentProgress(2, 0.5));
	 * 
	 * </code></p>
	 * 
	 * @param segment The segment number of the line. For example, a line defined by 3 Points would have two segments.
	 * @param progress The <code>progress</code> along the segment. For example, the midpoint of the second segment would be <code>getSegmentProgress(2, 0.5);</code>.
	 * @return The progress value (between 0 and 1) describing the overall progress on the entire LinePath2D.
	 */
	public function getSegmentProgress(segment:Int, progress:Float):Float;
	
	/**
	 * Finds the segment associated with a particular a progress value along the entire LinePath2D.
	 * For example, to find which segment is halfway along the LinePath2D:
	 * 
	 * <p><code>
	 * path.getSegment(0.5);
	 * </code></p>
	 * 
	 * <p>To find the segment associated with the LinePath2D's current <code>progress</code>, simply omit the 
	 * <code>progress</code> parameter:</p>
	 * 
	 * <p><code>
	 * var curSegment = path.getSegment();
	 * </code></p>
	 * 
	 * @param progress The <code>progress</code> along the entire LinePath2D (a value between 0 and 1). For example, the midpoint would be <code>getSegment(0.5);</code>.
	 * @return An integer describing the segment number where the first is 1, second is 2, etc.
	 */
	public function getSegment(progress:Float = null):Int;
	
	/**
	 * Allows you to snap an object like a Sprite, Point, MovieClip, etc. to the LinePath2D by determining
	 * the closest position along the line to the current position of the object. It will automatically
	 * create a PathFollower instance for the target object and reposition it on the LinePath2D. 
	 * 
	 * @param target The target object that should be repositioned onto the LinePath2D.
	 * @param autoRotate When <code>autoRotate</code> is <code>true</code>, the follower will automatically be rotated so that it is oriented to the angle of the path that it is following. To offset this value (like to always add 90 degrees for example), use the <code>rotationOffset</code> property.
	 * @param rotationOffset When <code>autoRotate</code> is <code>true</code>, this value will always be added to the resulting <code>rotation</code> of the target.
	 * @return A PathFollower instance that was created for the target.
	 */
	public function snap(target:Dynamic, autoRotate:Bool = false, rotationOffset:Float = 0):PathFollower;
	
	/**
	 * Finds the closest overall <code>progress</code> value on the LinePath2D based on the 
	 * target object's current position (<code>x</code> and <code>y</code> properties). For example,
	 * to position the mc object on the LinePath2D at the spot that's closest to the Point x:100, y:50, 
	 * you could do:<p><code>
	 * 
	 * path.addFollower(mc, path.getClosestProgress(new Point(100, 50)));
	 * 
	 * </code></p>
	 * 
	 * @param target The target object whose position (x/y property values) are analyzed for proximity to the LinePath2D.
	 * @return The overall <code>progress</code> value describing the position on the LinePath2D that is closest to the target's current position.
	 */
	public function getClosestProgress(target:Dynamic):Float;
}


#if (js)
@:native("PathPoint")
#end
extern class PathPoint {
	public var x:Float;
	public var y:Float;
	public var progress:Float;
	public var xChange:Float;
	public var yChange:Float;
	public var point:Point;
	public var length:Float;
	public var angle:Float;
	
	public var next:PathPoint;
	
	@:allow(com.greensock.motionPaths)
	private function new(point:Point);
}
/**
 * VERSION: 0.4 (beta)
 * DATE: 2011-09-12
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com
 **/
package com.greensock.motionPaths;

/**
 * [AS3 only] A RectanglePath2D defines a rectangular path on which a PathFollower can be placed, making it simple to tween objects
 * along a rectangle's perimeter. A PathFollower's position along the path is described using its <code>progress</code> property, 
 * a value between 0 and 1 where 0 is at the beginning of the path (top left corner), and as the value increases, it
 * moves clockwise along the path so that 0.5 would be at the lower right corner, and 1 is all the way back at the 
 * upper left corner of the path. So to tween a PathFollower along the path, you can simply tween its
 * <code>progress</code> property. To tween ALL of the followers on the path at once, you can tween the 
 * RectanglePath2D's <code>progress</code> property. PathFollowers automatically wrap so that if the <code>progress</code> 
 * value exceeds 1 it continues at the beginning of the path.
 *  
 * <p>Since RectanglePath2D extends the Shape class, you can add an instance to the display list to see a line representation
 * of the path drawn which can be helpful especially during the production phase. Use <code>lineStyle()</code> 
 * to adjust the color, thickness, and other attributes of the line that is drawn (or set the RectanglePath2D's 
 * <code>visible</code> property to false or don't add it to the display list if you don't want to see the line 
 * at all). You can also adjust all of its properties like <code>scaleX, scaleY, rotation, width, height, x,</code> 
 * and <code>y</code>. That means you can tween those values as well to achieve very dynamic, complex effects 
 * with ease.</p>
 * 
 * <listing version="3.0">
import com.greensock.~~;
import com.greensock.motionPaths.~~;

//create a rectangular motion path at coordinates x:25, y:25 with a width of 150 and a height of 100
var rect:RectanglePath2D = new RectanglePath2D(25, 25, 150, 100, false);

//position the MovieClip "mc" at the beginning of the path (upper left corner), and reference the resulting PathFollower instance with a "follower" variable.
var follower:PathFollower = rect.addFollower(mc, 0);

//tween the follower clockwise along the path all the way to the end, one full revolution
TweenLite.to(follower, 2, {progress:1});

//tween the follower counter-clockwise by using a negative progress value
TweenLite.to(follower, 2, {progress:-1});
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
@:native("RectanglePath2D")
#end
extern class RectanglePath2D extends MotionPath
{
	/** width of the rectangle in its unrotated, unscaled state (does not factor in any transformations like scaleX/scaleY/rotation) **/
	public var rawWidth:Float;

	/** height of the rectangle in its unrotated, unscaled state (does not factor in any transformations like scaleX/scaleY/rotation) **/
	public var rawHeight:Float;

	/** If <code>true</code>, the origin (registration point) of the RectanglePath2D will be in its center rather than its upper left corner. **/
	public var centerOrigin:Bool;

	/**
	 * Constructor
	 * 
	 * @param x The x coordinate of the origin of the rectangle (typically its top left corner unless <code>centerOrigin</code> is <code>true</code>)
	 * @param y The y coordinate of the origin of the rectangle (typically its top left corner unless <code>centerOrigin</code> is <code>true</code>)
	 * @param rawWidth The width of the rectangle in its unrotated and unscaled state
	 * @param rawHeight The height of the rectangle in its unrotated and unscaled state
	 * @param centerOrigin To position the origin (registration point around which transformations occur) at the center of the rectangle instead of its upper left corner, set <code>centerOrigin</code> to <code>true</code> (it is false by default).
	 */
	public function new(x:Float, y:Float, rawWidth:Float, rawHeight:Float, centerOrigin:Bool = false);
}

/**
 * VERSION: 1.938
 * DATE: 2013-07-16
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading;

import com.greensock.loading.core.LoaderItem;
import flash.display.Sprite;
import flash.events.Event;
import flash.media.SoundTransform;
import flash.media.Video;
import flash.net.NetStream;
import haxe.Constraints.Function;

/**
 * Loads an FLV, F4V, or MP4 video file using a NetStream and also provides convenient playback methods 
 * and properties like <code>pauseVideo(), playVideo(), gotoVideoTime(), bufferProgress, playProgress, volume, 
 * duration, videoPaused, metaData, </code> and <code>videoTime</code>. Just like ImageLoader and SWFLoader, 
 * VideoLoader's <code>content</code> property refers to a <code>ContentDisplay</code> object (Sprite) that 
 * gets created immediately so that you can position/scale/rotate it or add ROLL_OVER/ROLL_OUT/CLICK listeners
 * before (or while) the video loads. Use the VideoLoader's <code>content</code> property to get the ContentDisplay 
 * Sprite, or use the <code>rawContent</code> property to get the <code>Video</code> object that is used inside the 
 * ContentDisplay to display the video. If a <code>container</code> is defined in the <code>vars</code> object, 
 * the ContentDisplay will immediately be added to that container).
 * 
 * <p>You don't need to worry about creating a NetConnection, a Video object, attaching the NetStream, or any 
 * of the typical hassles. VideoLoader can even scale the video into the area you specify using scaleModes 
 * like <code>"stretch", "proportionalInside", "proportionalOutside",</code> and more. A VideoLoader will 
 * dispatch useful events like <code>VIDEO_COMPLETE, VIDEO_PAUSE, VIDEO_PLAY, VIDEO_BUFFER_FULL, 
 * VIDEO_BUFFER_EMPTY, NET_STATUS, VIDEO_CUE_POINT</code>, and <code>PLAY_PROGRESS</code> in addition 
 * to the typical loader events, making it easy to hook up your own control interface. It packs a 
 * surprising amount of functionality into a very small amount of kb.</p>
 * 
 * <p><strong>OPTIONAL VARS PROPERTIES</strong></p>
 * <p>The following special properties can be passed into the VideoLoader constructor via its <code>vars</code> 
 * parameter which can be either a generic object or a <code><a href="data/VideoLoaderVars.html">VideoLoaderVars</a></code> object:</p>
 * <ul>
 * 		<li><strong> name : String</strong> - A name that is used to identify the VideoLoader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".</li>
 * 		<li><strong> bufferTime : Number</strong> - The amount of time (in seconds) that should be buffered before the video can begin playing (set <code>autoPlay</code> to <code>false</code> to pause the video initially).</li>
 * 		<li><strong> autoPlay : Boolean</strong> - By default, the video will begin playing as soon as it has been adequately buffered, but to prevent it from playing initially, set <code>autoPlay</code> to <code>false</code>.</li>
 * 		<li><strong> smoothing : Boolean</strong> - When <code>smoothing</code> is <code>true</code> (the default), smoothing will be enabled for the video which typically leads to better scaling results.</li>
 * 		<li><strong> container : DisplayObjectContainer</strong> - A DisplayObjectContainer into which the <code>ContentDisplay</code> should be added immediately.</li>
 * 		<li><strong> width : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>width</code> property (applied before rotation, scaleX, and scaleY).</li>
 * 		<li><strong> height : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>height</code> property (applied before rotation, scaleX, and scaleY).</li>
 * 		<li><strong> centerRegistration : Boolean </strong> - if <code>true</code>, the registration point will be placed in the center of the <code>ContentDisplay</code> which can be useful if, for example, you want to animate its scale and have it grow/shrink from its center.</li>
 * 		<li><strong> scaleMode : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>scaleMode</code> controls how the video will be scaled to fit the area. The following values are recognized (you may use the <code>com.greensock.layout.ScaleMode</code> constants if you prefer):
 * 			<ul>
 * 				<li><code>"stretch"</code> (the default) - The video will fill the width/height exactly.</li>
 * 				<li><code>"proportionalInside"</code> - The video will be scaled proportionally to fit inside the area defined by the width/height</li>
 * 				<li><code>"proportionalOutside"</code> - The video will be scaled proportionally to completely fill the area, allowing portions of it to exceed the bounds defined by the width/height.</li>
 * 				<li><code>"widthOnly"</code> - Only the width of the video will be adjusted to fit.</li>
 * 				<li><code>"heightOnly"</code> - Only the height of the video will be adjusted to fit.</li>
 * 				<li><code>"none"</code> - No scaling of the video will occur.</li>
 * 			</ul></li>
 * 		<li><strong> hAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>hAlign</code> determines how the video is horizontally aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
 * 			<ul>
 * 				<li><code>"center"</code> (the default) - The video will be centered horizontally in the area</li>
 * 				<li><code>"left"</code> - The video will be aligned with the left side of the area</li>
 * 				<li><code>"right"</code> - The video will be aligned with the right side of the area</li>
 * 			</ul></li>
 * 		<li><strong> vAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>vAlign</code> determines how the video is vertically aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
 * 			<ul>
 * 				<li><code>"center"</code> (the default) - The video will be centered vertically in the area</li>
 * 				<li><code>"top"</code> - The video will be aligned with the top of the area</li>
 * 				<li><code>"bottom"</code> - The video will be aligned with the bottom of the area</li>
 * 			</ul></li>
 * 		<li><strong> crop : Boolean</strong> - When a <code>width</code> and <code>height</code> are defined, setting <code>crop</code> to <code>true</code> will cause the video to be cropped within that area (by applying a <code>scrollRect</code> for maximum performance). This is typically useful when the <code>scaleMode</code> is <code>"proportionalOutside"</code> or <code>"none"</code> so that any parts of the video that exceed the dimensions defined by <code>width</code> and <code>height</code> are visually chopped off. Use the <code>hAlign</code> and <code>vAlign</code> special properties to control the vertical and horizontal alignment within the cropped area.</li>
 * 		<li><strong> x : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>x</code> property (for positioning on the stage).</li>
 * 		<li><strong> y : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>y</code> property (for positioning on the stage).</li>
 * 		<li><strong> scaleX : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleX</code> property.</li>
 * 		<li><strong> scaleY : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleY</code> property.</li>
 * 		<li><strong> rotation : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>rotation</code> property.</li>
 * 		<li><strong> alpha : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>alpha</code> property.</li>
 * 		<li><strong> visible : Boolean</strong> - Sets the <code>ContentDisplay</code>'s <code>visible</code> property.</li>
 * 		<li><strong> blendMode : String</strong> - Sets the <code>ContentDisplay</code>'s <code>blendMode</code> property.</li>
 * 		<li><strong> bgColor : uint </strong> - When a <code>width</code> and <code>height</code> are defined, a rectangle will be drawn inside the <code>ContentDisplay</code> immediately in order to ease the development process. It is transparent by default, but you may define a <code>bgAlpha</code> if you prefer.</li>
 * 		<li><strong> bgAlpha : Number </strong> - Controls the alpha of the rectangle that is drawn when a <code>width</code> and <code>height</code> are defined.</li>
 * 		<li><strong> volume : Number</strong> - A value between 0 and 1 indicating the volume at which the video should play (default is 1).</li>
 * 		<li><strong> repeat : int</strong> - Number of times that the video should repeat. To repeat indefinitely, use -1. Default is 0.</li>
 * 		<li><strong> stageVideo : StageVideo</strong> - By default, the NetStream gets attached to a <code>Video</code> object, but if you want to use StageVideo in Flash, you can define the <code>stageVideo</code> property and VideoLoader will attach its NetStream to that StageVideo instance instead of the regular Video instance (which is the <code>rawContent</code>). Please read Adobe's docs regarding StageVideo to understand the benefits, tradeoffs and limitations.</li>
 * 		<li><strong> checkPolicyFile : Boolean</strong> - If <code>true</code>, the VideoLoader will check for a crossdomain.xml file on the remote host (only useful when loading videos from other domains - see Adobe's docs for details about NetStream's <code>checkPolicyFile</code> property). </li>
 * 		<li><strong> estimatedDuration : Number</strong> - Estimated duration of the video in seconds. VideoLoader will only use this value until it receives the necessary metaData from the video in order to accurately determine the video's duration. You do not need to specify an <code>estimatedDuration</code>, but doing so can help make the playProgress and some other values more accurate (until the metaData has loaded). It can also make the <code>progress/bytesLoaded/bytesTotal</code> more accurate when a <code>estimatedDuration</code> is defined, particularly in <code>bufferMode</code>.</li>
 * 		<li><strong> deblocking : int</strong> - Indicates the type of filter applied to decoded video as part of post-processing. The default value is 0, which lets the video compressor apply a deblocking filter as needed. See Adobe's <code>flash.media.Video</code> class docs for details.</li>
 * 		<li><strong> bufferMode : Boolean </strong> - When <code>true</code>, the loader will report its progress only in terms of the video's buffer which can be very convenient if, for example, you want to display loading progress for the video's buffer or tuck it into a LoaderMax with other loaders and allow the LoaderMax to dispatch its <code>COMPLETE</code> event when the buffer is full instead of waiting for the whole file to download. When <code>bufferMode</code> is <code>true</code>, the VideoLoader will dispatch its <code>COMPLETE</code> event when the buffer is full as opposed to waiting for the entire video to load. You can toggle the <code>bufferMode</code> anytime. Please read the full <code>bufferMode</code> property ASDoc description below for details about how it affects things like <code>bytesTotal</code>.</li>
 * 		<li><strong> autoAdjustBuffer : Boolean </strong> If the buffer becomes empty during playback and <code>autoAdjustBuffer</code> is <code>true</code> (the default), it will automatically attempt to adjust the NetStream's <code>bufferTime</code> based on the rate at which the video has been loading, estimating what it needs to be in order to play the rest of the video without emptying the buffer again. This can prevent the annoying problem of video playback start/stopping/starting/stopping on a system tht doesn't have enough bandwidth to adequately buffer the video. You may also set the <code>bufferTime</code> in the constructor's <code>vars</code> parameter to set the initial value.</li>
 * 		<li><strong> autoDetachNetStream : Boolean</strong> - If <code>true</code>, the NetStream will only be attached to the Video object (the <code>rawContent</code>) when it is in the display list (on the stage). This conserves memory but it can cause a very brief rendering delay when the content is initially added to the stage (often imperceptible). Also, if you add it to the stage when the <code>videoTime</code> is <i>after</i> its last encoded keyframe, it will render at that last keyframe.</li>
 * 		<li><strong> alternateURL : String</strong> - If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).</li>
 * 		<li><strong> noCache : Boolean</strong> - If <code>noCache</code> is <code>true</code>, a "gsCacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>getLoader()</code> or <code>getContent()</code> by url and when you're running locally)</li>
 * 		<li><strong> estimatedBytes : uint</strong> - Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader will be inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).</li>
 * 		<li><strong> requireWithRoot : DisplayObject</strong> - LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this VideoLoader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>var loader:VideoLoader = new VideoLoader("myScript.php", {name:"textData", requireWithRoot:this.root});</code></li>
 * 		<li><strong> allowMalformedURL : Boolean</strong> - Normally, the URL will be parsed and any variables in the query string (like "?name=test&amp;state=il&amp;gender=m") will be placed into a URLVariables object which is added to the URLRequest. This avoids a few bugs in Flash, but if you need to keep the entire URL intact (no parsing into URLVariables), set <code>allowMalformedURL:true</code>. For example, if your URL has duplicate variables in the query string like <code>http://www.greensock.com/?c=S&amp;c=SE&amp;c=SW</code>, it is technically considered a malformed URL and a URLVariables object can't properly contain all the duplicates, so in this case you'd want to set <code>allowMalformedURL</code> to <code>true</code>.</li>
 * 		<li><strong> autoDispose : Boolean</strong> - When <code>autoDispose</code> is <code>true</code>, the loader will be disposed immediately after it completes (it calls the <code>dispose()</code> method internally after dispatching its <code>COMPLETE</code> event). This will remove any listeners that were defined in the vars object (like onComplete, onProgress, onError, onInit). Once a loader is disposed, it can no longer be found with <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> - it is essentially destroyed but its content is not unloaded (you must call <code>unload()</code> or <code>dispose(true)</code> to unload its content). The default <code>autoDispose</code> value is <code>false</code>.
 * 		
 * 		<p>----EVENT HANDLER SHORTCUTS----</p></li>
 * 		<li><strong> onOpen : Function</strong> - A handler function for <code>LoaderEvent.OPEN</code> events which are dispatched when the loader begins loading. Make sure your onOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onInit : Function</strong> - A handler function for <code>Event.INIT</code> events which will be called when the video's metaData has been received and the video is placed into the <code>ContentDisplay</code>. The <code>INIT</code> event can be dispatched more than once if the NetStream receives metaData more than once (which occasionally happens, particularly with F4V files - the first time often doesn't include the cuePoints). Make sure your <code>onInit</code> function accepts a single parameter of type <code>Event</code> (flash.events.Event).</li>
 * 		<li><strong> onProgress : Function</strong> - A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.</li>
 * 		<li><strong> onComplete : Function</strong> - A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onCancel : Function</strong> - A handler function for <code>LoaderEvent.CANCEL</code> events which are dispatched when loading is aborted due to either a failure or because another loader was prioritized or <code>cancel()</code> was manually called. Make sure your onCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onError : Function</strong> - A handler function for <code>LoaderEvent.ERROR</code> events which are dispatched whenever the loader experiences an error (typically an IO_ERROR). An error doesn't necessarily mean the loader failed, however - to listen for when a loader fails, use the <code>onFail</code> special property. Make sure your onError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onFail : Function</strong> - A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onIOError : Function</strong> - A handler function for <code>LoaderEvent.IO_ERROR</code> events which will also call the onError handler, so you can use that as more of a catch-all whereas <code>onIOError</code> is specifically for LoaderEvent.IO_ERROR events. Make sure your onIOError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * </ul>
 * 
 * <p><strong>Note:</strong> Using a <code><a href="data/VideoLoaderVars.html">VideoLoaderVars</a></code> instance 
 * instead of a generic object to define your <code>vars</code> is a bit more verbose but provides 
 * code hinting and improved debugging because it enforces strict data typing. Use whichever one you prefer.</p>
 * 
 * <p><strong>Note:</strong> To avoid garbage collection issues in the Flash player, the <code>netStream</code> 
 * object that VideoLoader employs must get recreated internally anytime the VideoLoader is unloaded or its loading 
 * is cancelled, so if you need to directly access the <code>netStream</code>, it is best to do so <strong>after</strong>
 * the <code>COMPLETE</code> event has been dispatched. Otherwise, if you store a reference to the VideoLoader's 
 * <code>netStream</code> before or during a load and it gets cancelled or unloaded for some reason, it won't reference 
 * the one that was used to load the video.</p>
 * 
 * <p><strong>Note:</strong> There is a bug/inconsistency in Adobe's NetStream class that causes relative URLs 
 * to use the swf's location as the base path instead of the HTML page's location like all other loaders. Therefore,
 * it would be wise to use the "base" attribute of the &lt;OBJECT&gt; and &lt;EMBED&gt; tags in the HTML to 
 * make sure all relative paths are consistent. See <a href="http://kb2.adobe.com/cps/041/tn_04157.html" target="_blank">http://kb2.adobe.com/cps/041/tn_04157.html</a>
 * for details.</p>
 * 
 * <p><strong>Note:</strong> In order to minimize memory usage, VideoLoader doesn't attach the NetStream to its Video
 * object (the <code>rawContent</code>) until it is added to the display list. Therefore, if your VideoLoader's content
 * isn't somewhere on the stage, the NetStream's visual content won't be fully decoded into memory (that's a good thing). 
 * The only time this could be of consequence is if you are trying to do a BitmapData.draw() of the VideoLoader's content 
 * or rawContent when it isn't on the stage. In that case, you'd just need to attach the NetStream manually before doing 
 * your BitmapData.draw() like <code>myVideoLoader.rawContent.attachNetStream(myVideoLoader.netStream)</code>. </p>
 * 
 * Example AS3 code:<listing version="3.0">
 import com.greensock.loading.~~;
 import com.greensock.loading.display.~~;
 import com.greensock.~~;
 import com.greensock.events.LoaderEvent;
 
//create a VideoLoader
var video:VideoLoader = new VideoLoader("assets/video.flv", {name:"myVideo", container:this, width:400, height:300, scaleMode:"proportionalInside", bgColor:0x000000, autoPlay:false, volume:0, requireWithRoot:this.root, estimatedBytes:75000});

//start loading
video.load();
 
//add a CLICK listener to a button that causes the video to toggle its paused state.
button.addEventListener(MouseEvent.CLICK, togglePause);
function togglePause(event:MouseEvent):void {
    video.videoPaused = !video.videoPaused;
}

//or you could put the VideoLoader into a LoaderMax queue. Create one first...
var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});

//append the VideoLoader and several other loaders
queue.append( video );
queue.append( new DataLoader("assets/data.txt", {name:"myText"}) );
queue.append( new ImageLoader("assets/image1.png", {name:"myImage", estimatedBytes:3500}) );

//start loading the LoaderMax queue
queue.load();

function progressHandler(event:LoaderEvent):void {
trace("progress: " + event.target.progress);
}

function completeHandler(event:LoaderEvent):void {
//play the video
video.playVideo();

//tween the volume up to 1 over the course of 2 seconds.
TweenLite.to(video, 2, {volume:1});
}

function errorHandler(event:LoaderEvent):void {
trace("error occured with " + event.target + ": " + event.text);
}
 </listing>
 * 
 * <p><strong>Copyright 2010-2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @see com.greensock.loading.data.VideoLoaderVars
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("VideoLoader")
#end
extern class VideoLoader extends LoaderItem
{
	public var rawContent:Video;
	public var netStream:NetStream;
	public var videoPaused:Bool;
	public var bufferProgress:Float;
	public var playProgress:Float;
	public var volume:Float;
	public var soundTransform:SoundTransform;
	public var videoTime:Float;
	public var duration:Float;
	public var bufferMode:Bool;
	public var autoDetachNetStream:Bool;
	public var stageVideo:Dynamic;

	/** Event type constant for when the video completes. **/
	public static inline var VIDEO_COMPLETE:String = "videoComplete";
	/** Event type constant for when the video's buffer is full. **/
	public static inline var VIDEO_BUFFER_FULL:String = "videoBufferFull";
	/** Event type constant for when the video's buffer is empty. **/
	public static inline var VIDEO_BUFFER_EMPTY:String = "videoBufferEmpty";
	/** Event type constant for when the video is paused. **/
	public static inline var VIDEO_PAUSE:String = "videoPause";
	/** Event type constant for when the video begins or resumes playing. If the buffer isn't full yet when VIDEO_PLAY is dispatched, the video will wait to visually begin playing until the buffer is full. So VIDEO_PLAY indicates when the NetStream received an instruction to play, not necessarily when it visually begins playing. **/
	public static inline var VIDEO_PLAY:String = "videoPlay";
	/** Event type constant for when the video reaches a cue point in the playback of the NetStream. **/
	public static inline var VIDEO_CUE_POINT:String = "videoCuePoint";
	/** Event type constant for when the playback progresses (only dispatched when the video is playing). **/
	public static inline var PLAY_PROGRESS:String = "playProgress";

	/** The metaData that was received from the video (contains information about its width, height, frame rate, etc.). See Adobe's docs for information about a NetStream's onMetaData callback. **/
	public var metaData:Dynamic;
	/** If the buffer becomes empty during playback and <code>autoAdjustBuffer</code> is <code>true</code> (the default), it will automatically attempt to adjust the NetStream's <code>bufferTime</code> based on the rate at which the video has been loading, estimating what it needs to be in order to play the rest of the video without emptying the buffer again. This can prevent the annoying problem of video playback start/stopping/starting/stopping on a system tht doesn't have enough bandwidth to adequately buffer the video. You may also set the <code>bufferTime</code> in the constructor's <code>vars</code> parameter to set the initial value. **/
	public var autoAdjustBuffer:Bool;
	
	/**
	 * Constructor
	 * 
	 * @param urlOrRequest The url (<code>String</code>) or <code>URLRequest</code> from which the loader should get its content.
	 * @param vars An object containing optional configuration details. For example: <code>new VideoLoader("video/video.flv", {name:"myVideo", onComplete:completeHandler, onProgress:progressHandler})</code>.
	 * 
	 * <p>The following special properties can be passed into the constructor via the <code>vars</code> parameter
	 * which can be either a generic object or a <code><a href="data/VideoLoaderVars.html">VideoLoaderVars</a></code> object:</p>
	 * <ul>
	 * 		<li><strong> name : String</strong> - A name that is used to identify the VideoLoader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".</li>
	 * 		<li><strong> bufferTime : Number</strong> - The amount of time (in seconds) that should be buffered before the video can begin playing (set <code>autoPlay</code> to <code>false</code> to pause the video initially).</li>
	 * 		<li><strong> autoPlay : Boolean</strong> - By default, the video will begin playing as soon as it has been adequately buffered, but to prevent it from playing initially, set <code>autoPlay</code> to <code>false</code>.</li>
	 * 		<li><strong> smoothing : Boolean</strong> - When <code>smoothing</code> is <code>true</code> (the default), smoothing will be enabled for the video which typically leads to better scaling results.</li>
	 * 		<li><strong> container : DisplayObjectContainer</strong> - A DisplayObjectContainer into which the <code>ContentDisplay</code> should be added immediately.</li>
	 * 		<li><strong> width : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>width</code> property (applied before rotation, scaleX, and scaleY).</li>
	 * 		<li><strong> height : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>height</code> property (applied before rotation, scaleX, and scaleY).</li>
	 * 		<li><strong> centerRegistration : Boolean </strong> - if <code>true</code>, the registration point will be placed in the center of the <code>ContentDisplay</code> which can be useful if, for example, you want to animate its scale and have it grow/shrink from its center.</li>
	 * 		<li><strong> scaleMode : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>scaleMode</code> controls how the video will be scaled to fit the area. The following values are recognized (you may use the <code>com.greensock.layout.ScaleMode</code> constants if you prefer):
	 * 			<ul>
	 * 				<li><code>"stretch"</code> (the default) - The video will fill the width/height exactly.</li>
	 * 				<li><code>"proportionalInside"</code> - The video will be scaled proportionally to fit inside the area defined by the width/height</li>
	 * 				<li><code>"proportionalOutside"</code> - The video will be scaled proportionally to completely fill the area, allowing portions of it to exceed the bounds defined by the width/height.</li>
	 * 				<li><code>"widthOnly"</code> - Only the width of the video will be adjusted to fit.</li>
	 * 				<li><code>"heightOnly"</code> - Only the height of the video will be adjusted to fit.</li>
	 * 				<li><code>"none"</code> - No scaling of the video will occur.</li>
	 * 			</ul></li>
	 * 		<li><strong> hAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>hAlign</code> determines how the video is horizontally aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
	 * 			<ul>
	 * 				<li><code>"center"</code> (the default) - The video will be centered horizontally in the area</li>
	 * 				<li><code>"left"</code> - The video will be aligned with the left side of the area</li>
	 * 				<li><code>"right"</code> - The video will be aligned with the right side of the area</li>
	 * 			</ul></li>
	 * 		<li><strong> vAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>vAlign</code> determines how the video is vertically aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
	 * 			<ul>
	 * 				<li><code>"center"</code> (the default) - The video will be centered vertically in the area</li>
	 * 				<li><code>"top"</code> - The video will be aligned with the top of the area</li>
	 * 				<li><code>"bottom"</code> - The video will be aligned with the bottom of the area</li>
	 * 			</ul></li>
	 * 		<li><strong> crop : Boolean</strong> - When a <code>width</code> and <code>height</code> are defined, setting <code>crop</code> to <code>true</code> will cause the video to be cropped within that area (by applying a <code>scrollRect</code> for maximum performance). This is typically useful when the <code>scaleMode</code> is <code>"proportionalOutside"</code> or <code>"none"</code> so that any parts of the video that exceed the dimensions defined by <code>width</code> and <code>height</code> are visually chopped off. Use the <code>hAlign</code> and <code>vAlign</code> special properties to control the vertical and horizontal alignment within the cropped area.</li>
	 * 		<li><strong> x : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>x</code> property (for positioning on the stage).</li>
	 * 		<li><strong> y : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>y</code> property (for positioning on the stage).</li>
	 * 		<li><strong> scaleX : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleX</code> property.</li>
	 * 		<li><strong> scaleY : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleY</code> property.</li>
	 * 		<li><strong> rotation : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>rotation</code> property.</li>
	 * 		<li><strong> alpha : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>alpha</code> property.</li>
	 * 		<li><strong> visible : Boolean</strong> - Sets the <code>ContentDisplay</code>'s <code>visible</code> property.</li>
	 * 		<li><strong> blendMode : String</strong> - Sets the <code>ContentDisplay</code>'s <code>blendMode</code> property.</li>
	 * 		<li><strong> bgColor : uint </strong> - When a <code>width</code> and <code>height</code> are defined, a rectangle will be drawn inside the <code>ContentDisplay</code> immediately in order to ease the development process. It is transparent by default, but you may define a <code>bgAlpha</code> if you prefer.</li>
	 * 		<li><strong> bgAlpha : Number </strong> - Controls the alpha of the rectangle that is drawn when a <code>width</code> and <code>height</code> are defined.</li>
	 * 		<li><strong> volume : Number</strong> - A value between 0 and 1 indicating the volume at which the video should play (default is 1).</li>
	 * 		<li><strong> repeat : int</strong> - Number of times that the video should repeat. To repeat indefinitely, use -1. Default is 0.</li>
	 * 		<li><strong> stageVideo : StageVideo</strong> - By default, the NetStream gets attached to a <code>Video</code> object, but if you want to use StageVideo in Flash, you can define the <code>stageVideo</code> property and VideoLoader will attach its NetStream to that StageVideo instance instead of the regular Video instance (which is the <code>rawContent</code>). Please read Adobe's docs regarding StageVideo to understand the benefits, tradeoffs and limitations.</li>		
	 * 		<li><strong> checkPolicyFile : Boolean</strong> - If <code>true</code>, the VideoLoader will check for a crossdomain.xml file on the remote host (only useful when loading videos from other domains - see Adobe's docs for details about NetStream's <code>checkPolicyFile</code> property). </li>
	 * 		<li><strong> estimatedDuration : Number</strong> - Estimated duration of the video in seconds. VideoLoader will only use this value until it receives the necessary metaData from the video in order to accurately determine the video's duration. You do not need to specify an <code>estimatedDuration</code>, but doing so can help make the playProgress and some other values more accurate (until the metaData has loaded). It can also make the <code>progress/bytesLoaded/bytesTotal</code> more accurate when a <code>estimatedDuration</code> is defined, particularly in <code>bufferMode</code>.</li>
	 * 		<li><strong> deblocking : int</strong> - Indicates the type of filter applied to decoded video as part of post-processing. The default value is 0, which lets the video compressor apply a deblocking filter as needed. See Adobe's <code>flash.media.Video</code> class docs for details.</li>
	 * 		<li><strong> bufferMode : Boolean </strong> - When <code>true</code>, the loader will report its progress only in terms of the video's buffer which can be very convenient if, for example, you want to display loading progress for the video's buffer or tuck it into a LoaderMax with other loaders and allow the LoaderMax to dispatch its <code>COMPLETE</code> event when the buffer is full instead of waiting for the whole file to download. When <code>bufferMode</code> is <code>true</code>, the VideoLoader will dispatch its <code>COMPLETE</code> event when the buffer is full as opposed to waiting for the entire video to load. You can toggle the <code>bufferMode</code> anytime. Please read the full <code>bufferMode</code> property ASDoc description below for details about how it affects things like <code>bytesTotal</code>.</li>
	 * 		<li><strong> autoAdjustBuffer : Boolean </strong> If the buffer becomes empty during playback and <code>autoAdjustBuffer</code> is <code>true</code> (the default), it will automatically attempt to adjust the NetStream's <code>bufferTime</code> based on the rate at which the video has been loading, estimating what it needs to be in order to play the rest of the video without emptying the buffer again. This can prevent the annoying problem of video playback start/stopping/starting/stopping on a system tht doesn't have enough bandwidth to adequately buffer the video. You may also set the <code>bufferTime</code> in the constructor's <code>vars</code> parameter to set the initial value.</li>
	 * 		<li><strong> autoDetachNetStream : Boolean</strong> - If <code>true</code>, the NetStream will only be attached to the Video object (the <code>rawContent</code>) when it is in the display list (on the stage). This conserves memory but it can cause a very brief rendering delay when the content is initially added to the stage (often imperceptible). Also, if you add it to the stage when the <code>videoTime</code> is <i>after</i> its last encoded keyframe, it will render at that last keyframe.</li>
	 * 		<li><strong> alternateURL : String</strong> - If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).</li>
	 * 		<li><strong> noCache : Boolean</strong> - If <code>noCache</code> is <code>true</code>, a "gsCacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>getLoader()</code> or <code>getContent()</code> by url and when you're running locally)</li>
	 * 		<li><strong> estimatedBytes : uint</strong> - Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader will be inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).</li>
	 * 		<li><strong> requireWithRoot : DisplayObject</strong> - LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this VideoLoader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>var loader:VideoLoader = new VideoLoader("myScript.php", {name:"textData", requireWithRoot:this.root});</code></li>
	 * 		<li><strong> allowMalformedURL : Boolean</strong> - Normally, the URL will be parsed and any variables in the query string (like "?name=test&amp;state=il&amp;gender=m") will be placed into a URLVariables object which is added to the URLRequest. This avoids a few bugs in Flash, but if you need to keep the entire URL intact (no parsing into URLVariables), set <code>allowMalformedURL:true</code>. For example, if your URL has duplicate variables in the query string like <code>http://www.greensock.com/?c=S&amp;c=SE&amp;c=SW</code>, it is technically considered a malformed URL and a URLVariables object can't properly contain all the duplicates, so in this case you'd want to set <code>allowMalformedURL</code> to <code>true</code>.</li>
	 * 		<li><strong> autoDispose : Boolean</strong> - When <code>autoDispose</code> is <code>true</code>, the loader will be disposed immediately after it completes (it calls the <code>dispose()</code> method internally after dispatching its <code>COMPLETE</code> event). This will remove any listeners that were defined in the vars object (like onComplete, onProgress, onError, onInit). Once a loader is disposed, it can no longer be found with <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> - it is essentially destroyed but its content is not unloaded (you must call <code>unload()</code> or <code>dispose(true)</code> to unload its content). The default <code>autoDispose</code> value is <code>false</code>.
	 * 		
	 * 		<p>----EVENT HANDLER SHORTCUTS----</p></li>
	 * 		<li><strong> onOpen : Function</strong> - A handler function for <code>LoaderEvent.OPEN</code> events which are dispatched when the loader begins loading. Make sure your onOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onInit : Function</strong> - A handler function for <code>Event.INIT</code> events which will be called when the video's metaData has been received and the video is placed into the <code>ContentDisplay</code>. The <code>INIT</code> event can be dispatched more than once if the NetStream receives metaData more than once (which occasionally happens, particularly with F4V files - the first time often doesn't include the cuePoints). Make sure your <code>onInit</code> function accepts a single parameter of type <code>Event</code> (flash.events.Event).</li>
	 * 		<li><strong> onProgress : Function</strong> - A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.</li>
	 * 		<li><strong> onComplete : Function</strong> - A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onCancel : Function</strong> - A handler function for <code>LoaderEvent.CANCEL</code> events which are dispatched when loading is aborted due to either a failure or because another loader was prioritized or <code>cancel()</code> was manually called. Make sure your onCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onError : Function</strong> - A handler function for <code>LoaderEvent.ERROR</code> events which are dispatched whenever the loader experiences an error (typically an IO_ERROR). An error doesn't necessarily mean the loader failed, however - to listen for when a loader fails, use the <code>onFail</code> special property. Make sure your onError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onFail : Function</strong> - A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onIOError : Function</strong> - A handler function for <code>LoaderEvent.IO_ERROR</code> events which will also call the onError handler, so you can use that as more of a catch-all whereas <code>onIOError</code> is specifically for LoaderEvent.IO_ERROR events. Make sure your onIOError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * </ul>
	 * @see com.greensock.loading.data.VideoLoaderVars
	 */
	public function new(urlOrRequest:Dynamic, vars:Dynamic = null);

	/** @private Set inside ContentDisplay's or FlexContentDisplay's "loader" setter. **/
	public function setContentDisplay(contentDisplay:Sprite):Void;
	
	/** @inheritDoc **/
	override public function addEventListener(type:String, listener:Function, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void;
	
	/**
	 * Adds an ActionScript cue point. Cue points are only triggered when the video is playing and passes
	 * the cue point's position in the video (in the forwards direction - they are not triggered when you skip
	 * to a previous time in the video with <code>gotoVideoTime()</code>). 
	 * 
	 * <p>For example, to add a cue point named "coolPart" at the 5-second point of the video, do:</p>
	 * 
	 * <listing version="3.0">
myVideoLoader.addASCuePoint(5, "coolPart", {message:"This is a cool part.", id:5}); 
myVideoLoader.addEventListener(VideoLoader.VIDEO_CUE_POINT, cuePointHandler); 
function cuePointHandler(event:LoaderEvent):void { 
	trace("hit cue point " + event.data.name + ", message: " + event.data.parameters.message); 
}
</listing>
	 * 
	 * @param time The time (in seconds) at which the cue point should be placed in the video. 
	 * @param name The name of the cue point. It is acceptable to have multiple cue points with the same name.
	 * @param parameters An object containing any data that you want associated with the cue point. For example, <code>{message:"descriptive text", id:5}</code>. This data can be retrieved in the VIDEO_CUE_POINT handler via the LoaderEvent's <code>data</code> property like <code>event.data.parameters</code>
	 * @return The cue point that was added
	 * @see #removeASCuePoint()
	 * @see #gotoVideoCuePoint()
	 * @see #getCuePointTime()
	 */
	public function addASCuePoint(time:Float, name:String = "", parameters:Dynamic = null):Dynamic;
	
	/**
	 * Removes an ActionScript cue point that was added with <code>addASCuePoint()</code>. If multiple ActionScript
	 * cue points match the search criteria, only one is removed. To remove all, call this function repeatedly in a 
	 * loop with the same parameters until it returns null. 
	 * 
	 * @param timeNameOrCuePoint The time, name or cue point object that should be removed. The method removes the first cue point that matches the criteria. 
	 * @return The cue point that was removed (or <code>null</code> if none were found that match the criteria)
	 * @see #addASCuePoint()
	 */
	public function removeASCuePoint(timeNameOrCuePoint:Dynamic):Dynamic;
	
	/**
	 * Finds a cue point by name and returns its corresponding time (where it is positioned in the video). 
	 * All cue points will be included in the search (cue points embedded into the video when it was encoded
	 * as well as cue points that were added with <code>addASCuePoint()</code>).
	 * 
	 * @param name The name of the cue point
	 * @return The cue point's time (NaN if no cue point was found with the specified name)
	 * @see #addASCuePoint()
	 * @see #gotoVideoCuePoint()
	 * @see #gotoVideoTime()
	 */
	public function getCuePointTime(name:String):Float;
	
	/**
	 * Attempts to jump to a certain cue point (either a cue point that was embedded in the
	 * video itself when it was encoded or a cue point that was added via <code>addASCuePoint()</code>). 
	 * If the video hasn't downloaded enough to get to the cue point or if there is no keyframe at that 
	 * point in the video, it will get as close as possible. For example, to jump to a cue point
	 * named "highlight1" and play from there:<p><code>
	 * 
	 * loader.gotoVideoCuePoint("highlight1", true);</code></p>
	 * 
	 * @param name The name of the cue point
	 * @param forcePlay If <code>true</code>, the video will resume playback immediately after seeking to the new position.
	 * @param skipCuePoints If <code>true</code> (the default), any cue points that are positioned between the current videoTime and the destination cue point will be ignored when moving to the new videoTime. In other words, it is like a record player that has its needle picked up, moved, and dropped into a new position rather than dragging it across the record, triggering the various cue points (if any exist there). IMPORTANT: cue points are only triggered when the time advances in the forward direction; they are never triggered when rewinding or restarting. 
	 * @return The cue point's time (NaN if the cue point wasn't found)
	 * @see #gotoVideoTime()
	 * @see #addASCuePoint()
	 * @see #removeASCuePoint()
	 */
	public function gotoVideoCuePoint(name:String, forcePlay:Bool = false, skipCuePoints:Bool = true):Float;
	
	/** 
	 * Pauses playback of the video. 
	 * 
	 * @param event An optional Event which simply makes it easier to use the method as a handler for mouse clicks or other events.
	 * 
	 * @see #videoPaused
	 * @see #gotoVideoTime()
	 * @see #playVideo()
	 * @see #videoTime
	 * @see #playProgress
	 **/
	public function pauseVideo(event:Event = null):Void;
	
	/** 
	 * Plays the video (if the buffer isn't full yet, playback will wait until the buffer is full).
	 * 
	 * @param event An optional Event which simply makes it easier to use the method as a handler for mouse clicks or other events.
	 * 
	 * @see #videoPaused
	 * @see #pauseVideo()
	 * @see #gotoVideoTime()
	 * @see #videoTime
	 * @see #playProgress
	 **/
	public function playVideo(event:Event = null):Void;
	
	/**
	 * Sets or gets the current repeat count (how many times the video has repeated, as determined
	 * by the <code>"repeat"</code> special property that was passed into the constructor). If you pass 
	 * a value to the function, it acts as a setter, and if you omit the parameter, it acts as a getter
	 * and returns the current value. For example, if the video was set to repeat 5 times and it is currently
	 * in the middle of its 3rd time playing, <code>repeatCount()</code> will return 2 because it has already 
	 * finished playing twice completely. 
	 * 
	 * @param value the value that should be assigned to the current repeat count (or if you omit this parameter, the current repeat count will be returned)
	 * @return If the <code>value</code> parameter is omitted, it will return the current repeat count (how many times it has completely played and looped back to the beginning). If the function is used as a setter, the VideoLoader instance itself is returned in order to make chaining easier. 
	 */
	public function repeatCount(value:Int = 0):Dynamic;
	
	/** 
	 * Attempts to jump to a certain time in the video. If the video hasn't downloaded enough to get to
	 * the new time or if there is no keyframe at that time value, it will get as close as possible.
	 * For example, to jump to exactly 3-seconds into the video and play from there:<p><code>
	 * 
	 * loader.gotoVideoTime(3, true);</code></p>
	 * 
	 * <p>The VideoLoader's <code>videoTime</code> will immediately reflect the new time, but <code>PLAY_PROGRESS</code> 
	 * event won't be dispatched until the NetStream's <code>time</code> renders at that spot (which can take a frame or so).</p>
	 * 
	 * @param time The time (in seconds, offset from the very beginning) at which to place the virtual playhead on the video.
	 * @param forcePlay If <code>true</code>, the video will resume playback immediately after seeking to the new position.
	 * @param skipCuePoints If <code>true</code> (the default), any cue points that are positioned between the current videoTime and the destination time (defined by the <code>time</code> parameter) will be ignored when moving to the new videoTime. In other words, it is like a record player that has its needle picked up, moved, and dropped into a new position rather than dragging it across the record, triggering the various cue points (if any exist there). IMPORTANT: cue points are only triggered when the time advances in the forward direction; they are never triggered when rewinding or restarting. 
	 * @see #pauseVideo()
	 * @see #playVideo()
	 * @see #videoTime
	 * @see #playProgress
	 **/
	public function gotoVideoTime(time:Float, forcePlay:Bool = false, skipCuePoints:Bool = true):Float;
	
	/** Clears the video from the rawContent (the Video object). This also works around a bug in Adobe's <code>Video</code> class that prevents clear() from working properly in some versions of the Flash Player (https://bugs.adobe.com/jira/browse/FP-178). Note that this does not detatch the NetStream - it simply deletes the currently displayed image/frame, so you'd want to make sure the video is paused or finished before calling <code>clearVideo()</code>. **/
	public function clearVideo():Void;

	/** @inheritDoc 
	 * Flash has a bug/inconsistency that causes NetStreams to load relative URLs as being relative to the swf file itself
	 * rather than relative to the HTML file in which it is embedded (all other loaders exhibit the opposite behavior), so 
	 * we need to make sure the audits use NetStreams instead of URLStreams (for relative urls at least). 
	 **/
	override public function auditSize():Void;
}


/** @private for the linked list of cue points - makes processing very fast. **/
#if (js)
@:native("CuePoint")
#end
extern class CuePoint
{
	public var next:CuePoint;
	public var prev:CuePoint;
	public var time:Float;
	public var name:String;
	public var parameters:Dynamic;
	public var gc:Bool;
	
	@:allow(com.greensock.loading)
	private function new(time:Float, name:String, params:Dynamic, prev:CuePoint);
}
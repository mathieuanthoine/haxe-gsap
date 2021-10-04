/**
 * VERSION: 1.931
 * DATE: 2012-09-09
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading;

import com.greensock.loading.core.LoaderItem;
import flash.events.Event;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import haxe.Constraints.Function;

/**
 * Loads an MP3 audio file and also provides convenient playback methods 
 * and properties like <code>pauseSound(), playSound(), gotoSoundTime(), playProgress, volume, 
 * soundPaused, duration, </code> and <code>soundTime</code>. An MP3Loader will dispatch useful events
 * like <code>SOUND_COMPLETE, SOUND_PAUSE, SOUND_PLAY</code>, and <code>PLAY_PROGRESS</code> in addition
 * to the typical loader events, making it easy to hook up your own control interface. It packs a 
 * surprising amount of functionality into a very small amount of kb. 
 * 
 * <p><strong>OPTIONAL VARS PROPERTIES</strong></p>
 * <p>The following special properties can be passed into the MP3Loader constructor via its <code>vars</code> 
 * parameter which can be either a generic object or an <code><a href="data/MP3LoaderVars.html">MP3LoaderVars</a></code> object:</p>
 * <ul>
 * 		<li><strong> name : String</strong> - A name that is used to identify the MP3Loader instance. This name can be fed to the <code>find()</code> method or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".</li>
 * 		<li><strong> autoPlay : Boolean</strong> - By default the MP3 will begin playing immediately when enough of the file has buffered, but to prevent it from autoPlaying, set <code>autoPlay</code> to <code>false</code>.</li>
 * 		<li><strong> repeat : int</strong> - Number of times that the mp3 should repeat. To repeat indefinitely, use -1. Default is 0.</li>
 * 		<li><strong> volume : Number</strong> - A value between 0 and 1 indicating the volume at which the sound should play when the MP3Loader's controls are used to play the sound, like <code>playSound()</code> or when <code>autoPlay</code> is <code>true</code> (default volume is 1).</li>
 * 		<li><strong> initThreshold : uint</strong> - The minimum number of <code>bytesLoaded</code> to wait for before the <code>LoaderEvent.INIT</code> event is dispatched - the higher the number the more accurate the <code>duration</code> estimate will be when the INIT event is dispatched (the default value is 102400 which is 100k). The MP3's duration cannot be determined with 100% accuracy until it has completely loaded, but it is estimated with more and more accuracy as the file loads.</li>
 * 		<li><strong> alternateURL : String</strong> - If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).</li>
 * 		<li><strong> context : SoundLoaderContext</strong> - To control things like the buffer time and whether or not a policy file is checked, define a <code>SoundLoaderContext</code> object. The default context is null. See Adobe's SoundLoaderContext documentation for details.</li>
 * 		<li><strong> noCache : Boolean</strong> - If <code>noCache</code> is <code>true</code>, a "gsCacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>getLoader()</code> or <code>getContent()</code> by url and when you're running locally)</li>
 * 		<li><strong> estimatedBytes : uint</strong> - Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader will be inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).</li>
 * 		<li><strong> requireWithRoot : DisplayObject</strong> - LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this MP3Loader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>var loader:MP3Loader = new MP3Loader("audio.mp3", {name:"audio", requireWithRoot:this.root});</code></li>
 * 		<li><strong> allowMalformedURL : Boolean</strong> - Normally, the URL will be parsed and any variables in the query string (like "?name=test&amp;state=il&amp;gender=m") will be placed into a URLVariables object which is added to the URLRequest. This avoids a few bugs in Flash, but if you need to keep the entire URL intact (no parsing into URLVariables), set <code>allowMalformedURL:true</code>. For example, if your URL has duplicate variables in the query string like <code>http://www.greensock.com/?c=S&amp;c=SE&amp;c=SW</code>, it is technically considered a malformed URL and a URLVariables object can't properly contain all the duplicates, so in this case you'd want to set <code>allowMalformedURL</code> to <code>true</code>.</li>
 * 		<li><strong> autoDispose : Boolean</strong> - When <code>autoDispose</code> is <code>true</code>, the loader will be disposed immediately after it completes (it calls the <code>dispose()</code> method internally after dispatching its <code>COMPLETE</code> event). This will remove any listeners that were defined in the vars object (like onComplete, onProgress, onError, onInit). Once a loader is disposed, it can no longer be found with <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> - it is essentially destroyed but its content is not unloaded (you must call <code>unload()</code> or <code>dispose(true)</code> to unload its content). The default <code>autoDispose</code> value is <code>false</code>.
 * 		
 * 		<p>----EVENT HANDLER SHORTCUTS----</p></li>
 * 		<li><strong> onOpen : Function</strong> - A handler function for <code>LoaderEvent.OPEN</code> events which are dispatched when the loader begins loading. Make sure your onOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onInit : Function</strong> - A handler function for <code>Event.INIT</code> events which will be dispatched when the <code>bytesLoaded</code> exceeds the <code>initThreshold</code> (100k by default) and the MP3 has streamed enough of its content to identify the ID3 meta data. Make sure your onInit function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onProgress : Function</strong> - A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.</li>
 * 		<li><strong> onComplete : Function</strong> - A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onCancel : Function</strong> - A handler function for <code>LoaderEvent.CANCEL</code> events which are dispatched when loading is aborted due to either a failure or because another loader was prioritized or <code>cancel()</code> was manually called. Make sure your onCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onError : Function</strong> - A handler function for <code>LoaderEvent.ERROR</code> events which are dispatched whenever the loader experiences an error (typically an IO_ERROR or SECURITY_ERROR). An error doesn't necessarily mean the loader failed, however - to listen for when a loader fails, use the <code>onFail</code> special property. Make sure your onError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onFail : Function</strong> - A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onIOError : Function</strong> - A handler function for <code>LoaderEvent.IO_ERROR</code> events which will also call the onError handler, so you can use that as more of a catch-all whereas <code>onIOError</code> is specifically for LoaderEvent.IO_ERROR events. Make sure your onIOError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * </ul>
 * 
 * <p><strong>Note:</strong> Using a <code><a href="data/MP3LoaderVars.html">MP3LoaderVars</a></code> instance 
 * instead of a generic object to define your <code>vars</code> is a bit more verbose but provides 
 * code hinting and improved debugging because it enforces strict data typing. Use whichever one you prefer.</p>
 * 
 * <p><code>content</code> data type: <strong><code>flash.media.Sound</code></strong></p>
 * 
 * <p><strong>NOTE:</strong> To avoid garbage collection issues in the Flash player, the <code>Sound</code> 
 * object that MP3Loader employs must get recreated internally anytime the MP3Loader is unloaded or its loading 
 * is cancelled, so it is best to access the <code>content</code> after the <code>COMPLETE</code>
 * event has been dispatched. Otherwise, if you store a reference to the MP3Loader's <code>content</code>
 * before or during a load and it gets cancelled or unloaded for some reason, the <code>Sound</code> object 
 * won't be the one into which the MP3 is eventually loaded.</p>
 * 
 * Example AS3 code:<listing version="3.0">
 import com.greensock.~~;
 import com.greensock.loading.~~;
 import com.greensock.events.LoaderEvent;
 
 //create a MP3Loader that will begin playing immediately when it loads
 var sound:MP3Loader = new MP3Loader("mp3/audio.mp3", {name:"audio", autoPlay:true, repeat:3, estimatedBytes:9500});
 
 //begin loading
 sound.load();
 
 //add a CLICK listener to a button that causes the sound to toggle its paused state.
 button.addEventListener(MouseEvent.CLICK, toggleSound);
 function toggleSound(event:MouseEvent):void {
     sound.soundPaused = !sound.soundPaused;
 }
 
 //or you could put the MP3Loader into a LoaderMax queue. Create one first...
 var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
 
 //append the MP3Loader and then several other loaders
 queue.append( sound );
 queue.append( new XMLLoader("xml/doc.xml", {name:"xmlDoc", estimatedBytes:425}) );
 queue.append( new ImageLoader("img/photo1.jpg", {name:"photo1", estimatedBytes:3500}) );
 
 //start loading
 queue.load();
 
 function progressHandler(event:LoaderEvent):void {
 		trace("progress: " + event.target.progress);
 }
 
 function completeHandler(event:LoaderEvent):void {
 		trace(event.target + " is complete!");
 }
 
 function errorHandler(event:LoaderEvent):void {
 		trace("error occured with " + event.target + ": " + event.text);
 }
 </listing>
 * 
 * <p><strong>Copyright 2010-2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @see com.greensock.loading.data.MP3LoaderVars
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("MP3Loader")
#end
extern class MP3Loader extends LoaderItem
{
	public var soundPaused:Bool;
	public var playProgress:Float;
	public var volume:Float;
	public var soundTime:Float;
	public var duration:Float;
	public var soundTransform:SoundTransform;

	/** Event type constant for when the sound completes. **/
	public static inline var SOUND_COMPLETE:String = "soundComplete";
	/** Event type constant for when the sound is paused. **/
	public static inline var SOUND_PAUSE:String = "soundPause";
	/** Event type constant for when the sound begins or resumes playing. **/
	public static inline var SOUND_PLAY:String = "soundPlay";
	/** Event type constant for when the playback progresses (only dispatched when the sound is playing). **/
	public static inline var PLAY_PROGRESS:String = "playProgress";

	/** The minimum number of <code>bytesLoaded</code> to wait for before the <code>LoaderEvent.INIT</code> event is dispatched - the higher the number the more accurate the <code>duration</code> estimate will be when the INIT event is dispatched (the default value is 102400 which is 100k). The MP3's duration cannot be determined with 100% accuracy until it has completely loaded, but it is estimated with more and more accuracy as the file loads. **/
	public var initThreshold:Int;
	/** The SoundChannel object that results from the most recent <code>playSound()</code> call (or when <code>autoPlay</code> is <code>true</code> in the constructor's <code>vars</code> parameter). Typically there isn't much reason to use this directly. Instead, use the MP3Loader's controls like <code>playSound(), pauseSound(), gotoSoundTime(), playProgress, duration, soundTime</code>, etc. **/
	public var channel:SoundChannel;
	
	/**
	 * Constructor.
	 * 
	 * @param urlOrRequest The url (<code>String</code>) or <code>URLRequest</code> from which the loader should get its content
	 * @param vars An object containing optional configuration details. For example: <code>new MP3Loader("mp3/audio.mp3", {name:"audio", autoPlay:true, onComplete:completeHandler, onProgress:progressHandler})</code>.
	 * 
	 * <p>The following special properties can be passed into the constructor via the <code>vars</code> parameter
	 * which can be either a generic object or an <code><a href="data/MP3LoaderVars.html">MP3LoaderVars</a></code> object:</p>
	 * <ul>
	 * 		<li><strong> name : String</strong> - A name that is used to identify the MP3Loader instance. This name can be fed to the <code>find()</code> method or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".</li>
	 * 		<li><strong> autoPlay : Boolean</strong> - By default the MP3 will begin playing immediately when enough of the file has buffered, but to prevent it from autoPlaying, set <code>autoPlay</code> to <code>false</code>.</li>
	 * 		<li><strong> repeat : int</strong> - Number of times that the mp3 should repeat. To repeat indefinitely, use -1. Default is 0.</li>
	 * 		<li><strong> volume : Number</strong> - A value between 0 and 1 indicating the volume at which the sound should play (default is 1).</li>
	 * 		<li><strong> initThreshold : uint</strong> - The minimum number of <code>bytesLoaded</code> to wait for before the <code>LoaderEvent.INIT</code> event is dispatched - the higher the number the more accurate the <code>duration</code> estimate will be when the INIT event is dispatched (the default value is 102400 which is 100k). The MP3's duration cannot be determined with 100% accuracy until it has completely loaded, but it is estimated with more and more accuracy as the file loads.</li>
	 * 		<li><strong> alternateURL : String</strong> - If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).</li>
	 * 		<li><strong> context : SoundLoaderContext</strong> - To control things like the buffer time and whether or not a policy file is checked, define a <code>SoundLoaderContext</code> object. The default context is null. See Adobe's SoundLoaderContext documentation for details.</li>
	 * 		<li><strong> noCache : Boolean</strong> - If <code>noCache</code> is <code>true</code>, a "gsCacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>getLoader()</code> or <code>getContent()</code> by url and when you're running locally)</li>
	 * 		<li><strong> estimatedBytes : uint</strong> - Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the loader begins loading and it can accurately determine the bytesTotal, it will do so. Setting <code>estimatedBytes</code> is optional, but the more accurate the value, the more accurate your loaders' overall progress will be initially. If the loader will be inserted into a LoaderMax instance (for queue management), its <code>auditSize</code> feature can attempt to automatically determine the <code>bytesTotal</code> at runtime (there is a slight performance penalty for this, however - see LoaderMax's documentation for details).</li>
	 * 		<li><strong> requireWithRoot : DisplayObject</strong> - LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this MP3Loader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>var loader:MP3Loader = new MP3Loader("audio.mp3", {name:"audio", requireWithRoot:this.root});</code></li>
	 * 		<li><strong> allowMalformedURL : Boolean</strong> - Normally, the URL will be parsed and any variables in the query string (like "?name=test&amp;state=il&amp;gender=m") will be placed into a URLVariables object which is added to the URLRequest. This avoids a few bugs in Flash, but if you need to keep the entire URL intact (no parsing into URLVariables), set <code>allowMalformedURL:true</code>. For example, if your URL has duplicate variables in the query string like <code>http://www.greensock.com/?c=S&amp;c=SE&amp;c=SW</code>, it is technically considered a malformed URL and a URLVariables object can't properly contain all the duplicates, so in this case you'd want to set <code>allowMalformedURL</code> to <code>true</code>.</li>
	 * 		<li><strong> autoDispose : Boolean</strong> - When <code>autoDispose</code> is <code>true</code>, the loader will be disposed immediately after it completes (it calls the <code>dispose()</code> method internally after dispatching its <code>COMPLETE</code> event). This will remove any listeners that were defined in the vars object (like onComplete, onProgress, onError, onInit). Once a loader is disposed, it can no longer be found with <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> - it is essentially destroyed but its content is not unloaded (you must call <code>unload()</code> or <code>dispose(true)</code> to unload its content). The default <code>autoDispose</code> value is <code>false</code>.
	 * 		
	 * 		<p>----EVENT HANDLER SHORTCUTS----</p></li>
	 * 		<li><strong> onOpen : Function</strong> - A handler function for <code>LoaderEvent.OPEN</code> events which are dispatched when the loader begins loading. Make sure your onOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onInit : Function</strong> - A handler function for <code>Event.INIT</code> events which will be dispatched when the <code>bytesLoaded</code> exceeds the <code>initThreshold</code> (100k by default) and the MP3 has streamed enough of its content to identify the ID3 meta data. Make sure your onInit function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onProgress : Function</strong> - A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.</li>
	 * 		<li><strong> onComplete : Function</strong> - A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onCancel : Function</strong> - A handler function for <code>LoaderEvent.CANCEL</code> events which are dispatched when loading is aborted due to either a failure or because another loader was prioritized or <code>cancel()</code> was manually called. Make sure your onCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onError : Function</strong> - A handler function for <code>LoaderEvent.ERROR</code> events which are dispatched whenever the loader experiences an error (typically an IO_ERROR or SECURITY_ERROR). An error doesn't necessarily mean the loader failed, however - to listen for when a loader fails, use the <code>onFail</code> special property. Make sure your onError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onFail : Function</strong> - A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onIOError : Function</strong> - A handler function for <code>LoaderEvent.IO_ERROR</code> events which will also call the onError handler, so you can use that as more of a catch-all whereas <code>onIOError</code> is specifically for LoaderEvent.IO_ERROR events. Make sure your onIOError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * </ul>
	 * @see com.greensock.loading.data.MP3LoaderVars
	 */
	public function new(urlOrRequest:Dynamic, vars:Dynamic = null);

	/** 
	 * Plays the sound.
	 * 
	 * @param event An optional Event which simply makes it easier to use the method as a handler for mouse clicks or other events.
	 * @return The SoundChannel object created by the play()
	 * 
	 * @see #soundPaused
	 * @see #pauseSound()
	 * @see #gotoSoundTime()
	 * @see #soundTime
	 * @see #playProgress
	 **/
	public function playSound(event:Event = null):SoundChannel;
	
	/** 
	 * Pauses playback of the sound. 
	 * 
	 * @param event An optional Event which simply makes it easier to use the method as a handler for mouse clicks or other events.
	 * 
	 * @see #soundPaused
	 * @see #gotoSoundTime()
	 * @see #playSound()
	 * @see #soundTime
	 * @see #playProgress
	 **/
	public function pauseSound(event:Event = null):Void;
	
	/** 
	 * Attempts to jump to a certain time in the sound. If the sound hasn't downloaded enough to get to
	 * the new time, it will get as close as possible.
	 * For example, to jump to exactly 3-seconds into the sound and play from there:<p><code>
	 * 
	 * loader.gotoSoundTime(3, true);</code></p>
	 * 
	 * @param time The time (in seconds, offset from the very beginning) at which to place the virtual playhead in the sound.
	 * @param forcePlay If <code>true</code>, the sound will resume playback immediately after seeking to the new position.
	 * @param resetRepeatCount If the MP3Loader has a non-zero <code>repeat</code> value (meaning it loops/repeats at least once), setting <code>resetRepeatCount</code> to <code>true</code> will cause it to act like this is the first time through (no repeats yet). For example, if the MP3Loader had a <code>repeat</code> value of 3 and it already repeated twice when <code>gotoSoundTime()</code> was called, it would act like it forgot that it repeated twice already.
	 * @see #pauseSound()
	 * @see #playSound()
	 * @see #soundTime
	 * @see #playProgress
	 **/
	public function gotoSoundTime(time:Float, forcePlay:Bool = false, resetRepeatCount:Bool = true):Void;

	/** @inheritDoc **/
	override public function addEventListener(type:String, listener:Function, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void;
}

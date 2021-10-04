/**
 * VERSION: 1.935
 * DATE: 2013-03-18
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading.core;

import com.greensock.loading.LoaderMax;
import flash.events.EventDispatcher;
import haxe.Constraints.Function;

/**
 * Serves as the base class for GreenSock loading tools like <code>LoaderMax, ImageLoader, XMLLoader, SWFLoader</code>, etc. 
 * There is no reason to use this class on its own. Please see the documentation for the other classes.
 * 
 * <p><strong>Copyright 2014, GreenSock. All rights reserved.</strong> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for <a href="http://www.greensock.com/club/">Club GreenSock</a> members, the software agreement that was issued with the membership.</p>
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("LoaderCore")
#end
extern class LoaderCore extends EventDispatcher
{
	public var paused:Bool;
	public var status:Int;
	public var bytesLoaded:Int;
	public var bytesTotal:Int;
	public var progress:Float;
	public var rootLoader:LoaderMax;
	public var content:Dynamic;
	public var auditedSize:Bool;
	public var loadTime:Float;

	/** An object containing optional configuration details, typically passed through a constructor parameter. For example: <code>new SWFLoader("assets/file.swf", {name:"swf1", container:this, autoPlay:true, noCache:true})</code>. See the constructor's documentation for details about what special properties are recognized. **/
	public var vars:Dynamic;
	/** A name that you use to identify the loader instance. This name can be fed to the <code>getLoader()</code> or <code>getContent()</code> methods or traced at any time. Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21". **/
	public var name:String;
	/** When <code>autoDispose</code> is <code>true</code>, the loader will be disposed immediately after it completes (it calls the <code>dispose()</code> method internally after dispatching its <code>COMPLETE</code> event). This will remove any listeners that were defined in the vars object (like onComplete, onProgress, onError, onInit). Once a loader is disposed, it can no longer be found with <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> - it is essentially destroyed but its content is <strong>not</strong> unloaded (you must call <code>unload()</code> or <code>dispose(true)</code> to unload its content). The default <code>autoDispose</code> value is <code>false</code>. **/
	public var autoDispose:Bool;
	
	/**
	 * Constructor
	 * 
	 * @param vars An object containing optional parameters like <code>estimatedBytes, name, autoDispose, onComplete, onProgress, onError</code>, etc. For example, <code>{estimatedBytes:2400, name:"myImage1", onComplete:completeHandler}</code>.
	 */
	public function new(vars:Dynamic = null);
	
	/**
	 * Loads the loader's content, optionally flushing any previously loaded content first. For example, 
	 * a LoaderMax may have already loaded 4 out of the 10 loaders in its queue but if you want it to
	 * flush the data and start again, set the <code>flushContent</code> parameter to <code>true</code> (it is 
	 * <code>false</code> by default). 
	 * 
	 * @param flushContent If <code>true</code>, any previously loaded content in the loader will be flushed so that it loads again from the beginning. For example, a LoaderMax may have already loaded 4 out of the 10 loaders in its queue but if you want it to flush the data and start again, set the <code>flushContent</code> parameter to <code>true</code> (it is <code>false</code> by default). 
	 */
	public function load(flushContent:Bool = false):Void;

	/** Pauses the loader immediately. This is the same as setting the <code>paused</code> property to <code>true</code>. Some loaders may not stop loading immediately in order to work around some garbage collection issues in the Flash Player, but they will stop as soon as possible after calling <code>pause()</code>. **/
	public function pause():Void;
	
	/** Unpauses the loader and resumes loading immediately. **/
	public function resume():Void;
	
	/** 
	 * If the loader is currently loading (<code>status</code> is <code>LoaderStatus.LOADING</code>), it will be canceled 
	 * immediately and its status will change to <code>LoaderStatus.READY</code>. This does <strong>NOT</strong> pause the 
	 * loader - it simply halts the progress and it remains eligible for loading by any of its parent LoaderMax instances. 
	 * A paused loader, however, cannot be loaded by any of its parent LoaderMax instances until you unpause it (by either 
	 * calling <code>resume()</code> or setting its <code>paused</code> property to false). 
	 * @see #unload()
	 * @see #dispose()
	 **/
	public function cancel():Void;

	/** 
	 * Removes any content that was loaded and sets <code>bytesLoaded</code> back to zero. When you
	 * <code>unload()</code> a LoaderMax instance, it will also call <code>unload()</code> on all of its 
	 * children as well. If the loader is in the process of loading, it will automatically be canceled.
	 * 
	 * @see #dispose()
	 **/
	public function unload():Void;
	
	/** 
	 * Disposes of the loader and releases it internally for garbage collection. If it is in the process of loading, it will also 
	 * be cancelled immediately. By default, <code>dispose()</code> <strong>does NOT unload its content</strong>, but
	 * you may set the <code>flushContent</code> parameter to <code>true</code> in order to flush/unload the <code>content</code> as well
	 * (in the case of ImageLoaders, SWFLoaders, and VideoLoaders, this will also destroy its ContentDisplay Sprite, removing it
	 * from the display list if necessary). When a loader is disposed, all of the listeners that were added through the 
	 * <code>vars</code> object (like <code>{onComplete:completeHandler, onProgress:progressHandler}</code>) are removed. 
	 * If you manually added listeners, though, you should remove those yourself.
	 * 
	 * @param flushContent If <code>true</code>, the loader's <code>content</code> will be unloaded as well (<code>flushContent</code> is <code>false</code> by default). In the case of ImageLoaders, SWFLoaders, and VideoLoaders, their ContentDisplay will also be removed from the display list if necessary when <code>flushContent</code> is <code>true</code>.
	 * @see #unload()
	 **/
	public function dispose(flushContent:Bool = false):Void;
	
	/** 
	 * Immediately prioritizes the loader inside any LoaderMax instances that contain it,
	 * forcing it to the top position in their queue and optionally calls <code>load()</code>
	 * immediately as well. If one of its parent LoaderMax instances is currently loading a 
	 * different loader, that one will be temporarily cancelled. 
	 * 
	 * <p>By contrast, when <code>load()</code> is called, it doesn't change the loader's position/index 
	 * in any LoaderMax queues. For example, if a LoaderMax is working on loading the first object in 
	 * its queue, you can call load() on the 20th item and it will honor your request without 
	 * changing its index in the queue. <code>prioritize()</code>, however, affects the position 
	 * in the queue and optionally loads it immediately as well.</p>
	 * 
	 * <p>So even if your LoaderMax hasn't begun loading yet, you could <code>prioritize(false)</code> 
	 * a loader and it will rise to the top of all LoaderMax instances to which it belongs, but not 
	 * start loading yet. If the goal is to load something immediately, you can just use the 
	 * <code>load()</code> method.</p>
	 * 
	 * <p>You may use the static <code>LoaderMax.prioritize()</code> method instead and simply pass 
	 * the name or url of the loader as the first parameter like:</p><p><code>
	 * 
	 * LoaderMax.prioritize("myLoaderName", true);</code></p>
	 * 
	 * @param loadNow If <code>true</code> (the default), the loader will start loading immediately (otherwise it is simply placed at the top the queue in any LoaderMax instances to which it belongs).
	 * @see #load()
	 **/
	public function prioritize(loadNow:Bool = true):Void;
	
	/** @inheritDoc **/
	override public function addEventListener(type:String, listener:Function, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void;

	/**
	 * Attempts loading just enough of the content to accurately determine the <code>bytesTotal</code> 
	 * in order to improve the accuracy of the <code>progress</code> property. Once the 
	 * <code>bytesTotal</code> has been determined or the <code>auditSize()</code> attempt fails due
	 * to an error (typically IO_ERROR or SECURITY_ERROR), the <code>auditedSize</code> property will be 
	 * set to <code>true</code>. Auditing the size opens a URLStream that will be closed 
	 * as soon as a response is received.
	 **/
	public function auditSize():Void;
	
	/** Returns information about the loader, like its type, its <code>name</code>, and its <code>url</code> (if it has one). **/
	override public function toString():String;
}

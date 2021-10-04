/**
 * VERSION: 1.87
 * DATE: 2011-07-30
 * AS3
 * UPDATES AND DOCS AT: http://www.greensock.com/loadermax/
 **/
package com.greensock.loading;

import com.greensock.loading.core.DisplayObjectLoader;
import flash.display.DisplayObject;

/**
 * Loads a swf file and automatically searches for active loaders in that swf that have 
 * the <code>requireWithRoot</code> vars property set to that swf's <code>root</code>. If it finds any, 
 * it will factor those loaders' progress into its own progress and not dispatch its 
 * <code>COMPLETE</code> event until the nested loaders have finished. 
 * 
 * <p>The SWFLoader's <code>content</code> refers to a <code>ContentDisplay</code> (a Sprite) that 
 * is created immediately so that you can position/scale/rotate it or add ROLL_OVER/ROLL_OUT/CLICK listeners
 * before (or while) the swf loads. Use the SWFLoader's <code>content</code> property to get the ContentDisplay 
 * Sprite, or use the <code>rawContent</code> property to get the actual root of the loaded swf file itself. 
 * If a <code>container</code> is defined in the <code>vars</code> object, the ContentDisplay will 
 * immediately be added to that container). </p>
 * 
 * <p>If you define a <code>width</code> and <code>height</code>, it will draw a rectangle 
 * in the ContentDisplay so that interactive events fire appropriately (rollovers, etc.) and width/height/bounds
 * get reported accurately. This rectangle is invisible by default, but you can control its color and alpha
 * with the <code>bgColor</code> and <code>bgAlpha</code> properties. When the swf loads, it will be 
 * added to the ContentDisplay at index 0 with <code>addChildAt()</code> and scaled to fit the width/height according to 
 * the <code>scaleMode</code>. These are all optional features - you do not need to define a 
 * <code>width</code> or <code>height</code> in which case the swf will load at its native size. 
 * See the list below for all the special properties that can be passed through the <code>vars</code> 
 * parameter but don't let the list overwhelm you - these are all optional and they are intended to make
 * your job as a developer much easier.</p>
 * 
 * <p>By default, the SWFLoader will attempt to load the swf in a way that allows full script 
 * access (same SecurityDomain and child ApplicationDomain). However, if a security error is thrown because 
 * the swf is being loaded from another domain and the appropriate crossdomain.xml file isn't in place 
 * to grant access, the SWFLoader will automatically adjust the default LoaderContext so that it falls 
 * back to the more restricted mode which will have the following effect:</p>
 * <ul>
 * 		<li>A <code>LoaderEvent.SCRIPT_ACCESS_DENIED</code> event will be dispatched and the <code>scriptAccessDenied</code> property of the SWFLoader will be set to <code>true</code>. You can check this value before performing any restricted operations on the content like BitmapData.draw().</li>
 * 		<li>Other LoaderMax-related loaders inside the swf will not be recognized or integrated into the SWFLoader's overall progress.</li>
 * 		<li>A <code>Loader</code> instance will be added to the <code>ContentDisplay</code> Sprite instead of the swf's <code>root</code>.</li>		
 * 		<li>The <code>getClass()</code> and <code>getSWFChild()</code> methods will always return <code>null</code>.</li>
 * 		<li>BitmapData operations like <code>draw()</code> will not be able to be performed on the swf.</li>
 * </ul>
 * 
 * <p>If the loaded swf is an <code>AVM1Movie</code> (built in AS1 or AS2), <code>scriptAccessDenied</code> will be <code>true</code>
 * and a <code>Loader</code> instance will be added to the <code>content</code> Sprite instead of the swf's <code>root</code>. </p>
 * 
 * <p>To maximize the likelihood of your swf loading without any security problems, consider taking the following steps:</p>
 * <ul>
 * 		<li><strong>Use a crossdomain.xml file </strong> - See Adobe's docs for details, but here is an example that grants full access (put this in a crossdomain.xml file that is at the root of the remote domain):
 * 			&lt;?xml version="1.0" encoding="utf-8"?&gt;
 * 			&lt;cross-domain-policy&gt;
 *     			   &lt;allow-access-from domain="~~" /&gt;
 * 			&lt;/cross-domain-policy&gt;</li>
 * 		<li>In the embed code of any HTML wrapper, set <code>AllowScriptAccess</code> to <code>"always"</code></li>
 * 		<li>If possible, in the remote swf make sure you explicitly allow script access using something like <code>flash.system.Security.allowDomain("~~");</code></li>
 * </ul>
 * 
 * <p><strong>A note about garbage collection:</strong> A lot of effort has gone into making SWFLoader solve common garbage collection
 * problems related to loading and unloading swfs, but since it is impossible for SWFLoader to know all the code that will run in 
 * the child swf, it cannot automatically remove event listeners, stop NetStreams, sounds, etc., all of which could interfere
 * with garbage collection. Therefore it is considered a best practice to [whenever possible] build each subloaded swf so that 
 * it has some sort of <code>dispose()</code> method that runs cleanup code (removes event listeners, stops sounds, closes NetStreams, etc.). 
 * When the swf is loaded, you can recursively inspect the chain of parents and if a ContentDisplay object is found (it will
 * have a "loader" property), you can add an "unload" event listener so that your <code>dispose()</code> method gets called accordingly. 
 * For example, in the child swf you could use code like this: </p>
 * In the child swf:<listing version="3.0">
var curParent:DisplayObjectContainer = this.parent;
while (curParent) { 
    if (curParent.hasOwnProperty("loader") &amp;&amp; curParent.hasOwnProperty("rawContent")) { //ContentDisplay objects have "loader" and "rawContent" properties. The "loader" points to the SWFLoader. Technically it would be cleaner to say if (curParent is ContentDisplay) but that would force ContentDisplay and some core LoaderMax classes to get compiled into the child swf unnecessarily, so doing it this way keeps file size down. 
        Object(curParent).loader.addEventListener("unload", dispose, false, 0, true); 
    }
    curParent = curParent.parent;
}
function dispose(event:Event):void { 
    //do cleanup stuff here like removing event listeners, stopping sounds, closing NetStreams, etc... 
}
</listing>
 * 
 * <p><strong>OPTIONAL VARS PROPERTIES</strong></p>
 * <p>The following special properties can be passed into the SWFLoader constructor via its <code>vars</code> 
 * parameter which can be either a generic object or an <code><a href="data/SWFLoaderVars.html">SWFLoaderVars</a></code> object:</p>
 * <ul>
 * 		<li><strong> name : String</strong> - A name that is used to identify the SWFLoader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods. This name is also applied to the Sprite that is created to hold the swf (The SWFLoader's <code>content</code> refers to this Sprite). Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".</li>
 * 		<li><strong> container : DisplayObjectContainer</strong> - A DisplayObjectContainer into which the <code>content</code> Sprite should be added immediately.</li>
 * 		<li><strong> width : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>width</code> property (applied before rotation, scaleX, and scaleY).</li>
 * 		<li><strong> height : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>height</code> property (applied before rotation, scaleX, and scaleY).</li>
 * 		<li><strong> centerRegistration : Boolean </strong> - if <code>true</code>, the registration point will be placed in the center of the <code>ContentDisplay</code> Sprite which can be useful if, for example, you want to animate its scale and have it grow/shrink from its center.</li>
 * 		<li><strong> scaleMode : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>scaleMode</code> controls how the loaded swf will be scaled to fit the area. The following values are recognized (you may use the <code>com.greensock.layout.ScaleMode</code> constants if you prefer):
 * 			<ul>
 * 				<li><code>"stretch"</code> (the default) - The swf will fill the width/height exactly.</li>
 * 				<li><code>"proportionalInside"</code> - The swf will be scaled proportionally to fit inside the area defined by the width/height</li>
 * 				<li><code>"proportionalOutside"</code> - The swf will be scaled proportionally to completely fill the area, allowing portions of it to exceed the bounds defined by the width/height.</li>
 * 				<li><code>"widthOnly"</code> - Only the width of the swf will be adjusted to fit.</li>
 * 				<li><code>"heightOnly"</code> - Only the height of the swf will be adjusted to fit.</li>
 * 				<li><code>"none"</code> - No scaling of the swf will occur.</li>
 * 			</ul></li>
 * 		<li><strong> hAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>hAlign</code> determines how the swf is horizontally aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
 * 			<ul>
 * 				<li><code>"center"</code> (the default) - The swf will be centered horizontally in the area</li>
 * 				<li><code>"left"</code> - The swf will be aligned with the left side of the area</li>
 * 				<li><code>"right"</code> - The swf will be aligned with the right side of the area</li>
 * 			</ul></li>
 * 		<li><strong> vAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>vAlign</code> determines how the swf is vertically aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
 * 			<ul>
 * 				<li><code>"center"</code> (the default) - The swf will be centered vertically in the area</li>
 * 				<li><code>"top"</code> - The swf will be aligned with the top of the area</li>
 * 				<li><code>"bottom"</code> - The swf will be aligned with the bottom of the area</li>
 * 			</ul></li>
 * 		<li><strong> crop : Boolean</strong> - When a <code>width</code> and <code>height</code> are defined, setting <code>crop</code> to <code>true</code> will cause the swf to be cropped within that area (by applying a <code>scrollRect</code> for maximum performance) based on its native size (not the bounding box of the swf's current contents). This is typically useful when the <code>scaleMode</code> is <code>"proportionalOutside"</code> or <code>"none"</code> or when the swf contains objects that are positioned off-stage. Any parts of the swf that exceed the dimensions defined by <code>width</code> and <code>height</code> are visually chopped off. Use the <code>hAlign</code> and <code>vAlign</code> special properties to control the vertical and horizontal alignment within the cropped area.</li>
 * 		<li><strong> x : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>x</code> property (for positioning on the stage).</li>
 * 		<li><strong> y : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>y</code> property (for positioning on the stage).</li>
 * 		<li><strong> scaleX : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleX</code> property.</li>
 * 		<li><strong> scaleY : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleY</code> property.</li>
 * 		<li><strong> rotation : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>rotation</code> property.</li>
 * 		<li><strong> alpha : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>alpha</code> property.</li>
 * 		<li><strong> visible : Boolean</strong> - Sets the <code>ContentDisplay</code>'s <code>visible</code> property.</li>
 * 		<li><strong> blendMode : String</strong> - Sets the <code>ContentDisplay</code>'s <code>blendMode</code> property.</li>
 * 		<li><strong> autoPlay : Boolean</strong> - If <code>autoPlay</code> is <code>true</code> (the default), the swf will begin playing immediately when the <code>INIT</code> event fires. To prevent this behavior, set <code>autoPlay</code> to <code>false</code> which will also mute the swf until the SWFLoader completes. This only calls <code>stop()</code> on the main timeline but it does not prevent scripted animations.</li>
 * 		<li><strong> bgColor : uint </strong> - When a <code>width</code> and <code>height</code> are defined, a rectangle will be drawn inside the <code>ContentDisplay</code> Sprite immediately in order to ease the development process. It is transparent by default, but you may define a <code>bgAlpha</code> if you prefer.</li>
 * 		<li><strong> bgAlpha : Number </strong> - Controls the alpha of the rectangle that is drawn when a <code>width</code> and <code>height</code> are defined.</li>
 * 		<li><strong> context : LoaderContext</strong> - To control things like the ApplicationDomain, SecurityDomain, and whether or not a policy file is checked, define a <code>LoaderContext</code> object. The default context is null when running locally and <code>new LoaderContext(true, new ApplicationDomain(ApplicationDomain.currentDomain), SecurityDomain.currentDomain)</code> when running remotely in order to avoid common security sandbox errors (see Adobe's LoaderContext documentation for details and precautions). Please make sure that if you load swfs from another domain that you have a crossdomain.xml file installed on that remote server that grants your swf access rights (see Adobe's docs for crossdomain.xml details). Again, if you want to impose security restrictions on the loaded swf, please define your own LoaderContext.</li>
 * 		<li><strong> suppressInitReparentEvents : Boolean</strong> - If <code>true</code>, the SWFLoader will suppress the <code>REMOVED_FROM_STAGE</code> and <code>ADDED_TO_STAGE</code> events that are normally dispatched when the subloaded swf is reparented into the ContentDisplay (this always happens in Flash when any DisplayObject that's in the display list gets reparented - SWFLoader just circumvents it by default initially to avoid common problems that could arise if the child swf is coded a certain way). For example, if your subloaded swf has this code: <code>addEventListener(Event.REMOVED_FROM_STAGE, disposeEverything)</code> and you set <code>suppressInitReparentEvents</code> to <code>false</code>, <code>disposeEverything()</code> would get called as soon as the swf inits (assuming the ContentDisplay is in the display list).</li>
 * 		<li><strong> integrateProgress : Boolean</strong> - By default, a SWFLoader instance will automatically look for LoaderMax loaders in the swf when it initializes. Every loader found with a <code>requireWithRoot</code> parameter set to that swf's <code>root</code> will be integrated into the SWFLoader's overall progress. The SWFLoader's <code>COMPLETE</code> event won't fire until all such loaders are also complete. If you prefer NOT to integrate the subloading loaders into the SWFLoader's overall progress, set <code>integrateProgress</code> to <code>false</code>.</li>
 * 		<li><strong> suppressUncaughtErrors : Boolean</strong> - To automatically suppress uncaught errors in the subloaded swf (errors that are thrown outside of a try...catch statement), set <code>suppressUncaughtErrors</code> to <code>true</code>, but please note that this will ONLY work if the parent swf is published to Flash Player 10.1 or later. Suppressing the UncaughtErrorEvent simply means calling its <code>preventDefault()</code> and <code>stopImmediatePropagation()</code> methods as well as preventing it from bubbling up to its parent LoaderMax/SWFLoader anscestors. If you'd rather listen for these events so that you can handle them yourself, listen for the <code>LoaderEvent.UNCAUGHT_ERROR</code> event. The original UncaughtErrorEvent instance will be stored in the LoaderEvent's <code>data</code> property.</li>
 * 		<li><strong> alternateURL : String</strong> - If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).</li>
 * 		<li><strong> noCache : Boolean</strong> - If <code>noCache</code> is <code>true</code>, a "gsCacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>getLoader()</code> or <code>getContent()</code> by url and when you're running locally)</li>
 * 		<li><strong> estimatedBytes : uint</strong> - Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the swf initializes and has been analyzed enough to determine the size of any nested loaders that were found inside the swf with their <code>requireWithRoot</code> set to that swf's <code>root</code>, it will adjust the <code>bytesTotal</code> accordingly. Setting <code>estimatedBytes</code> is optional, but it provides a way to avoid situations where the <code>progress</code> and <code>bytesTotal</code> values jump around as SWFLoader recognizes nested loaders in the swf and audits their size. The <code>estimatedBytes</code> value should include all nested loaders as well, so if your swf file itself is 2000 bytes and it has 3 nested ImageLoaders, each loading a 2000-byte image, your SWFLoader's <code>estimatedBytes</code> should be 8000. The more accurate the value, the more accurate the loaders' overall progress will be.</li>
 * 		<li><strong> requireWithRoot : DisplayObject</strong> - LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this SWFLoader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>var loader:SWFLoader = new SWFLoader("subload.swf", {name:"subloadSWF", requireWithRoot:this.root});</code></li>
 * 		<li><strong> allowMalformedURL : Boolean</strong> - Normally, the URL will be parsed and any variables in the query string (like "?name=test&amp;state=il&amp;gender=m") will be placed into a URLVariables object which is added to the URLRequest. This avoids a few bugs in Flash, but if you need to keep the entire URL intact (no parsing into URLVariables), set <code>allowMalformedURL:true</code>. For example, if your URL has duplicate variables in the query string like <code>http://www.greensock.com/?c=S&amp;c=SE&amp;c=SW</code>, it is technically considered a malformed URL and a URLVariables object can't properly contain all the duplicates, so in this case you'd want to set <code>allowMalformedURL</code> to <code>true</code>.</li>
 * 		<li><strong> autoDispose : Boolean</strong> - When <code>autoDispose</code> is <code>true</code>, the loader will be disposed immediately after it completes (it calls the <code>dispose()</code> method internally after dispatching its <code>COMPLETE</code> event). This will remove any listeners that were defined in the vars object (like onComplete, onProgress, onError, onInit). Once a loader is disposed, it can no longer be found with <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> - it is essentially destroyed but its content is not unloaded (you must call <code>unload()</code> or <code>dispose(true)</code> to unload its content). The default <code>autoDispose</code> value is <code>false</code>.
 * 
 * 		<p>----EVENT HANDLER SHORTCUTS----</p></li>
 * 		<li><strong> onOpen : Function</strong> - A handler function for <code>LoaderEvent.OPEN</code> events which are dispatched when the loader begins loading. Make sure your onOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onInit : Function</strong> - A handler function for <code>LoaderEvent.INIT</code> events which are called when the swf has streamed enough of its content to render the first frame and determine if there are any required LoaderMax-related loaders recognized. It also adds the swf to the ContentDisplay Sprite at this point. Make sure your onInit function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onProgress : Function</strong> - A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.</li>
 * 		<li><strong> onComplete : Function</strong> - A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onCancel : Function</strong> - A handler function for <code>LoaderEvent.CANCEL</code> events which are dispatched when loading is aborted due to either a failure or because another loader was prioritized or <code>cancel()</code> was manually called. Make sure your onCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onError : Function</strong> - A handler function for <code>LoaderEvent.ERROR</code> events which are dispatched whenever the loader experiences an error (typically an IO_ERROR or SECURITY_ERROR). An error doesn't necessarily mean the loader failed, however - to listen for when a loader fails, use the <code>onFail</code> special property. Make sure your onError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onFail : Function</strong> - A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onIOError : Function</strong> - A handler function for <code>LoaderEvent.IO_ERROR</code> events which will also call the onError handler, so you can use that as more of a catch-all whereas <code>onIOError</code> is specifically for LoaderEvent.IO_ERROR events. Make sure your onIOError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onHTTPStatus : Function</strong> - A handler function for <code>LoaderEvent.HTTP_STATUS</code> events. Make sure your onHTTPStatus function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can determine the httpStatus code using the LoaderEvent's <code>target.httpStatus</code> (LoaderItems keep track of their <code>httpStatus</code> when possible, although certain environments prevent Flash from getting httpStatus information).</li>
 * 		<li><strong> onSecurityError : Function</strong> - A handler function for <code>LoaderEvent.SECURITY_ERROR</code> events which onError handles as well, so you can use that as more of a catch-all whereas onSecurityError is specifically for SECURITY_ERROR events. Make sure your onSecurityError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onScriptAccessDenied : Function</strong> - A handler function for <code>LoaderMax.SCRIPT_ACCESS_DENIED</code> events which occur when the swf is loaded from another domain and no crossdomain.xml is in place to grant full script access for things like BitmapData manipulation or integration of LoaderMax data inside the swf, etc. You can also check the <code>scriptAccessDenied</code> property after the swf has loaded. Make sure your function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onUncaughtError : Function</strong> - A handler function for <code>LoaderEvent.UNCAUGHT_ERROR</code> events which are dispatched when the subloaded swf encounters an UncaughtErrorEvent meaning an Error was thrown outside of a try...catch statement. This can be useful when subloading swfs from a 3rd party that may contain errors. However, UNCAUGHT_ERROR events will only be dispatched if the parent swf is published for Flash Player 10.1 or later! See SWFLoader's <code>suppressUncaughtErrors</code> special property if you'd like to have it automatically suppress these errors. The original UncaughtErrorEvent is stored in the LoaderEvent's <code>data</code> property. So, for example, if you'd like to call <code>preventDefault()</code> on that UncaughtErrorEvent, you'd do <code>myLoaderEvent.data.preventDefault()</code>.</li>
 * 		<li><strong> onChildOpen : Function</strong> - A handler function for <code>LoaderEvent.CHILD_OPEN</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) begins loading. Make sure your onChildOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onChildProgress : Function</strong> - A handler function for <code>LoaderEvent.CHILD_PROGRESS</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) dispatches a <code>PROGRESS</code> event. To listen for changes in the SWFLoader's overall progress, use the <code>onProgress</code> special property instead. You can use the LoaderEvent's <code>target.progress</code> to get the child loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>. The LoaderEvent's <code>currentTarget</code> refers to the SWFLoader, so you can check its overall progress with the LoaderEvent's <code>currentTarget.progress</code>. Make sure your onChildProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onChildComplete : Function</strong> - A handler function for <code>LoaderEvent.CHILD_COMPLETE</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) finishes loading successfully. Make sure your onChildComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onChildCancel : Function</strong> - A handler function for <code>LoaderEvent.CHILD_CANCEL</code> events which are dispatched each time loading is aborted on any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) due to either an error or because another loader was prioritized in the queue or because <code>cancel()</code> was manually called on the child loader. Make sure your onChildCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * 		<li><strong> onChildFail : Function</strong> - A handler function for <code>LoaderEvent.CHILD_FAIL</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) fails (and its <code>status</code> chances to <code>LoaderStatus.FAILED</code>). Make sure your onChildFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
 * </ul>
 * 
 * <p><strong>Note:</strong> Using a <code><a href="data/SWFLoaderVars.html">SWFLoaderVars</a></code> instance 
 * instead of a generic object to define your <code>vars</code> is a bit more verbose but provides 
 * code hinting and improved debugging because it enforces strict data typing. Use whichever one you prefer.</p>
 * 
 * <p><code>content</code> data type: <strong><code>com.greensock.loading.display.ContentDisplay</code></strong> (a Sprite). 
 * When the swf has finished loading, the <code>rawContent</code> will be added to the <code>ContentDisplay</code> 
 * Sprite at index 0 using <code>addChildAt()</code>. <code>rawContent</code> refers to the loaded swf's <code>root</code> 
 * unless script access is denied in which case it will be a <code>flash.display.Loader</code> (to avoid security errors).</p>
 * 
 * Example AS3 code:<listing version="3.0">
 import com.greensock.~~;
 import com.greensock.loading.~~;
 
 //create a SWFLoader that will add the content to the display list at position x:50, y:100 when it has loaded:
 var loader:SWFLoader = new SWFLoader("swf/main.swf", {name:"mainSWF", container:this, x:50, y:100, onInit:initHandler, estimatedBytes:9500});
 
 //begin loading
 loader.load();
  
 function initHandler(event:LoaderEvent):void {
 	 //fade the swf in as soon as it inits
 	 TweenLite.from(event.target.content, 1, {alpha:0});
 
 //get a MovieClip named "phoneAnimation_mc" that's on the root of the subloaded swf
 var mc:DisplayObject = loader.getSWFChild("phoneAnimation_mc");
 
 //find the "com.greensock.TweenLite" class that's inside the subloaded swf
 var tweenClass:Class = loader.getClass("com.greensock.TweenLite");
 }
 
 //Or you could put the SWFLoader into a LoaderMax. Create one first...
 var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
 
 //append the SWFLoader and several other loaders
 queue.append( loader );
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
 * @see com.greensock.loading.data.SWFLoaderVars
 * 
 * @author Jack Doyle, jack@greensock.com
 */
#if (js)
@:native("SWFLoader")
#end
extern class SWFLoader extends DisplayObjectLoader
{
	/**
	 * Constructor
	 * 
	 * @param urlOrRequest The url (<code>String</code>) or <code>URLRequest</code> from which the loader should get its content
	 * @param vars An object containing optional configuration details. For example: <code>new SWFLoader("swf/main.swf", {name:"main", container:this, x:100, y:50, alpha:0, autoPlay:false, onComplete:completeHandler, onProgress:progressHandler})</code>.
	 * 
	 * <p>The following special properties can be passed into the constructor via the <code>vars</code> parameter
	 * which can be either a generic object or an <code><a href="data/SWFLoaderVars.html">SWFLoaderVars</a></code> object:</p>
	 * <ul>
	 * 		<li><strong> name : String</strong> - A name that is used to identify the SWFLoader instance. This name can be fed to the <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> methods. This name is also applied to the Sprite that is created to hold the swf (The SWFLoader's <code>content</code> refers to this Sprite). Each loader's name should be unique. If you don't define one, a unique name will be created automatically, like "loader21".</li>
	 * 		<li><strong> container : DisplayObjectContainer</strong> - A DisplayObjectContainer into which the <code>content</code> Sprite should be added immediately.</li>
	 * 		<li><strong> width : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>width</code> property (applied before rotation, scaleX, and scaleY).</li>
	 * 		<li><strong> height : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>height</code> property (applied before rotation, scaleX, and scaleY).</li>
	 * 		<li><strong> centerRegistration : Boolean </strong> - if <code>true</code>, the registration point will be placed in the center of the <code>ContentDisplay</code> Sprite which can be useful if, for example, you want to animate its scale and have it grow/shrink from its center.</li>
	 * 		<li><strong> scaleMode : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>scaleMode</code> controls how the loaded swf will be scaled to fit the area. The following values are recognized (you may use the <code>com.greensock.layout.ScaleMode</code> constants if you prefer):
	 * 			<ul>
	 * 				<li><code>"stretch"</code> (the default) - The swf will fill the width/height exactly.</li>
	 * 				<li><code>"proportionalInside"</code> - The swf will be scaled proportionally to fit inside the area defined by the width/height</li>
	 * 				<li><code>"proportionalOutside"</code> - The swf will be scaled proportionally to completely fill the area, allowing portions of it to exceed the bounds defined by the width/height.</li>
	 * 				<li><code>"widthOnly"</code> - Only the width of the swf will be adjusted to fit.</li>
	 * 				<li><code>"heightOnly"</code> - Only the height of the swf will be adjusted to fit.</li>
	 * 				<li><code>"none"</code> - No scaling of the swf will occur.</li>
	 * 			</ul></li>
	 * 		<li><strong> hAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>hAlign</code> determines how the swf is horizontally aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
	 * 			<ul>
	 * 				<li><code>"center"</code> (the default) - The swf will be centered horizontally in the area</li>
	 * 				<li><code>"left"</code> - The swf will be aligned with the left side of the area</li>
	 * 				<li><code>"right"</code> - The swf will be aligned with the right side of the area</li>
	 * 			</ul></li>
	 * 		<li><strong> vAlign : String </strong> - When a <code>width</code> and <code>height</code> are defined, the <code>vAlign</code> determines how the swf is vertically aligned within that area. The following values are recognized (you may use the <code>com.greensock.layout.AlignMode</code> constants if you prefer):
	 * 			<ul>
	 * 				<li><code>"center"</code> (the default) - The swf will be centered vertically in the area</li>
	 * 				<li><code>"top"</code> - The swf will be aligned with the top of the area</li>
	 * 				<li><code>"bottom"</code> - The swf will be aligned with the bottom of the area</li>
	 * 			</ul></li>
	 * 		<li><strong> crop : Boolean</strong> - When a <code>width</code> and <code>height</code> are defined, setting <code>crop</code> to <code>true</code> will cause the swf to be cropped within that area (by applying a <code>scrollRect</code> for maximum performance) based on its native size (not the bounding box of the swf's current contents). This is typically useful when the <code>scaleMode</code> is <code>"proportionalOutside"</code> or <code>"none"</code> or when the swf contains objects that are positioned off-stage. Any parts of the swf that exceed the dimensions defined by <code>width</code> and <code>height</code> are visually chopped off. Use the <code>hAlign</code> and <code>vAlign</code> special properties to control the vertical and horizontal alignment within the cropped area.</li>
	 * 		<li><strong> x : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>x</code> property (for positioning on the stage).</li>
	 * 		<li><strong> y : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>y</code> property (for positioning on the stage).</li>
	 * 		<li><strong> scaleX : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleX</code> property.</li>
	 * 		<li><strong> scaleY : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>scaleY</code> property.</li>
	 * 		<li><strong> rotation : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>rotation</code> property.</li>
	 * 		<li><strong> alpha : Number</strong> - Sets the <code>ContentDisplay</code>'s <code>alpha</code> property.</li>
	 * 		<li><strong> visible : Boolean</strong> - Sets the <code>ContentDisplay</code>'s <code>visible</code> property.</li>
	 * 		<li><strong> blendMode : String</strong> - Sets the <code>ContentDisplay</code>'s <code>blendMode</code> property.</li>
	 * 		<li><strong> autoPlay : Boolean</strong> - If <code>autoPlay</code> is <code>true</code> (the default), the swf will begin playing immediately when the <code>INIT</code> event fires. To prevent this behavior, set <code>autoPlay</code> to <code>false</code> which will also mute the swf until the SWFLoader completes. This only calls <code>stop()</code> on the main timeline but it does not prevent scripted animations.</li>
	 * 		<li><strong> bgColor : uint </strong> - When a <code>width</code> and <code>height</code> are defined, a rectangle will be drawn inside the <code>ContentDisplay</code> Sprite immediately in order to ease the development process. It is transparent by default, but you may define a <code>bgAlpha</code> if you prefer.</li>
	 * 		<li><strong> bgAlpha : Number </strong> - Controls the alpha of the rectangle that is drawn when a <code>width</code> and <code>height</code> are defined.</li>
	 * 		<li><strong> context : LoaderContext</strong> - To control things like the ApplicationDomain, SecurityDomain, and whether or not a policy file is checked, define a <code>LoaderContext</code> object. The default context is null when running locally and <code>new LoaderContext(true, new ApplicationDomain(ApplicationDomain.currentDomain), SecurityDomain.currentDomain)</code> when running remotely in order to avoid common security sandbox errors (see Adobe's LoaderContext documentation for details and precautions). Please make sure that if you load swfs from another domain that you have a crossdomain.xml file installed on that remote server that grants your swf access rights (see Adobe's docs for crossdomain.xml details). Again, if you want to impose security restrictions on the loaded swf, please define your own LoaderContext.</li>
	 * 		<li><strong> suppressInitReparentEvents : Boolean</strong> - If <code>true</code>, the SWFLoader will suppress the <code>REMOVED_FROM_STAGE</code> and <code>ADDED_TO_STAGE</code> events that are normally dispatched when the subloaded swf is reparented into the ContentDisplay (this always happens in Flash when any DisplayObject that's in the display list gets reparented - SWFLoader just circumvents it by default initially to avoid common problems that could arise if the child swf is coded a certain way). For example, if your subloaded swf has this code: <code>addEventListener(Event.REMOVED_FROM_STAGE, disposeEverything)</code> and you set <code>suppressInitReparentEvents</code> to <code>false</code>, <code>disposeEverything()</code> would get called as soon as the swf inits (assuming the ContentDisplay is in the display list).</li>
	 * 		<li><strong> integrateProgress : Boolean</strong> - By default, a SWFLoader instance will automatically look for LoaderMax loaders in the swf when it initializes. Every loader found with a <code>requireWithRoot</code> parameter set to that swf's <code>root</code> will be integrated into the SWFLoader's overall progress. The SWFLoader's <code>COMPLETE</code> event won't fire until all such loaders are also complete. If you prefer NOT to integrate the subloading loaders into the SWFLoader's overall progress, set <code>integrateProgress</code> to <code>false</code>.</li>
	 * 		<li><strong> suppressUncaughtErrors : Boolean</strong> - To automatically suppress uncaught errors in the subloaded swf (errors that are thrown outside of a try...catch statement), set <code>suppressUncaughtErrors</code> to <code>true</code>, but please note that this will ONLY work if the parent swf is published to Flash Player 10.1 or later. Suppressing the UncaughtErrorEvent simply means calling its <code>preventDefault()</code> and <code>stopImmediatePropagation()</code> methods as well as preventing it from bubbling up to its parent LoaderMax/SWFLoader anscestors. If you'd rather listen for these events so that you can handle them yourself, listen for the <code>LoaderEvent.UNCAUGHT_ERROR</code> event. The original UncaughtErrorEvent instance will be stored in the LoaderEvent's <code>data</code> property.</li>
	 * 		<li><strong> alternateURL : String</strong> - If you define an <code>alternateURL</code>, the loader will initially try to load from its original <code>url</code> and if it fails, it will automatically (and permanently) change the loader's <code>url</code> to the <code>alternateURL</code> and try again. Think of it as a fallback or backup <code>url</code>. It is perfectly acceptable to use the same <code>alternateURL</code> for multiple loaders (maybe a default image for various ImageLoaders for example).</li>
	 * 		<li><strong> noCache : Boolean</strong> - If <code>noCache</code> is <code>true</code>, a "gsCacheBusterID" parameter will be appended to the url with a random set of numbers to prevent caching (don't worry, this info is ignored when you <code>getLoader()</code> or <code>getContent()</code> by url and when you're running locally)</li>
	 * 		<li><strong> estimatedBytes : uint</strong> - Initially, the loader's <code>bytesTotal</code> is set to the <code>estimatedBytes</code> value (or <code>LoaderMax.defaultEstimatedBytes</code> if one isn't defined). Then, when the swf initializes and has been analyzed enough to determine the size of any nested loaders that were found inside the swf with their <code>requireWithRoot</code> set to that swf's <code>root</code>, it will adjust the <code>bytesTotal</code> accordingly. Setting <code>estimatedBytes</code> is optional, but it provides a way to avoid situations where the <code>progress</code> and <code>bytesTotal</code> values jump around as SWFLoader recognizes nested loaders in the swf and audits their size. The <code>estimatedBytes</code> value should include all nested loaders as well, so if your swf file itself is 2000 bytes and it has 3 nested ImageLoaders, each loading a 2000-byte image, your SWFLoader's <code>estimatedBytes</code> should be 8000. The more accurate the value, the more accurate the loaders' overall progress will be.</li>
	 * 		<li><strong> requireWithRoot : DisplayObject</strong> - LoaderMax supports <i>subloading</i>, where an object can be factored into a parent's loading progress. If you want LoaderMax to require this SWFLoader as part of its parent SWFLoader's progress, you must set the <code>requireWithRoot</code> property to your swf's <code>root</code>. For example, <code>var loader:SWFLoader = new SWFLoader("subload.swf", {name:"subloadSWF", requireWithRoot:this.root});</code></li>
	 * 		<li><strong> allowMalformedURL : Boolean</strong> - Normally, the URL will be parsed and any variables in the query string (like "?name=test&amp;state=il&amp;gender=m") will be placed into a URLVariables object which is added to the URLRequest. This avoids a few bugs in Flash, but if you need to keep the entire URL intact (no parsing into URLVariables), set <code>allowMalformedURL:true</code>. For example, if your URL has duplicate variables in the query string like <code>http://www.greensock.com/?c=S&amp;c=SE&amp;c=SW</code>, it is technically considered a malformed URL and a URLVariables object can't properly contain all the duplicates, so in this case you'd want to set <code>allowMalformedURL</code> to <code>true</code>.</li>
	 * 		<li><strong> autoDispose : Boolean</strong> - When <code>autoDispose</code> is <code>true</code>, the loader will be disposed immediately after it completes (it calls the <code>dispose()</code> method internally after dispatching its <code>COMPLETE</code> event). This will remove any listeners that were defined in the vars object (like onComplete, onProgress, onError, onInit). Once a loader is disposed, it can no longer be found with <code>LoaderMax.getLoader()</code> or <code>LoaderMax.getContent()</code> - it is essentially destroyed but its content is not unloaded (you must call <code>unload()</code> or <code>dispose(true)</code> to unload its content). The default <code>autoDispose</code> value is <code>false</code>.
	 * 
	 * 		<p>----EVENT HANDLER SHORTCUTS----</p></li>
	 * 		<li><strong> onOpen : Function</strong> - A handler function for <code>LoaderEvent.OPEN</code> events which are dispatched when the loader begins loading. Make sure your onOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onInit : Function</strong> - A handler function for <code>LoaderEvent.INIT</code> events which are called when the swf has streamed enough of its content to render the first frame and determine if there are any required LoaderMax-related loaders recognized. It also adds the swf to the ContentDisplay Sprite at this point. Make sure your onInit function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onProgress : Function</strong> - A handler function for <code>LoaderEvent.PROGRESS</code> events which are dispatched whenever the <code>bytesLoaded</code> changes. Make sure your onProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can use the LoaderEvent's <code>target.progress</code> to get the loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>.</li>
	 * 		<li><strong> onComplete : Function</strong> - A handler function for <code>LoaderEvent.COMPLETE</code> events which are dispatched when the loader has finished loading successfully. Make sure your onComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onCancel : Function</strong> - A handler function for <code>LoaderEvent.CANCEL</code> events which are dispatched when loading is aborted due to either a failure or because another loader was prioritized or <code>cancel()</code> was manually called. Make sure your onCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onError : Function</strong> - A handler function for <code>LoaderEvent.ERROR</code> events which are dispatched whenever the loader experiences an error (typically an IO_ERROR or SECURITY_ERROR). An error doesn't necessarily mean the loader failed, however - to listen for when a loader fails, use the <code>onFail</code> special property. Make sure your onError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onFail : Function</strong> - A handler function for <code>LoaderEvent.FAIL</code> events which are dispatched whenever the loader fails and its <code>status</code> changes to <code>LoaderStatus.FAILED</code>. Make sure your onFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onIOError : Function</strong> - A handler function for <code>LoaderEvent.IO_ERROR</code> events which will also call the onError handler, so you can use that as more of a catch-all whereas <code>onIOError</code> is specifically for LoaderEvent.IO_ERROR events. Make sure your onIOError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onHTTPStatus : Function</strong> - A handler function for <code>LoaderEvent.HTTP_STATUS</code> events. Make sure your onHTTPStatus function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>). You can determine the httpStatus code using the LoaderEvent's <code>target.httpStatus</code> (LoaderItems keep track of their <code>httpStatus</code> when possible, although certain environments prevent Flash from getting httpStatus information).</li>
	 * 		<li><strong> onSecurityError : Function</strong> - A handler function for <code>LoaderEvent.SECURITY_ERROR</code> events which onError handles as well, so you can use that as more of a catch-all whereas onSecurityError is specifically for SECURITY_ERROR events. Make sure your onSecurityError function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onScriptAccessDenied : Function</strong> - A handler function for <code>LoaderMax.SCRIPT_ACCESS_DENIED</code> events which occur when the swf is loaded from another domain and no crossdomain.xml is in place to grant full script access for things like BitmapData manipulation or integration of LoaderMax data inside the swf, etc. You can also check the <code>scriptAccessDenied</code> property after the swf has loaded. Make sure your function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onUncaughtError : Function</strong> - A handler function for <code>LoaderEvent.UNCAUGHT_ERROR</code> events which are dispatched when the subloaded swf encounters an UncaughtErrorEvent meaning an Error was thrown outside of a try...catch statement. This can be useful when subloading swfs from a 3rd party that may contain errors. However, UNCAUGHT_ERROR events will only be dispatched if the parent swf is published for Flash Player 10.1 or later! See SWFLoader's <code>suppressUncaughtErrors</code> special property if you'd like to have it automatically suppress these errors. The original UncaughtErrorEvent is stored in the LoaderEvent's <code>data</code> property. So, for example, if you'd like to call <code>preventDefault()</code> on that UncaughtErrorEvent, you'd do <code>myLoaderEvent.data.preventDefault()</code>.</li>
	 * 		<li><strong> onChildOpen : Function</strong> - A handler function for <code>LoaderEvent.CHILD_OPEN</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) begins loading. Make sure your onChildOpen function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onChildProgress : Function</strong> - A handler function for <code>LoaderEvent.CHILD_PROGRESS</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) dispatches a <code>PROGRESS</code> event. To listen for changes in the SWFLoader's overall progress, use the <code>onProgress</code> special property instead. You can use the LoaderEvent's <code>target.progress</code> to get the child loader's progress value or use its <code>target.bytesLoaded</code> and <code>target.bytesTotal</code>. The LoaderEvent's <code>currentTarget</code> refers to the SWFLoader, so you can check its overall progress with the LoaderEvent's <code>currentTarget.progress</code>. Make sure your onChildProgress function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onChildComplete : Function</strong> - A handler function for <code>LoaderEvent.CHILD_COMPLETE</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) finishes loading successfully. Make sure your onChildComplete function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onChildCancel : Function</strong> - A handler function for <code>LoaderEvent.CHILD_CANCEL</code> events which are dispatched each time loading is aborted on any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) due to either an error or because another loader was prioritized in the queue or because <code>cancel()</code> was manually called on the child loader. Make sure your onChildCancel function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * 		<li><strong> onChildFail : Function</strong> - A handler function for <code>LoaderEvent.CHILD_FAIL</code> events which are dispatched each time any nested LoaderMax-related loaders (active ones that the SWFLoader found inside the subloading swf that had their <code>requireWithRoot</code> set to its <code>root</code>) fails (and its <code>status</code> chances to <code>LoaderStatus.FAILED</code>). Make sure your onChildFail function accepts a single parameter of type <code>LoaderEvent</code> (<code>com.greensock.events.LoaderEvent</code>).</li>
	 * </ul>
	 * @see com.greensock.loading.data.SWFLoaderVars
	 */
	public function new(urlOrRequest:Dynamic, vars:Dynamic = null);

	/**
	 * Searches the loaded swf (and any of its subloaded swfs that were loaded using SWFLoader) for a particular
	 * class by name. For example, if the swf contains a class named "com.greensock.TweenLite", you can get a 
	 * reference to that class like:
	 * 
	 * <listing version="3.0">
var tweenLite:Class = loader.getClass("com.greensock.TweenLite");
//then you can create an instance of TweenLite like:
var tween:Object = new tweenLite(mc, 1, {x:100});
</listing>
	 * 
	 * @param className The full name of the class, like "com.greensock.TweenLite".
	 * @return The class associated with the <code>className</code>
	 */
	public function getClass(className:String):Class<Dynamic>;
	
	/**
	 * Finds a DisplayObject that's on the <code>root</code> of the loaded SWF by name. For example,
	 * you could put a MovieClip with an instance name of "phoneAnimation_mc" on the stage (along with
	 * any other objects of course) and then when you load that swf you could use 
	 * <code>loader.getSWFChild("phoneAnimation_mc")</code> to get that MovieClip. It would be 
	 * similar to doing <code>(loader.rawContent as DisplayObjectContainer).getChildByName("phoneAnimation_mc")</code>
	 * but in a more concise way that doesn't require checking to see if the rawContent is null. <code>getSWFChild()</code>
	 * will return <code>null</code> if the content hasn't loaded yet or if <code>scriptAccessDenied</code> is <code>true</code>.
	 * 
	 * @param name The name of the child DisplayObject that is located at the <code>root</code> of the swf.
	 * @return The DisplayObject with the specified name. Returns <code>null</code> if the content hasn't loaded yet or if <code>scriptAccessDenied</code> is <code>true</code>.
	 */
	public function getSWFChild(name:String):DisplayObject;
	
	/**
	 * @private
	 * Finds a particular loader inside any active LoaderMax instances that were discovered in the subloaded swf 
	 * which had their <code>requireWithRoot</code> set to the swf's root. This is only useful in situations 
	 * where the swf contains other loaders that are required. 
	 * 
	 * @param nameOrURL The name or url associated with the loader that should be found.
	 * @return The loader associated with the name or url. Returns <code>null</code> if none were found.
	 */
	public function getLoader(nameOrURL:String):Dynamic;
	
	/**
	 * @private
	 * Finds a particular loader's content from inside any active LoaderMax instances that were discovered in the 
	 * subloaded swf which had their <code>requireWithRoot</code> set to the swf's root. This is only useful 
	 * in situations where the swf contains other loaders that are required. 
	 * 
	 * @param nameOrURL The name or url associated with the loader whose content should be found.
	 * @return The content associated with the name or url. Returns <code>null</code> if none was found.
	 */
	public function getContent(nameOrURL:String):Dynamic;
	
	/**
	 * Returns and array of all LoaderMax-related loaders (if any) that were found inside the swf and 
	 * had their <code>requireWithRoot</code> special vars property set to the swf's root. For example, 
	 * if the following code was run on the first frame of the swf, it would be identified as a child
	 * of this SWFLoader: <p><code>
	 * 
	 * var loader:ImageLoader = new ImageLoader("1.jpg", {requireWithRoot:this.root});</code></p>
	 * 
	 * <p>Even if loaders are created later (not on frame 1), as long as their <code>requireWithRoot</code> 
	 * points to this swf's root, the loader(s) will be considered a child of this SWFLoader and will be 
	 * returned in the array that <code>getChildren()</code> creates. Beware, however, that by default 
	 * child loaders are integrated into the SWFLoader's <code>progress</code>, so if the swf finishes 
	 * loading and then a while later a loader is created inside that swf that has its <code>requireWithRoot</code>
	 * set to the swf's root, at that point the SWFLoader's <code>progress</code> would no longer be 1 (it would
	 * be less) but the SWFLoader's <code>status</code> remains unchanged.</p>
	 * 
	 * <p>No child loader can be found until the SWFLoader's INIT event is dispatched, meaning the first
	 * frame of the swf has loaded and instantiated. </p>
	 * 
	 * @param includeNested If <code>true</code>, loaders that are nested inside child LoaderMax, XMLLoader, or SWFLoader instances will be included in the returned array as well. The default is <code>false</code>.
	 * @param omitLoaderMaxes If <code>true</code>, no LoaderMax instances will be returned in the array; only LoaderItems like ImageLoaders, XMLLoaders, SWFLoaders, MP3Loaders, etc. The default is <code>false</code>. 
	 * @return An array of loaders.
	 */
	public function getChildren(includeNested:Bool = false, omitLoaderMaxes:Bool = false):Array<Dynamic>;
}

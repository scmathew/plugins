import { _ as _export_sfc, c as createElementBlock, o as openBlock, a as createStaticVNode } from "./app.22c2e13e.js";
var _imports_0 = "/assets/developer-mode.22f57523.png";
var _imports_1 = "/assets/add-a-local-plugin.e33144a3.png";
var _imports_2 = "/assets/local-plugin-added.c7ab524e.png";
var _imports_3 = "/assets/hello-world-alert.981672ef.png";
var _imports_4 = "/assets/help-screen.f8d5000b.png";
const __pageData = `{"title":"5 Minute Quick Start","description":"","frontmatter":{},"headers":[{"level":2,"title":"Hello World Plugin","slug":"hello-world-plugin"},{"level":2,"title":"Verifying","slug":"verifying"},{"level":2,"title":"What's Next","slug":"what-s-next"}],"relativePath":"quick-start.md"}`;
const _sfc_main = {};
const _hoisted_1 = /* @__PURE__ */ createStaticVNode('<h1 id="_5-minute-quick-start" tabindex="-1">5 Minute Quick Start <a class="header-anchor" href="#_5-minute-quick-start" aria-hidden="true">#</a></h1><h2 id="hello-world-plugin" tabindex="-1">Hello World Plugin <a class="header-anchor" href="#hello-world-plugin" aria-hidden="true">#</a></h2><p>Let&#39;s create a simple &quot;Hello World&quot; plugin that responds with a JavaScript alert &quot;Hello, Developer!&quot; when a user says <span class="voice-cmd">hello world</span>.</p><ol><li>Install the LipSurf CLI.</li></ol><div class="language-shell"><pre><code><span class="token function">yarn</span> global <span class="token function">add</span> @lipsurf/cli\n</code></pre></div><ol start="2"><li>Scaffold a project.</li></ol><div class="language-shell"><pre><code>lipsurf-cli init HelloWorld <span class="token operator">&amp;&amp;</span> <span class="token builtin class-name">cd</span> lipsurf-plugin-helloworld\n</code></pre></div><p>The most important bit is the plugin created in <code>src/HelloWorld/HelloWorld.ts</code>. It should be something like this:</p><div class="language-ts"><pre><code><span class="token comment">// lipsurf-plugin-helloworld/src/HelloWorld/HelloWorld.ts</span>\n<span class="token comment">/// &lt;reference types=&quot;@lipsurf/types/extension&quot;/&gt;</span>\n<span class="token keyword">declare</span> <span class="token keyword">const</span> PluginBase<span class="token operator">:</span> IPluginBase<span class="token punctuation">;</span>\n\n<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token operator">&lt;</span>IPluginBase <span class="token operator">&amp;</span> IPlugin<span class="token operator">&gt;</span><span class="token punctuation">{</span>\n  <span class="token operator">...</span>PluginBase<span class="token punctuation">,</span>\n  <span class="token operator">...</span><span class="token punctuation">{</span>\n    niceName<span class="token operator">:</span> <span class="token string">&quot;Hello World&quot;</span><span class="token punctuation">,</span>\n    description<span class="token operator">:</span> <span class="token string">&#39;A &quot;hello world&quot; plugin.&#39;</span><span class="token punctuation">,</span>\n    <span class="token comment">// a RegEx that must match against the current tab&#39;s url for the plugin to be active (all of it&#39;s commands minus global commands)</span>\n    match<span class="token operator">:</span> <span class="token regex"><span class="token regex-delimiter">/</span><span class="token regex-source language-regex">.*</span><span class="token regex-delimiter">/</span></span><span class="token punctuation">,</span>\n    version<span class="token operator">:</span> <span class="token string">&quot;1.0.0&quot;</span><span class="token punctuation">,</span>\n    apiVersion<span class="token operator">:</span> <span class="token number">2</span><span class="token punctuation">,</span>\n    commands<span class="token operator">:</span> <span class="token punctuation">[</span>\n      <span class="token punctuation">{</span>\n        name<span class="token operator">:</span> <span class="token string">&quot;Respond&quot;</span><span class="token punctuation">,</span>\n        description<span class="token operator">:</span>\n          <span class="token string">&quot;Respond with something incredibly insightful to the user.&quot;</span><span class="token punctuation">,</span>\n        <span class="token comment">// what the user actually has to say to run this command</span>\n        match<span class="token operator">:</span> <span class="token string">&quot;hello world&quot;</span><span class="token punctuation">,</span>\n        <span class="token comment">// the js that&#39;s run on the page</span>\n        <span class="token function-variable function">pageFn</span><span class="token operator">:</span> <span class="token keyword">function</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>\n          <span class="token function">alert</span><span class="token punctuation">(</span><span class="token string">&quot;Hello, Developer!&quot;</span><span class="token punctuation">)</span><span class="token punctuation">;</span>\n        <span class="token punctuation">}</span><span class="token punctuation">,</span>\n      <span class="token punctuation">}</span><span class="token punctuation">,</span>\n    <span class="token punctuation">]</span><span class="token punctuation">,</span>\n  <span class="token punctuation">}</span><span class="token punctuation">,</span>\n<span class="token punctuation">}</span><span class="token punctuation">;</span>\n</code></pre></div><p>The meat of the plugin lives in the array of commands. Each <a href="/api-reference/command.html">Command</a> object has a <code>match</code> property for what the user needs to say to run it, a <code>pageFn</code> property for the code that&#39;s actually run and a bunch of meta properties like <code>name</code>, <code>description</code> etc.</p><div class="tip custom-block"><p class="custom-block-title">NOTE</p><p>If you change the plugin id, &quot;HelloWorld&quot; in this case, make sure to change the directory name as well so it matches.</p></div><ol start="3"><li>Compile our TypeScript file and make the LipSurf plugin.</li></ol><div class="language-shell"><pre><code><span class="token function">yarn</span> <span class="token function">watch</span>\n</code></pre></div><div class="tip custom-block"><p class="custom-block-title">NOTE</p><p>This will watch our *.ts files for changes and compile them to JavaScript, and finally a LipSurf plugin whenever a change is detected \u{1F603}</p></div><ol start="4"><li><p>Time to <em>load &#39;er up</em>. Open up Google Chrome and right click the LipSurf icon then &quot;Options&quot;.</p></li><li><p>Turn on &quot;Developer mode&quot; by checking its box.</p></li></ol><p><img src="' + _imports_0 + '" alt=""></p><ol start="6"><li>Click &quot;Load a Local Plugin&quot; under &quot;Plugins&quot; and navigate to the compiled <code>.ls</code> file <code>dist/HelloWorld.1-0-0.0.ls</code>.</li></ol><div class="tip custom-block"><p class="custom-block-title">NOTE</p><p>The <code>ls</code> extension is special for LipSurf extensions. It&#39;s basically 3 JavaScript files rolled into one.</p></div><p><img src="' + _imports_1 + '" alt=""></p><br><p>\u{1F3C1} \xA0\xA0 <strong>That&#39;s it!</strong> \xA0\xA0 \u{1F3C1}</p><br><hr><h2 id="verifying" tabindex="-1">Verifying <a class="header-anchor" href="#verifying" aria-hidden="true">#</a></h2><p>After a few seconds your plugin should appear in the plugins list if there were no installation problems.</p><div class="tip custom-block"><p class="custom-block-title">TIP</p><p>Check the developer console (&lt;F12&gt;) for hints if there are installation issues.</p></div><p><img src="' + _imports_2 + '" alt=""></p><p>Now try saying <span class="voice-cmd">hello world</span> in any tab (since this plugin has a catch-all <code>/.*/</code> regex for the <code>match</code> property it should run on any non-special URL).</p><p>If everything went smoothly, you should see a JavaScript alert like this one:</p><p><img src="' + _imports_3 + '" alt=""></p><hr><p>You can also say <span class="voice-cmd">help</span> to see your new command listed in the auto-generated help overlay.</p><p><img src="' + _imports_4 + '" alt=""></p><hr><h2 id="what-s-next" tabindex="-1">What&#39;s Next <a class="header-anchor" href="#what-s-next" aria-hidden="true">#</a></h2><p>If you think that&#39;s nifty, we&#39;ve just scratched the surface! LipSurf can handle homophones, dynamic match commands, multiple languages and more!</p><p>Check out the &quot;Advanced&quot; topics after you take a deep breath and regain your composure from all this excitement!</p>', 37);
const _hoisted_38 = [
  _hoisted_1
];
function _sfc_render(_ctx, _cache, $props, $setup, $data, $options) {
  return openBlock(), createElementBlock("div", null, _hoisted_38);
}
var quickStart = /* @__PURE__ */ _export_sfc(_sfc_main, [["render", _sfc_render]]);
export { __pageData, quickStart as default };

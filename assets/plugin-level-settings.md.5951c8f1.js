import{_ as n,c as s,o as a,a as t}from"./app.1ef87986.js";const h='{"title":"Plugin-level Settings","description":"","frontmatter":{},"headers":[],"relativePath":"plugin-level-settings.md"}',e={},p=t(`<h1 id="plugin-level-settings" tabindex="-1">Plugin-level Settings <a class="header-anchor" href="#plugin-level-settings" aria-hidden="true">#</a></h1><p>You can have settings on the plugin-level. This allows plugins to persist their own data, share data with other plugins or for the user to configure plugins (using the LipSurf options under the plugin&#39;s settings).</p><p>Example use cases:</p><ul><li>Search plugin that lets you choose a search engine.</li><li>Tabs and windows plugin that lets you choose the default URL for new tabs.</li></ul><p>A top-level plugin property determines settings:</p><div class="language-ts"><pre><code>    <span class="token comment">// page to load on new tab and new window</span>
    <span class="token operator">...</span>
    settings<span class="token operator">:</span> <span class="token punctuation">[</span>
        <span class="token punctuation">{</span>
            name<span class="token operator">:</span> <span class="token string">&#39;New Tab/Window URL&#39;</span><span class="token punctuation">,</span>
            <span class="token comment">// determines the widget to use in the LipSurf options</span>
            type<span class="token operator">:</span> <span class="token string">&#39;url&#39;</span><span class="token punctuation">,</span>
            <span class="token keyword">default</span><span class="token operator">:</span> <span class="token string">&#39;https://www.google.com&#39;</span><span class="token punctuation">,</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token operator">...</span>
</code></pre></div><p>Settings can be set or gotten within the plugin like so:</p><div class="language-ts"><pre><code><span class="token keyword">await</span> PluginBase<span class="token punctuation">.</span><span class="token function">setPluginOption</span><span class="token punctuation">(</span><span class="token string">&#39;TabsAndWindows&#39;</span><span class="token punctuation">,</span> <span class="token string">&#39;New Tab/Window URL&#39;</span><span class="token punctuation">,</span> <span class="token string">&#39;www.duckduckgo.com&#39;</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
PluginBase<span class="token punctuation">.</span><span class="token function">getPluginOption</span><span class="token punctuation">(</span><span class="token string">&#39;TabsAndWindows&#39;</span><span class="token punctuation">,</span> <span class="token string">&#39;New Tab/Window URL&#39;</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre></div><p>See also:</p><ul><li><a href="./api-reference/plugin.html#setpluginoption"><code>setPluginOption</code></a></li><li><a href="./api-reference/plugin.html#getpluginoption"><code>getPluginOption</code></a></li></ul>`,10),o=[p];function i(l,c,u,r,g,d){return a(),s("div",null,o)}var w=n(e,[["render",i]]);export{h as __pageData,w as default};

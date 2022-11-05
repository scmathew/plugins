import{_ as n,c as a,o as s,a as t}from"./app.1ef87986.js";const h='{"title":"Match Patterns","description":"","frontmatter":{},"headers":[{"level":2,"title":"Compact Form","slug":"compact-form"},{"level":2,"title":"Wildcard Matching","slug":"wildcard-matching"},{"level":2,"title":"Numeral Matching","slug":"numeral-matching"},{"level":2,"title":"Match Function","slug":"match-function"}],"relativePath":"dynamic-matching.md"}',o={},e=t(`<h1 id="match-patterns" tabindex="-1">Match Patterns <a class="header-anchor" href="#match-patterns" aria-hidden="true">#</a></h1><div class="warning custom-block"><p class="custom-block-title">NOTE</p><p>It&#39;s recommended that you go through the <a href="/quick-start.html">5 Minute Quick Start</a> first to understand how to create and install your plugin.</p></div><h2 id="compact-form" tabindex="-1">Compact Form <a class="header-anchor" href="#compact-form" aria-hidden="true">#</a></h2><p>Instead of writing out potentially 100s of forms for a command&#39;s <a href="/api-reference/command.html#match">match</a> property, you can use compact form syntax.</p><p>eg. <code>&#39;[delete/remove] [/the ]previous [word/# words]&#39;</code> expands to:</p><ul><li>delete previous word</li><li>remove previous word</li><li>delete the previous word</li><li>remove the previous word</li><li>delete previous # words</li><li>remove previous # words</li><li>delete the previous # words</li><li>remove the previous # words</li></ul><div class="tip custom-block"><p class="custom-block-title">TIPS</p><ul><li>You cannot nest brackets.</li><li>Priority is respected by the order in the brackets.</li></ul></div><h2 id="wildcard-matching" tabindex="-1">Wildcard Matching <a class="header-anchor" href="#wildcard-matching" aria-hidden="true">#</a></h2><p>What if we want a plugin that accepts an arbitrary argument after some key words (AKA a slot)?</p><p>Let&#39;s make a plugin that shows the weather for any city when user says: <span class="voice-cmd">weather for [city name]</span> (eg. <span class="voice-cmd">weather for Chiang Mai</span>)</p><p><em>Easy peasy.</em></p><p>Use <code>*</code> in your <code>match</code> string to greedily match any words.</p><div class="language-ts"><div class="highlight-lines"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><div class="highlighted">\xA0</div><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></div><pre><code><span class="token comment">/// &lt;reference types=&quot;@lipsurf/types/extension&quot;/&gt;</span>
<span class="token keyword">declare</span> <span class="token keyword">const</span> PluginBase<span class="token operator">:</span> IPluginBase<span class="token punctuation">;</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token operator">&lt;</span>IPluginBase <span class="token operator">&amp;</span> IPlugin<span class="token operator">&gt;</span><span class="token punctuation">{</span>
  <span class="token operator">...</span>PluginBase<span class="token punctuation">,</span>
  <span class="token operator">...</span><span class="token punctuation">{</span>
    niceName<span class="token operator">:</span> <span class="token string">&quot;Weather&quot;</span><span class="token punctuation">,</span>
    match<span class="token operator">:</span> <span class="token regex"><span class="token regex-delimiter">/</span><span class="token regex-source language-regex">.*\\.accuweather\\.com</span><span class="token regex-delimiter">/</span></span><span class="token punctuation">,</span>
    version<span class="token operator">:</span> <span class="token string">&quot;1.0.0&quot;</span><span class="token punctuation">,</span>
    apiVersion<span class="token operator">:</span> <span class="token number">2</span><span class="token punctuation">,</span>
    commands<span class="token operator">:</span> <span class="token punctuation">[</span>
      <span class="token punctuation">{</span>
        name<span class="token operator">:</span> <span class="token string">&quot;Check the Weather&quot;</span><span class="token punctuation">,</span>
        description<span class="token operator">:</span> <span class="token string">&quot;Check the weather for a given city.&quot;</span><span class="token punctuation">,</span>
        <span class="token comment">// say it on any page (not just accuweather domain)</span>
        global<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
        match<span class="token operator">:</span> <span class="token string">&quot;[weather/forecast] [for/in] *&quot;</span><span class="token punctuation">,</span>
        <span class="token function-variable function">pageFn</span><span class="token operator">:</span> <span class="token keyword">async</span> <span class="token punctuation">(</span>transcript<span class="token punctuation">,</span> <span class="token punctuation">{</span> preTs<span class="token punctuation">,</span> normTs <span class="token punctuation">}</span><span class="token operator">:</span> TsData<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
          <span class="token comment">// https://api.accuweather.com/locations/v1/cities/autocomplete?q=chiang%20mai&amp;apikey=d41dfd5e8a1748d0970cba6637647d96&amp;language=en-us&amp;get_param=value</span>
          <span class="token comment">// ex resp: [{&quot;Version&quot;:1,&quot;Key&quot;:&quot;317505&quot;,&quot;Type&quot;:&quot;City&quot;,&quot;Rank&quot;:41,&quot;LocalizedName&quot;:&quot;Chiang Mai&quot;,&quot;Country&quot;:{&quot;ID&quot;:&quot;TH&quot;,&quot;LocalizedName&quot;:&quot;Thailand&quot;},&quot;AdministrativeArea&quot;:{&quot;ID&quot;:&quot;50&quot;,&quot;LocalizedName&quot;:&quot;Chiang Mai&quot;}}]</span>
          <span class="token comment">// https://www.accuweather.com/en/th/chiang-mai/317505/weather-forecast/317505</span>
          <span class="token keyword">const</span> resp <span class="token operator">=</span> <span class="token keyword">await</span> <span class="token punctuation">(</span>
            <span class="token keyword">await</span> window<span class="token punctuation">.</span><span class="token function">fetch</span><span class="token punctuation">(</span>
              <span class="token template-string"><span class="token template-punctuation string">\`</span><span class="token string">https://api.accuweather.com/locations/v1/cities/autocomplete?q=</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">\${</span>preTs<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">&amp;apikey=d41dfd5e8a1748d0970cba6637647d96&amp;language=en-us&amp;get_param=value</span><span class="token template-punctuation string">\`</span></span>
            <span class="token punctuation">)</span>
          <span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">json</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
          <span class="token keyword">let</span> cityId <span class="token operator">=</span> resp<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span>Key<span class="token punctuation">;</span>
          <span class="token keyword">let</span> countryCode <span class="token operator">=</span> resp<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span>Country<span class="token punctuation">.</span><span class="token constant">ID</span><span class="token punctuation">.</span><span class="token function">toLowerCase</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
          <span class="token keyword">let</span> cityName <span class="token operator">=</span> resp<span class="token punctuation">[</span><span class="token number">0</span><span class="token punctuation">]</span><span class="token punctuation">.</span>LocalizedName<span class="token punctuation">.</span><span class="token function">replace</span><span class="token punctuation">(</span><span class="token string">&quot; &quot;</span><span class="token punctuation">,</span> <span class="token string">&quot;-&quot;</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
          window<span class="token punctuation">.</span>location<span class="token punctuation">.</span>href <span class="token operator">=</span> <span class="token template-string"><span class="token template-punctuation string">\`</span><span class="token string">https://www.accuweather.com/en/</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">\${</span>countryCode<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">/</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">\${</span>cityName<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">/</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">\${</span>cityId<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">/weather-forecast/</span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">\${</span>cityId<span class="token interpolation-punctuation punctuation">}</span></span><span class="token template-punctuation string">\`</span></span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
      <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
</code></pre></div><h2 id="numeral-matching" tabindex="-1">Numeral Matching <a class="header-anchor" href="#numeral-matching" aria-hidden="true">#</a></h2><p><em>Ain&#39;t nothin&#39; to it.</em></p><p>Use <code>#</code> in your <code>match</code> string to match numerals or ordinals including ones that are spelled-out (ie. <span class="voice-cmd">four-thousand</span>)</p><p>Let&#39;s write a plugin that opens a tab with URL x for y minutes so that we can limit it&#39;s time wasting-ness. This might be useful if we need to check Facebook but don&#39;t want to get sucked into the feed for too long.</p><div class="language-ts"><div class="highlight-lines"><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><div class="highlighted">\xA0</div><br><br><br><br><br><br><br><br></div><pre><code><span class="token comment">/// &lt;reference types=&quot;@lipsurf/types/extension&quot;/&gt;</span>
<span class="token keyword">declare</span> <span class="token keyword">const</span> PluginBase<span class="token operator">:</span> IPluginBase<span class="token punctuation">;</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token operator">&lt;</span>IPluginBase <span class="token operator">&amp;</span> IPlugin<span class="token operator">&gt;</span><span class="token punctuation">{</span>
  <span class="token operator">...</span>PluginBase<span class="token punctuation">,</span>
  <span class="token operator">...</span><span class="token punctuation">{</span>
    niceName<span class="token operator">:</span> <span class="token string">&quot;Anti-procrastination&quot;</span><span class="token punctuation">,</span>
    description<span class="token operator">:</span> <span class="token string">&quot;Helpers for overcoming procrastination.&quot;</span><span class="token punctuation">,</span>
    match<span class="token operator">:</span> <span class="token regex"><span class="token regex-delimiter">/</span><span class="token regex-source language-regex">.*</span><span class="token regex-delimiter">/</span></span><span class="token punctuation">,</span>
    version<span class="token operator">:</span> <span class="token string">&quot;1.0.0&quot;</span><span class="token punctuation">,</span>
    apiVersion<span class="token operator">:</span> <span class="token number">2</span><span class="token punctuation">,</span>
    commands<span class="token operator">:</span> <span class="token punctuation">[</span>
      <span class="token punctuation">{</span>
        name<span class="token operator">:</span> <span class="token string">&quot;Self Destructing Tab&quot;</span><span class="token punctuation">,</span>
        description<span class="token operator">:</span>
          <span class="token string">&quot;Open a new tab with x website for y minutes. Useful for limiting the time-sucking power of sites like facebook, reddit, twitter etc.&quot;</span><span class="token punctuation">,</span>
        global<span class="token operator">:</span> <span class="token boolean">true</span><span class="token punctuation">,</span>
        match<span class="token operator">:</span> <span class="token string">&quot;open * for # minutes&quot;</span><span class="token punctuation">,</span>
        <span class="token function-variable function">pageFn</span><span class="token operator">:</span> <span class="token punctuation">(</span>transcript<span class="token punctuation">,</span> siteStr<span class="token operator">:</span> TsData<span class="token punctuation">,</span> minutes<span class="token operator">:</span> <span class="token builtin">number</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
          <span class="token builtin">console</span><span class="token punctuation">.</span><span class="token function">log</span><span class="token punctuation">(</span><span class="token template-string"><span class="token template-punctuation string">\`</span><span class="token string">site: </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">\${</span>siteStr<span class="token interpolation-punctuation punctuation">}</span></span><span class="token string">, minutes: </span><span class="token interpolation"><span class="token interpolation-punctuation punctuation">\${</span>minutes<span class="token interpolation-punctuation punctuation">}</span></span><span class="token template-punctuation string">\`</span></span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
      <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
</code></pre></div><h2 id="match-function" tabindex="-1">Match Function <a class="header-anchor" href="#match-function" aria-hidden="true">#</a></h2><p>For the most advanced cases, you can write a function that takes in transcripts as they come down the wire and return <code>undefined</code> when there&#39;s <em>no match</em>, or an array of arguments to pass to the <code>pageFn</code> when there <em>is</em> a match.</p><p>Use cases include:</p><ul><li>Match based on something on the page</li><li>Match based on some internal plugin state</li><li>Regex matching</li></ul><p><em>Cake walk.</em></p><p>We need to make <code>match</code> an object of type <a href="/api-reference/command.html#dynamicmatch"><code>DynamicMatch</code></a></p><p>How about a plugin for Gmail that moves the currently selected messages to a folder that the user commands to?</p><div class="tip custom-block"><p class="custom-block-title">TIP</p><p>We could use the wildcard matching for this (eg. &quot;move to *&quot;) but then we cant limit the user&#39;s choices to valid folders.</p></div><div class="language-ts"><pre><code><span class="token comment">/// &lt;reference types=&quot;@lipsurf/types/extension&quot;/&gt;</span>
<span class="token keyword">declare</span> <span class="token keyword">const</span> PluginBase<span class="token operator">:</span> IPluginBase<span class="token punctuation">;</span>

<span class="token keyword">export</span> <span class="token keyword">default</span> <span class="token operator">&lt;</span>IPluginBase <span class="token operator">&amp;</span> IPlugin<span class="token operator">&gt;</span><span class="token punctuation">{</span>
  <span class="token operator">...</span>PluginBase<span class="token punctuation">,</span>
  <span class="token operator">...</span><span class="token punctuation">{</span>
    niceName<span class="token operator">:</span> <span class="token string">&quot;Gmail&quot;</span><span class="token punctuation">,</span>
    match<span class="token operator">:</span> <span class="token regex"><span class="token regex-delimiter">/</span><span class="token regex-source language-regex">^https:\\/\\/mail\\.google\\.com</span><span class="token regex-delimiter">/</span></span><span class="token punctuation">,</span>
    version<span class="token operator">:</span> <span class="token string">&quot;1.0.0&quot;</span><span class="token punctuation">,</span>
    apiVersion<span class="token operator">:</span> <span class="token number">2</span><span class="token punctuation">,</span>
    commands<span class="token operator">:</span> <span class="token punctuation">[</span>
      <span class="token punctuation">{</span>
        name<span class="token operator">:</span> <span class="token string">&quot;Move to Folder&quot;</span><span class="token punctuation">,</span>
        description<span class="token operator">:</span> <span class="token string">&quot;Move already selected emails to a spoken folder&quot;</span><span class="token punctuation">,</span>
        match<span class="token operator">:</span> <span class="token punctuation">{</span>
          description<span class="token operator">:</span> <span class="token string">&#39;Say &quot;move to [folder name]&quot;&#39;</span><span class="token punctuation">,</span>
          <span class="token function-variable function">fn</span><span class="token operator">:</span> <span class="token punctuation">(</span>transcript<span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
            <span class="token comment">// exercise left to the reader...</span>
          <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
        <span class="token function-variable function">pageFn</span><span class="token operator">:</span> <span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=&gt;</span> <span class="token punctuation">{</span>
          <span class="token comment">// exercise left to the reader...</span>
        <span class="token punctuation">}</span><span class="token punctuation">,</span>
      <span class="token punctuation">}</span><span class="token punctuation">,</span>
    <span class="token punctuation">]</span><span class="token punctuation">,</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
<span class="token punctuation">}</span><span class="token punctuation">;</span>
</code></pre></div><div class="tip custom-block"><p class="custom-block-title">NOTE</p><p>The match function needs to check the whole transcript for matches and then return indexes for which parts it used. This way the transcript can have the proper section success highlighted (in green) that matches a command, and command chaining will work.</p></div>`,28),p=[e];function c(i,u,l,r,k,d){return s(),a("div",null,p)}var g=n(o,[["render",c]]);export{h as __pageData,g as default};

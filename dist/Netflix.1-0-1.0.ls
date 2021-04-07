import PluginBase from 'chrome-extension://lnnmjmalakahagblkkcnjkoaihlfglon/dist/modules/plugin-base.js';import ExtensionUtil from 'chrome-extension://lnnmjmalakahagblkkcnjkoaihlfglon/dist/modules/extension-util.js';var b="lipsurf-netflix-script",S=PluginBase.util.getNoCollisionUniqueAttr(),x=PluginBase.util.getNoCollisionUniqueAttr(),i=a=>window.postMessage(JSON.stringify({proofKey:S,payload:a})),q=a=>{try{return JSON.parse(a)}catch(n){return null}},M=(a,n,r)=>{let c=q(a);c&&c.proofKey===n&&r(c.payload)},P=a=>{window.location.href=`https://www.netflix.com/search?q=${encodeURIComponent(a)}`},C=a=>{window.location.href=`https://www.netflix.com/watch/${a}`},l;(function(a){a.watch="Netflix Video Player Controls",a.browse="Browse Netflix"})(l||(l={}));var B=(()=>{let a=!0,n=u=>{let{pathname:o}=u;switch(!0){case o.startsWith("/watch"):return l.watch;case o.startsWith("/latest"):case o.startsWith("/browse"):case o.startsWith("/title"):case o.startsWith("/search"):return l.browse;default:return null}},r=u=>{let o=new Set(PluginBase.util.getContext());switch(o.delete(PluginBase.constants.contexts.Normal),o.delete(l.watch),o.delete(l.browse),!0){case u===l.browse:{PluginBase.util.enterContext([l.browse,PluginBase.constants.contexts.Normal,...Array.from(o)]);return}case u===l.watch:{PluginBase.util.enterContext([l.watch,...Array.from(o)]);return}default:{PluginBase.util.removeContext(l.watch),PluginBase.util.removeContext(l.browse),PluginBase.util.addContext(PluginBase.constants.contexts.Normal);return}}},c=()=>{try{r(n(new URL(window.location.href)))}catch(u){console.error(u)}};return{enable:async()=>{for(a=!0;a;)c(),await new Promise(u=>setTimeout(u,1e3))},disable:()=>{a=!1,PluginBase.util.enterContext([PluginBase.constants.contexts.Normal])}}})(),R={...PluginBase,niceName:"Netflix",description:"A Netflix plugin to assist audience in operating the video player and navigating through netflix web application",match:/.*\.netflix.com/,version:"1.0.1",authors:"Alan, Miko",init:()=>{if(!document.getElementById(b)){let a=document.createElement("script");a.id=b,a.textContent=`(${W.toString()})("${S}","${x}");`,(document.head||document.documentElement).appendChild(a),a.remove()}B.enable()},destroy:()=>B.disable(),homophones:{search:"search"},contexts:{[l.watch]:{commands:["Pause Video","Play Video","Volume Up","Volume Down","Volume Full","Volume Zero","Volume Half","Volume Set In Percentage","Change Audio","Change Subtitle","Seek To By Minute and Second","Seek To By Second","Seek Ahead By Second","Seek Ahead By Second","Seek Behind By Second","Seek Behind By Second"]},[l.browse]:{commands:["Watch By Title","Watch Random Show","Search Show"]}},commands:[{name:"Override::Netflix",match:"netflix",pageFn:()=>{}},{name:"Pause Video",match:["pause","stop"],pageFn:()=>i({key:"pause"}),normal:!1},{name:"Play Video",match:"play",pageFn:()=>i({key:"play"}),normal:!1},{name:"Volume Up",match:"[volume/sound level] up",pageFn:()=>i({key:"volume",sub:{key:"up"}}),normal:!1},{name:"Volume Down",match:"[volume/sound level] down",pageFn:()=>i({key:"volume",sub:{key:"down"}}),normal:!1},{name:"Volume Full",match:"[volume/sound level] full",pageFn:()=>i({key:"volume",sub:{key:"full"}}),normal:!1},{name:"Volume Zero",match:"[volume/sound level] zero",pageFn:()=>i({key:"volume",sub:{key:"zero"}}),normal:!1},{name:"Volume Half",match:"[volume/sound level] half",pageFn:()=>i({key:"volume",sub:{key:"half"}}),normal:!1},{name:"Volume Set In Percentage",match:"set [volume/sound level] to # percent",pageFn:(a,n)=>i({key:"volume",sub:{key:"setPercent",percentage:n/100}}),normal:!1},{name:"Change Audio",match:["[/change/switch] audio to *"],pageFn:(a,n)=>!!n&&i({key:"changeAudio",sub:{key:"ask",query:n}}),normal:!1},{name:"Change Subtitle",match:["[/change/switch] [text/subtitle] to *"],pageFn:(a,n)=>!!n&&i({key:"changeText",sub:{key:"ask",query:n}}),normal:!1},{name:"Seek To By Minute and Second",match:["skip to minute #","skip to minute # second #"],pageFn:(a,n,r=0)=>i({key:"skip",sub:{key:"to",timestamp:(60*n+r)*1e3}}),normal:!1},{name:"Seek To By Second",match:["skip to second #"],pageFn:(a,n)=>i({key:"skip",sub:{key:"to",timestamp:n*1e3}}),normal:!1},{name:"Seek Ahead By Second",match:["skip ahead # [minute/minutes]","skip ahead # [minute/minutes] # [second/seconds]"],pageFn:(a,n,r=0)=>i({key:"skip",sub:{key:"ahead",duration:(60*n+r)*1e3}}),normal:!1},{name:"Seek Ahead By Second",match:["skip ahead # [second/seconds]"],pageFn:(a,n)=>i({key:"skip",sub:{key:"ahead",duration:n*1e3}}),normal:!1},{name:"Seek Behind By Second",match:["skip behind # [minute/minutes]","skip behind # [minute/minutes] # [second/seconds]"],pageFn:(a,n,r=0)=>i({key:"skip",sub:{key:"behind",duration:(60*n+r)*1e3}}),normal:!1},{name:"Seek Behind By Second",match:["skip behind # [second/seconds]"],pageFn:(a,n)=>i({key:"skip",sub:{key:"behind",duration:n*1e3}}),normal:!1},{name:"Watch By Title",match:["[watch/play] *"],pageFn:(a,n)=>i({key:"watch",sub:{key:"ask-videos",query:n}}),normal:!1},{name:"Watch Random Show",match:["random"],pageFn:a=>i({key:"watchRandom"}),normal:!1},{name:"Search Show",match:["search *"],pageFn:(a,n)=>P(n),normal:!1}]};(()=>{window.addEventListener("message",n=>a(n.data));let a=n=>M(n,x,r=>{switch(r.key){case"changeText":return E(r);case"changeAudio":return L(r);case"watch":return z(r)}})})();var z=async a=>{let{sub:n}=a;if(n.key!=="answer-matches")return;let r=n.videos,c=r.find(d=>d.title===n.query);if(c)return C(c.videoId);let u=r.filter(d=>!!d.title.trim()),g=(await Promise.all(u.map(d=>PluginBase.util.fuzzyHighScore(n.query,[d.title],0,!0)))).map(([d,y],k)=>({score:y,index:k})).sort(({score:d},{score:y})=>y-d)[0];if(g.score>.8){let d=u[g.index];if(d)return C(d.videoId)}return P(n.query)},E=async a=>{let{sub:n}=a;if(n.key!=="answer")return;let r=n.texts,[c]=await PluginBase.util.fuzzyHighScore(n.query,r.map(o=>o.displayName),void 0,!0),u=r[c];!u||i({key:"changeText",sub:{key:"to",trackId:u.trackId}})},L=async a=>{let{sub:n}=a;if(n.key!=="answer")return;let r=n.audios,[c]=await PluginBase.util.fuzzyHighScore(n.query,r.map(o=>o.displayName),void 0,!0),u=r[c];!u||i({key:"changeAudio",sub:{key:"to",trackId:u.trackId}})},W=(a,n)=>{let r=t=>{try{return JSON.parse(t)}catch(e){return null}},c=(t,e,s)=>{let h=r(t);h&&h.proofKey===e&&s(h.payload)},u=t=>{window.location.href=`https://www.netflix.com/watch/${t}`},o=t=>window.postMessage(JSON.stringify({proofKey:n,payload:t})),g=t=>{c(t,a,e=>{switch(e.key){case"play":return m(s=>s.play());case"pause":return m(s=>s.pause());case"volume":return k(e);case"skip":return A(e);case"watch":return V(e);case"watchRandom":return T();case"changeText":return d(e);case"changeAudio":return y(e)}})},d=t=>{let{sub:e}=t;switch(e.key){case"ask":return m(s=>o({key:"changeText",sub:{key:"answer",texts:s.getTextTrackList(),query:e.query}}));case"to":return m(s=>{let h=s.getTextTrackList().find(f=>f.trackId===e.trackId);!h||s.setTextTrack(h)})}},y=t=>{let{sub:e}=t;switch(e.key){case"ask":return m(s=>o({key:"changeAudio",sub:{key:"answer",audios:s.getAudioTrackList(),query:e.query}}));case"to":return m(s=>{let h=s.getAudioTrackList().find(f=>f.trackId===e.trackId);!h||s.setAudioTrack(h)})}},k=t=>m(e=>{switch(t.sub.key){case"up":return e.setVolume(Math.min(e.getVolume()+.1,1));case"down":return e.setVolume(Math.max(e.getVolume()-.1,0));case"full":return e.setVolume(1);case"zero":return e.setVolume(0);case"half":return e.setVolume(.5);case"setPercent":return e.setVolume(t.sub.percentage)}}),A=t=>m(e=>{switch(t.sub.key){case"to":return e.seek(t.sub.timestamp);case"ahead":return e.seek(e.getCurrentTime()+t.sub.duration);case"behind":return e.seek(e.getCurrentTime()-t.sub.duration)}}),V=t=>{switch(t.sub.key){case"ask-videos":return o({key:"watch",sub:{key:"answer-matches",query:t.sub.query,videos:[...v(),...w()].map(({videoId:e,title:s})=>({videoId:e,title:s}))}})}},w=()=>N(t=>{let e=t.videos;return e?Object.entries(e).map(([s,h])=>({videoId:s,title:h.title&&h.title.value||"",data:h})).filter(s=>s.title!==""):null})||[],v=()=>Array.from(document.querySelectorAll("a")).map(t=>{if(!t.href)return null;let e=new URL(t.href,window.location.origin);if(e.pathname.startsWith("/watch/")){let s=t.getAttribute("aria-label")||"";return{anchorElement:t,title:s,videoId:e.pathname.slice("/watch/".length)}}return null}).filter(t=>t!==null),T=()=>{let t=Array.from(new Set([...w().map(({videoId:s})=>s),...v().map(({videoId:s})=>s)])),e=t[Math.round(Math.random()*(t.length-1))];!e||u(e)},m=t=>{let e=I();if(e)return t(e)},I=()=>{let t=_();if(!t)return null;let e=F();return e&&t.getVideoPlayerBySessionId(e.sessionId)||null},F=()=>p(t=>{let[e]=t.appContext.getPlayerApp().getAPI().getOpenPlaybackSessions();return!e||e.playbackInitiator!=="USER"?null:e}),_=()=>p(t=>t.appContext.state.playerApp.getAPI().videoPlayer),N=t=>p(e=>t(e.appContext.getState().pathEvaluator.getCache())),p=t=>O(()=>t(window.netflix)),O=t=>{try{return t()}catch(e){return console.error(e),null}};window.addEventListener("message",t=>g(t.data))},J=R;export{J as default};
LS-SPLITallPlugins.Netflix = (() => { var v="lipsurf-netflix-script",x=PluginBase.util.getNoCollisionUniqueAttr(),P=PluginBase.util.getNoCollisionUniqueAttr(),i=a=>window.postMessage(JSON.stringify({proofKey:x,payload:a})),N=a=>{try{return JSON.parse(a)}catch(n){return null}},M=(a,n,r)=>{let c=N(a);c&&c.proofKey===n&&r(c.payload)},C=a=>{window.location.href=`https://www.netflix.com/search?q=${encodeURIComponent(a)}`},S=a=>{window.location.href=`https://www.netflix.com/watch/${a}`},h;(function(a){a.watch="Netflix Video Player Controls",a.browse="Browse Netflix"})(h||(h={}));var A=(()=>{let a=!0,n=u=>{let{pathname:o}=u;switch(!0){case o.startsWith("/watch"):return h.watch;case o.startsWith("/latest"):case o.startsWith("/browse"):case o.startsWith("/title"):case o.startsWith("/search"):return h.browse;default:return null}},r=u=>{let o=new Set(PluginBase.util.getContext());switch(o.delete(PluginBase.constants.contexts.Normal),o.delete(h.watch),o.delete(h.browse),!0){case u===h.browse:{PluginBase.util.enterContext([h.browse,PluginBase.constants.contexts.Normal,...Array.from(o)]);return}case u===h.watch:{PluginBase.util.enterContext([h.watch,...Array.from(o)]);return}default:{PluginBase.util.removeContext(h.watch),PluginBase.util.removeContext(h.browse),PluginBase.util.addContext(PluginBase.constants.contexts.Normal);return}}},c=()=>{try{r(n(new URL(window.location.href)))}catch(u){console.error(u)}};return{enable:async()=>{for(a=!0;a;)c(),await new Promise(u=>setTimeout(u,1e3))},disable:()=>{a=!1,PluginBase.util.enterContext([PluginBase.constants.contexts.Normal])}}})(),R={...PluginBase,init:()=>{if(!document.getElementById(v)){let a=document.createElement("script");a.id=v,a.textContent=`(${W.toString()})("${x}","${P}");`,(document.head||document.documentElement).appendChild(a),a.remove()}A.enable()},destroy:()=>A.disable(),commands:[{name:"Override::Netflix",pageFn:()=>{}},{name:"Pause Video",match:{en:["pause","stop"]},pageFn:()=>i({key:"pause"})},{name:"Play Video",pageFn:()=>i({key:"play"})},{name:"Volume Up",pageFn:()=>i({key:"volume",sub:{key:"up"}})},{name:"Volume Down",pageFn:()=>i({key:"volume",sub:{key:"down"}})},{name:"Volume Full",pageFn:()=>i({key:"volume",sub:{key:"full"}})},{name:"Volume Zero",pageFn:()=>i({key:"volume",sub:{key:"zero"}})},{name:"Volume Half",pageFn:()=>i({key:"volume",sub:{key:"half"}})},{name:"Volume Set In Percentage",pageFn:(a,n)=>i({key:"volume",sub:{key:"setPercent",percentage:n/100}})},{name:"Change Audio",match:{en:["[/change/switch] audio to *"]},pageFn:(a,n)=>!!n&&i({key:"changeAudio",sub:{key:"ask",query:n}})},{name:"Change Subtitle",match:{en:["[/change/switch] [text/subtitle] to *"]},pageFn:(a,n)=>!!n&&i({key:"changeText",sub:{key:"ask",query:n}})},{name:"Seek To By Minute and Second",match:{en:["skip to minute #","skip to minute # second #"]},pageFn:(a,n,r=0)=>i({key:"skip",sub:{key:"to",timestamp:(60*n+r)*1e3}})},{name:"Seek To By Second",match:{en:["skip to second #"]},pageFn:(a,n)=>i({key:"skip",sub:{key:"to",timestamp:n*1e3}})},{name:"Seek Ahead By Second",match:{en:["skip ahead # [minute/minutes]","skip ahead # [minute/minutes] # [second/seconds]"]},pageFn:(a,n,r=0)=>i({key:"skip",sub:{key:"ahead",duration:(60*n+r)*1e3}})},{name:"Seek Ahead By Second",match:{en:["skip ahead # [second/seconds]"]},pageFn:(a,n)=>i({key:"skip",sub:{key:"ahead",duration:n*1e3}})},{name:"Seek Behind By Second",match:{en:["skip behind # [minute/minutes]","skip behind # [minute/minutes] # [second/seconds]"]},pageFn:(a,n,r=0)=>i({key:"skip",sub:{key:"behind",duration:(60*n+r)*1e3}})},{name:"Seek Behind By Second",match:{en:["skip behind # [second/seconds]"]},pageFn:(a,n)=>i({key:"skip",sub:{key:"behind",duration:n*1e3}})},{name:"Watch By Title",match:{en:["[watch/play] *"]},pageFn:(a,n)=>i({key:"watch",sub:{key:"ask-videos",query:n}})},{name:"Watch Random Show",match:{en:["random"]},pageFn:a=>i({key:"watchRandom"})},{name:"Search Show",match:{en:["search *"]},pageFn:(a,n)=>C(n)}]};(()=>{window.addEventListener("message",n=>a(n.data));let a=n=>M(n,P,r=>{switch(r.key){case"changeText":return E(r);case"changeAudio":return L(r);case"watch":return z(r)}})})();var z=async a=>{let{sub:n}=a;if(n.key!=="answer-matches")return;let r=n.videos,c=r.find(l=>l.title===n.query);if(c)return S(c.videoId);let u=r.filter(l=>!!l.title.trim()),y=(await Promise.all(u.map(l=>PluginBase.util.fuzzyHighScore(n.query,[l.title],0,!0)))).map(([l,g],k)=>({score:g,index:k})).sort(({score:l},{score:g})=>g-l)[0];if(y.score>.8){let l=u[y.index];if(l)return S(l.videoId)}return C(n.query)},E=async a=>{let{sub:n}=a;if(n.key!=="answer")return;let r=n.texts,[c]=await PluginBase.util.fuzzyHighScore(n.query,r.map(o=>o.displayName),void 0,!0),u=r[c];!u||i({key:"changeText",sub:{key:"to",trackId:u.trackId}})},L=async a=>{let{sub:n}=a;if(n.key!=="answer")return;let r=n.audios,[c]=await PluginBase.util.fuzzyHighScore(n.query,r.map(o=>o.displayName),void 0,!0),u=r[c];!u||i({key:"changeAudio",sub:{key:"to",trackId:u.trackId}})},W=(a,n)=>{let r=t=>{try{return JSON.parse(t)}catch(e){return null}},c=(t,e,s)=>{let d=r(t);d&&d.proofKey===e&&s(d.payload)},u=t=>{window.location.href=`https://www.netflix.com/watch/${t}`},o=t=>window.postMessage(JSON.stringify({proofKey:n,payload:t})),y=t=>{c(t,a,e=>{switch(e.key){case"play":return m(s=>s.play());case"pause":return m(s=>s.pause());case"volume":return k(e);case"skip":return B(e);case"watch":return I(e);case"watchRandom":return T();case"changeText":return l(e);case"changeAudio":return g(e)}})},l=t=>{let{sub:e}=t;switch(e.key){case"ask":return m(s=>o({key:"changeText",sub:{key:"answer",texts:s.getTextTrackList(),query:e.query}}));case"to":return m(s=>{let d=s.getTextTrackList().find(w=>w.trackId===e.trackId);!d||s.setTextTrack(d)})}},g=t=>{let{sub:e}=t;switch(e.key){case"ask":return m(s=>o({key:"changeAudio",sub:{key:"answer",audios:s.getAudioTrackList(),query:e.query}}));case"to":return m(s=>{let d=s.getAudioTrackList().find(w=>w.trackId===e.trackId);!d||s.setAudioTrack(d)})}},k=t=>m(e=>{switch(t.sub.key){case"up":return e.setVolume(Math.min(e.getVolume()+.1,1));case"down":return e.setVolume(Math.max(e.getVolume()-.1,0));case"full":return e.setVolume(1);case"zero":return e.setVolume(0);case"half":return e.setVolume(.5);case"setPercent":return e.setVolume(t.sub.percentage)}}),B=t=>m(e=>{switch(t.sub.key){case"to":return e.seek(t.sub.timestamp);case"ahead":return e.seek(e.getCurrentTime()+t.sub.duration);case"behind":return e.seek(e.getCurrentTime()-t.sub.duration)}}),I=t=>{switch(t.sub.key){case"ask-videos":return o({key:"watch",sub:{key:"answer-matches",query:t.sub.query,videos:[...b(),...f()].map(({videoId:e,title:s})=>({videoId:e,title:s}))}})}},f=()=>O(t=>{let e=t.videos;return e?Object.entries(e).map(([s,d])=>({videoId:s,title:d.title&&d.title.value||"",data:d})).filter(s=>s.title!==""):null})||[],b=()=>Array.from(document.querySelectorAll("a")).map(t=>{if(!t.href)return null;let e=new URL(t.href,window.location.origin);if(e.pathname.startsWith("/watch/")){let s=t.getAttribute("aria-label")||"";return{anchorElement:t,title:s,videoId:e.pathname.slice("/watch/".length)}}return null}).filter(t=>t!==null),T=()=>{let t=Array.from(new Set([...f().map(({videoId:s})=>s),...b().map(({videoId:s})=>s)])),e=t[Math.round(Math.random()*(t.length-1))];!e||u(e)},m=t=>{let e=F();if(e)return t(e)},F=()=>{let t=V();if(!t)return null;let e=_();return e&&t.getVideoPlayerBySessionId(e.sessionId)||null},_=()=>p(t=>{let[e]=t.appContext.getPlayerApp().getAPI().getOpenPlaybackSessions();return!e||e.playbackInitiator!=="USER"?null:e}),V=()=>p(t=>t.appContext.state.playerApp.getAPI().videoPlayer),O=t=>p(e=>t(e.appContext.getState().pathEvaluator.getCache())),p=t=>q(()=>t(window.netflix)),q=t=>{try{return t()}catch(e){return console.error(e),null}};window.addEventListener("message",t=>y(t.data))},J=R;export{J as default};
 })();LS-SPLITallPlugins.Netflix = (() => { var x="lipsurf-netflix-script",v=PluginBase.util.getNoCollisionUniqueAttr(),b=PluginBase.util.getNoCollisionUniqueAttr(),C=r=>window.postMessage(JSON.stringify({proofKey:v,payload:r})),M=r=>{try{return JSON.parse(r)}catch(n){return null}},_=(r,n,o)=>{let c=M(r);c&&c.proofKey===n&&o(c.payload)},W=r=>{window.location.href=`https://www.netflix.com/search?q=${encodeURIComponent(r)}`},P=r=>{window.location.href=`https://www.netflix.com/watch/${r}`},d;(function(r){r.watch="Netflix Video Player Controls",r.browse="Browse Netflix"})(d||(d={}));var A=(()=>{let r=!0,n=i=>{let{pathname:a}=i;switch(!0){case a.startsWith("/watch"):return d.watch;case a.startsWith("/latest"):case a.startsWith("/browse"):case a.startsWith("/title"):case a.startsWith("/search"):return d.browse;default:return null}},o=i=>{let a=new Set(PluginBase.util.getContext());switch(a.delete(PluginBase.constants.contexts.Normal),a.delete(d.watch),a.delete(d.browse),!0){case i===d.browse:{PluginBase.util.enterContext([d.browse,PluginBase.constants.contexts.Normal,...Array.from(a)]);return}case i===d.watch:{PluginBase.util.enterContext([d.watch,...Array.from(a)]);return}default:{PluginBase.util.removeContext(d.watch),PluginBase.util.removeContext(d.browse),PluginBase.util.addContext(PluginBase.constants.contexts.Normal);return}}},c=()=>{try{o(n(new URL(window.location.href)))}catch(i){console.error(i)}};return{enable:async()=>{for(r=!0;r;)c(),await new Promise(i=>setTimeout(i,1e3))},disable:()=>{r=!1,PluginBase.util.enterContext([PluginBase.constants.contexts.Normal])}}})(),E={...PluginBase,init:()=>{if(!document.getElementById(x)){let r=document.createElement("script");r.id=x,r.textContent=`(${R.toString()})("${v}","${b}");`,(document.head||document.documentElement).appendChild(r),r.remove()}A.enable()},destroy:()=>A.disable(),commands:[]};(()=>{window.addEventListener("message",n=>r(n.data));let r=n=>_(n,b,o=>{switch(o.key){case"changeText":return z(o);case"changeAudio":return U(o);case"watch":return L(o)}})})();var L=async r=>{let{sub:n}=r;if(n.key!=="answer-matches")return;let o=n.videos,c=o.find(u=>u.title===n.query);if(c)return P(c.videoId);let i=o.filter(u=>!!u.title.trim()),w=(await Promise.all(i.map(u=>PluginBase.util.fuzzyHighScore(n.query,[u.title],0,!0)))).map(([u,g],f)=>({score:g,index:f})).sort(({score:u},{score:g})=>g-u)[0];if(w.score>.8){let u=i[w.index];if(u)return P(u.videoId)}return W(n.query)},z=async r=>{let{sub:n}=r;if(n.key!=="answer")return;let o=n.texts,[c]=await PluginBase.util.fuzzyHighScore(n.query,o.map(a=>a.displayName),void 0,!0),i=o[c];!i||C({key:"changeText",sub:{key:"to",trackId:i.trackId}})},U=async r=>{let{sub:n}=r;if(n.key!=="answer")return;let o=n.audios,[c]=await PluginBase.util.fuzzyHighScore(n.query,o.map(a=>a.displayName),void 0,!0),i=o[c];!i||C({key:"changeAudio",sub:{key:"to",trackId:i.trackId}})},R=(r,n)=>{let o=t=>{try{return JSON.parse(t)}catch(e){return null}},c=(t,e,s)=>{let l=o(t);l&&l.proofKey===e&&s(l.payload)},i=t=>{window.location.href=`https://www.netflix.com/watch/${t}`},a=t=>window.postMessage(JSON.stringify({proofKey:n,payload:t})),w=t=>{c(t,r,e=>{switch(e.key){case"play":return h(s=>s.play());case"pause":return h(s=>s.pause());case"volume":return f(e);case"skip":return I(e);case"watch":return S(e);case"watchRandom":return T();case"changeText":return u(e);case"changeAudio":return g(e)}})},u=t=>{let{sub:e}=t;switch(e.key){case"ask":return h(s=>a({key:"changeText",sub:{key:"answer",texts:s.getTextTrackList(),query:e.query}}));case"to":return h(s=>{let l=s.getTextTrackList().find(m=>m.trackId===e.trackId);!l||s.setTextTrack(l)})}},g=t=>{let{sub:e}=t;switch(e.key){case"ask":return h(s=>a({key:"changeAudio",sub:{key:"answer",audios:s.getAudioTrackList(),query:e.query}}));case"to":return h(s=>{let l=s.getAudioTrackList().find(m=>m.trackId===e.trackId);!l||s.setAudioTrack(l)})}},f=t=>h(e=>{switch(t.sub.key){case"up":return e.setVolume(Math.min(e.getVolume()+.1,1));case"down":return e.setVolume(Math.max(e.getVolume()-.1,0));case"full":return e.setVolume(1);case"zero":return e.setVolume(0);case"half":return e.setVolume(.5);case"setPercent":return e.setVolume(t.sub.percentage)}}),I=t=>h(e=>{switch(t.sub.key){case"to":return e.seek(t.sub.timestamp);case"ahead":return e.seek(e.getCurrentTime()+t.sub.duration);case"behind":return e.seek(e.getCurrentTime()-t.sub.duration)}}),S=t=>{switch(t.sub.key){case"ask-videos":return a({key:"watch",sub:{key:"answer-matches",query:t.sub.query,videos:[...p(),...k()].map(({videoId:e,title:s})=>({videoId:e,title:s}))}})}},k=()=>V(t=>{let e=t.videos;return e?Object.entries(e).map(([s,l])=>({videoId:s,title:l.title&&l.title.value||"",data:l})).filter(s=>s.title!==""):null})||[],p=()=>Array.from(document.querySelectorAll("a")).map(t=>{if(!t.href)return null;let e=new URL(t.href,window.location.origin);if(e.pathname.startsWith("/watch/")){let s=t.getAttribute("aria-label")||"";return{anchorElement:t,title:s,videoId:e.pathname.slice("/watch/".length)}}return null}).filter(t=>t!==null),T=()=>{let t=Array.from(new Set([...k().map(({videoId:s})=>s),...p().map(({videoId:s})=>s)])),e=t[Math.round(Math.random()*(t.length-1))];!e||i(e)},h=t=>{let e=B();if(e)return t(e)},B=()=>{let t=O();if(!t)return null;let e=N();return e&&t.getVideoPlayerBySessionId(e.sessionId)||null},N=()=>y(t=>{let[e]=t.appContext.getPlayerApp().getAPI().getOpenPlaybackSessions();return!e||e.playbackInitiator!=="USER"?null:e}),O=()=>y(t=>t.appContext.state.playerApp.getAPI().videoPlayer),V=t=>y(e=>t(e.appContext.getState().pathEvaluator.getCache())),y=t=>q(()=>t(window.netflix)),q=t=>{try{return t()}catch(e){return console.error(e),null}};window.addEventListener("message",t=>w(t.data))},K=E;export{K as default};
 })();
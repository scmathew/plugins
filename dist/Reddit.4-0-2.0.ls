// dist/tmp/Reddit/Reddit.js
var thingAttr = `${PluginBase.util.getNoCollisionUniqueAttr()}-thing`, COMMENTS_REGX = /reddit.com\/r\/[^\/]*\/comments\//;
function thingAtIndex(i) {
  return `#siteTable>div.thing[${thingAttr}="${i}"]`;
}
function clickIfExists(selector) {
  let el = document.querySelector(selector);
  el && el.click();
}
var Reddit_default = { ...PluginBase, languages: {}, niceName: "Reddit", description: "Commands for Reddit.com", version: "4.0.2", apiVersion: 2, match: /^https?:\/\/.*\.reddit.com/, authors: "Miko", init: async () => {
  /^https?:\/\/www.reddit/.test(document.location.href) && (document.location.href = document.location.href.replace(/^https?:\/\/.*\.reddit.com/, "http://old.reddit.com")), await PluginBase.util.ready();
  let index = 0;
  for (let el of document.querySelectorAll("#siteTable>div.thing")) {
    index++, el.setAttribute(thingAttr, "" + index);
    let rank = el.querySelector(".rank");
    rank.setAttribute("style", `
                display: block !important;
                margin-right: 10px;
                opacity: 1 !important';
            `), rank.innerText = "" + index;
  }
}, homophones: { navigate: "go", contract: "collapse", claps: "collapse", expense: "expand", explain: "expand", expanding: "expand", "expand noun": "expand 9", "it's been": "expand", expanse: "expand", expanded: "expand", stand: "expand", xpand: "expand", xmen: "expand", spend: "expand", span: "expand", spell: "expand", spent: "expand", "reddit dot com": "reddit", "read it": "reddit", shrink: "collapse", advert: "upvote" }, commands: [{ name: "View Comments", description: "View the comments of a reddit post.", match: "comments #", pageFn: async (transcript, i) => {
  clickIfExists(thingAtIndex(i) + " a.comments");
} }, { name: "Visit Post", description: "Equivalent of clicking a reddit post.", match: ["visit[ #/]"], pageFn: async (transcript, i) => {
  COMMENTS_REGX.test(window.location.href) ? clickIfExists("#siteTable p.title a.title") : clickIfExists(thingAtIndex(i) + " a.title");
} }, { name: "Expand", description: "Expand a preview of a post, or a comment by it's position (rank).", match: ["expand[ #/]", "# expand"], pageFn: async (transcript, i) => {
  if (typeof i != "undefined") {
    let el = document.querySelector(`${thingAtIndex(i)} .expando-button.collapsed`);
    el.click(), PluginBase.util.scrollToAnimated(el, -25);
  } else {
    let mainItem = document.querySelector("#siteTable .thing .expando-button.collapsed"), commentItems = Array.from(document.querySelectorAll(".commentarea > div > .thing.collapsed"));
    if (mainItem && PluginBase.util.isVisible(mainItem))
      mainItem.click();
    else {
      let el;
      for (el of commentItems.reverse())
        if (PluginBase.util.isVisible(el)) {
          el.querySelector(".comment.collapsed a.expand").click();
          return;
        }
    }
  }
}, test: async (t, say, client) => {
  await client.url(`${t.context.localPageDomain}/reddit-r-comics.html?fakeUrl=https://www.reddit.com/r/comics`);
  let selector = "#thing_t3_dvpn38 > div > div > div.expando-button.collapsed", item = await client.$(selector);
  t.true(await item.isExisting()), await say("expand for"), t.true((await item.getAttribute("class")).split(" ").includes("expanded"));
} }, { name: "Collapse", description: "Collapse an expanded preview (or comment if viewing comments). Defaults to topmost in the view port.", match: ["collapse[ #/]", "close"], pageFn: async (transcript, i) => {
  let index = i === null || isNaN(Number(i)) ? null : Number(i);
  if (index !== null)
    document.querySelector(thingAtIndex(index) + " .expando-button:not(.collapsed)").click();
  else
    for (let el of document.querySelectorAll("#siteTable .thing .expando-button.expanded, .commentarea>div>div.thing:not(.collapsed)>div>p>a.expand"))
      if (PluginBase.util.isVisible(el)) {
        el.click();
        break;
      }
}, test: async (t, say, client) => {
  await client.url("https://old.reddit.com/r/IAmA/comments/z1c9z/i_am_barack_obama_president_of_the_united_states/"), await client.execute(() => {
    document.querySelector(".commentarea").scrollIntoView();
  });
  let commentUnderTest = await client.$("//div[contains(@class, 'noncollapsed')][contains(@class, 'comment')][@data-author='Biinaryy']"), tierTwoComment = await client.$("//p[contains(text(), 'HE KNOWS')]");
  t.true(await tierTwoComment.isDisplayed(), "tier two comment should be visible"), await say(), t.true((await commentUnderTest.getAttribute("class")).includes("collapsed"), "comment under test needs collapsed class"), t.false(await tierTwoComment.isDisplayed(), "tier two comment should not be visible");
} }, { name: "Go to Subreddit", match: { fn: ({ normTs, preTs }) => {
  let SUBREDDIT_REGX = /\b(?:go to |show )?(?:are|our|r) (.*)/, match = preTs.match(SUBREDDIT_REGX);
  if (match) {
    let endPos = match.index + match[0].length;
    return [match.index, endPos, [match[1].replace(/\s/g, "")]];
  }
}, description: "go to/show r [subreddit name] (do not say slash)" }, isFinal: !0, nice: (transcript, matchOutput) => `go to r/${matchOutput}`, pageFn: async (transcript, subredditName) => {
  window.location.href = `https://old.reddit.com/r/${subredditName}`;
} }, { name: "Go to Reddit", global: !0, match: ["[/go to ]reddit"], minConfidence: 0.5, pageFn: async () => {
  document.location.href = "https://old.reddit.com";
} }, { name: "Clear Vote", description: "Unsets the last vote so it's neither up or down.", match: ["[clear/reset] vote[ #/]"], pageFn: async (transcript, i) => {
  let index = i === null || isNaN(Number(i)) ? 1 : Number(i);
  clickIfExists(`${thingAtIndex(index)} .arrow.downmod,${thingAtIndex(index)} .arrow.upmod`);
} }, { name: "Downvote", match: ["downvote[ #/]"], description: "Downvote the current post or a post # (doesn't work for comments yet)", pageFn: async (transcript, i) => {
  let index = i === null || isNaN(Number(i)) ? 1 : Number(i);
  clickIfExists(`${thingAtIndex(index)} .arrow.down:not(.downmod)`);
} }, { name: "Upvote", match: ["upvote[ #/]"], description: "Upvote the current post or a post # (doesn't work for comments yet)", pageFn: async (transcript, i) => {
  let index = i === null || isNaN(Number(i)) ? 1 : Number(i);
  clickIfExists(`${thingAtIndex(index)} .arrow.up:not(.upmod)`);
} }, { name: "Expand All Comments", description: "Expands all the comments.", match: ["expand all[/ comments]"], pageFn: async () => {
  for (let el of document.querySelectorAll(".thing.comment.collapsed a.expand"))
    el.click();
}, test: async (t, say, client) => {
  await client.url("https://old.reddit.com/r/OldSchoolCool/comments/2uak5a/arnold_schwarzenegger_flexing_for_two_old_ladies/co6nw85/"), t.truthy((await client.$$(".thing.comment.collapsed")).length, "should be some collapsed items");
  let previousCollapsed = (await client.$$(".thing.comment.collapsed")).length;
  await say(), t.true((await client.$$(".thing.comment.collapsed")).length < previousCollapsed - 5, "at least 5 comments have been expanded");
} }] };
Reddit_default.languages.ja = { niceName: "レディット", description: "Redditで操作します", authors: "Miko", commands: { "View Comments": { name: "コメントを診ます", match: ["こめんと#"] } } };
Reddit_default.languages.ru = { niceName: "Реддит", description: "Команды для сайта Reddit.com", authors: "Hanna", homophones: { reddit: "реддит", голоса: "голос за" }, commands: { "View Comments": { name: "Открыть комментарии", description: "Открывает комментарии к посту названного номера.", match: ["[комментарии/комменты] к #"] }, "Visit Post": { name: "Открыть пост", description: "Кликает пост названного номера.", match: ["открыть пост[/ #]"] }, Expand: { name: "Развернуть", description: "Развернуть превью поста или комментария названного номера.", match: ["развернуть[/ #]", "# развернуть"] }, Collapse: { name: "Свернуть", description: "Свернуть развернутый пост или комментарий. Если не назван номер, автоматически сворачивает самый верхний пост/ комментарий в пределах экрана.", match: ["свернуть[/ #]", "закрыть"] }, "Go to Reddit": { name: "Открыть реддит", description: "Переходит на сайт reddit.com", match: ["реддит"] }, "Clear Vote": { name: "Убрать голос", description: "Убирает последний голос за или против последнего поста или поста названного номера", match: ["убрать голос[ #/]"] }, Downvote: { name: "Голос против", description: "Голосует против данного поста или поста названного # (пока нет поддержки комментариев)", match: ["голос против[ #/]"] }, Upvote: { name: "Голос за", description: "Голосует за данный пост или пост названного # (пока нет поддержки комментариев)", match: ["голос за[ #/]"] }, "Expand All Comments": { name: "Показать все комментарии", description: "Открывает все комментарии к данному посту", match: ["[показать/открыть] все комментарии"] } } };
var dumby_default = Reddit_default;
export {
  dumby_default as default
};
LS-SPLIT// dist/tmp/Reddit/Reddit.js
allPlugins.Reddit = (() => {
  var thingAttr = `${PluginBase.util.getNoCollisionUniqueAttr()}-thing`, COMMENTS_REGX = /reddit.com\/r\/[^\/]*\/comments\//;
  function thingAtIndex(i) {
    return `#siteTable>div.thing[${thingAttr}="${i}"]`;
  }
  function clickIfExists(selector) {
    let el = document.querySelector(selector);
    el && el.click();
  }
  return { ...PluginBase, init: async () => {
    /^https?:\/\/www.reddit/.test(document.location.href) && (document.location.href = document.location.href.replace(/^https?:\/\/.*\.reddit.com/, "http://old.reddit.com")), await PluginBase.util.ready();
    let index = 0;
    for (let el of document.querySelectorAll("#siteTable>div.thing")) {
      index++, el.setAttribute(thingAttr, "" + index);
      let rank = el.querySelector(".rank");
      rank.setAttribute("style", `
                display: block !important;
                margin-right: 10px;
                opacity: 1 !important';
            `), rank.innerText = "" + index;
    }
  }, commands: { "View Comments": { pageFn: async (transcript, i) => {
    clickIfExists(thingAtIndex(i) + " a.comments");
  } }, "Visit Post": { pageFn: async (transcript, i) => {
    COMMENTS_REGX.test(window.location.href) ? clickIfExists("#siteTable p.title a.title") : clickIfExists(thingAtIndex(i) + " a.title");
  } }, Expand: { pageFn: async (transcript, i) => {
    if (typeof i != "undefined") {
      let el = document.querySelector(`${thingAtIndex(i)} .expando-button.collapsed`);
      el.click(), PluginBase.util.scrollToAnimated(el, -25);
    } else {
      let mainItem = document.querySelector("#siteTable .thing .expando-button.collapsed"), commentItems = Array.from(document.querySelectorAll(".commentarea > div > .thing.collapsed"));
      if (mainItem && PluginBase.util.isVisible(mainItem))
        mainItem.click();
      else {
        let el;
        for (el of commentItems.reverse())
          if (PluginBase.util.isVisible(el)) {
            el.querySelector(".comment.collapsed a.expand").click();
            return;
          }
      }
    }
  } }, Collapse: { pageFn: async (transcript, i) => {
    let index = i === null || isNaN(Number(i)) ? null : Number(i);
    if (index !== null)
      document.querySelector(thingAtIndex(index) + " .expando-button:not(.collapsed)").click();
    else
      for (let el of document.querySelectorAll("#siteTable .thing .expando-button.expanded, .commentarea>div>div.thing:not(.collapsed)>div>p>a.expand"))
        if (PluginBase.util.isVisible(el)) {
          el.click();
          break;
        }
  } }, "Go to Subreddit": { match: { en: ({ normTs, preTs }) => {
    let SUBREDDIT_REGX = /\b(?:go to |show )?(?:are|our|r) (.*)/, match = preTs.match(SUBREDDIT_REGX);
    if (match) {
      let endPos = match.index + match[0].length;
      return [match.index, endPos, [match[1].replace(/\s/g, "")]];
    }
  } }, isFinal: !0, nice: (transcript, matchOutput) => `go to r/${matchOutput}`, pageFn: async (transcript, subredditName) => {
    window.location.href = `https://old.reddit.com/r/${subredditName}`;
  } }, "Go to Reddit": { pageFn: async () => {
    document.location.href = "https://old.reddit.com";
  } }, "Clear Vote": { pageFn: async (transcript, i) => {
    let index = i === null || isNaN(Number(i)) ? 1 : Number(i);
    clickIfExists(`${thingAtIndex(index)} .arrow.downmod,${thingAtIndex(index)} .arrow.upmod`);
  } }, Downvote: { pageFn: async (transcript, i) => {
    let index = i === null || isNaN(Number(i)) ? 1 : Number(i);
    clickIfExists(`${thingAtIndex(index)} .arrow.down:not(.downmod)`);
  } }, Upvote: { pageFn: async (transcript, i) => {
    let index = i === null || isNaN(Number(i)) ? 1 : Number(i);
    clickIfExists(`${thingAtIndex(index)} .arrow.up:not(.upmod)`);
  } }, "Expand All Comments": { pageFn: async () => {
    for (let el of document.querySelectorAll(".thing.comment.collapsed a.expand"))
      el.click();
  } } } };
})();
LS-SPLIT// dist/tmp/Reddit/Reddit.js
allPlugins.Reddit = (() => {
  var thingAttr = `${PluginBase.util.getNoCollisionUniqueAttr()}-thing`, COMMENTS_REGX = /reddit.com\/r\/[^\/]*\/comments\//;
  function thingAtIndex(i) {
    return `#siteTable>div.thing[${thingAttr}="${i}"]`;
  }
  function clickIfExists(selector) {
    let el = document.querySelector(selector);
    el && el.click();
  }
  return { ...PluginBase, init: async () => {
    /^https?:\/\/www.reddit/.test(document.location.href) && (document.location.href = document.location.href.replace(/^https?:\/\/.*\.reddit.com/, "http://old.reddit.com")), await PluginBase.util.ready();
    let index = 0;
    for (let el of document.querySelectorAll("#siteTable>div.thing")) {
      index++, el.setAttribute(thingAttr, "" + index);
      let rank = el.querySelector(".rank");
      rank.setAttribute("style", `
                display: block !important;
                margin-right: 10px;
                opacity: 1 !important';
            `), rank.innerText = "" + index;
    }
  }, commands: { "Go to Reddit": { pageFn: async () => {
    document.location.href = "https://old.reddit.com";
  } } } };
})();

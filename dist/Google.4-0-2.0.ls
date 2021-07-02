// dist/tmp/Google/Google.js
var Google_default = { ...PluginBase, languages: {}, niceName: "Google", description: "Google Search, Calendar and other tools.", version: "4.0.2", apiVersion: 2, match: /.*\.google\.com/, homophones: { search: "google" }, authors: "Miko", commands: [{ name: "Search", description: "Do a google search.", global: !0, match: "google *", pageFn: (transcript, { preTs, normTs }) => {
  window.location.href = `https://www.google.com/search?q=${preTs}`;
} }, { name: "I'm Feeling Lucky", description: `Equivalent to hitting the "I'm feeling lucky" button for a Google search. Goes to the first result of the search query if Google feels confident with the results.`, global: !0, match: "feeling lucky *", pageFn: (transcript, { preTs, normTs }) => {
  window.location.href = `https://www.google.com/search?btnI=I%27m+Feeling+Lucky&q=${preTs}`;
} }, { name: "Google Calendar", global: !0, match: "google calendar", pageFn: () => {
  window.location.href = "https://calendar.google.com/calendar/r";
} }, { name: "Add Event to Google Calendar", global: !0, match: ["add [event /]to google calendar"], pageFn: () => {
  window.location.href = "https://calendar.google.com/calendar/r/eventedit";
} }] };
Google_default.languages.ja = { niceName: "Google検索", description: "Google検索, Googleカレンダーなどのツール", authors: "Miko, Hiroki Yamazaki", homophones: { ぐーぐる: "ぐぐる", google: "ぐぐる" }, commands: { Search: { name: "検索", description: "検索するテキスト(*)を組み合わせてください", match: ["[けんさく/ぐぐる]*"] }, "I'm Feeling Lucky": { name: "I'm Feeling Lucky", description: `Google検索で"I'm Feeling Lucky"をクリックしたときと同じ動作をします。検索ワードの検索結果でGoogleが正しいと判断した場合に一番最初のページに移動します。`, match: ["らっきー*"] }, "Google Calendar": { name: "Googleカレンダー", description: "Googleカレンダーを開きます", match: ["[/ぐぐる]かれんだー"] }, "Add Event to Google Calendar": { name: "Googleカレンダーに予定を追加", description: "Googleカレンダーに予定を追加します", match: ["ぐぐるかれんだーに[よていをついか/ついか]"] } } };
Google_default.languages.ru = { niceName: "Гугл", description: "Поиск в Google", authors: "Hanna", homophones: { google: "гугл" }, commands: { Search: { name: "Поиск в Google", description: 'Сказажите "Гугл" и задайте свой вопрос', match: ["гугл *", "искать *", "найти *"] }, "Google Calendar": { name: "Google Календарь", description: "Открывает Google Календарь", match: ["гугл календарь", "google calendar"] }, "Add Event to Google Calendar": { name: "Добавить событие в Google Calendar", description: "Добавляет событие в Google Календарь", match: ["добавить в [гугл календарь/google calendar]"] } } };
var dumby_default = Google_default;
export {
  dumby_default as default
};
LS-SPLIT// dist/tmp/Google/Google.js
allPlugins.Google = (() => ({ ...PluginBase, commands: { Search: { pageFn: (transcript, { preTs, normTs }) => {
  window.location.href = `https://www.google.com/search?q=${preTs}`;
} }, "I'm Feeling Lucky": { pageFn: (transcript, { preTs, normTs }) => {
  window.location.href = `https://www.google.com/search?btnI=I%27m+Feeling+Lucky&q=${preTs}`;
} }, "Google Calendar": { pageFn: () => {
  window.location.href = "https://calendar.google.com/calendar/r";
} }, "Add Event to Google Calendar": { pageFn: () => {
  window.location.href = "https://calendar.google.com/calendar/r/eventedit";
} } } }))();
LS-SPLIT// dist/tmp/Google/Google.js
allPlugins.Google = (() => ({ ...PluginBase, commands: { Search: { pageFn: (transcript, { preTs, normTs }) => {
  window.location.href = `https://www.google.com/search?q=${preTs}`;
} }, "I'm Feeling Lucky": { pageFn: (transcript, { preTs, normTs }) => {
  window.location.href = `https://www.google.com/search?btnI=I%27m+Feeling+Lucky&q=${preTs}`;
} }, "Google Calendar": { pageFn: () => {
  window.location.href = "https://calendar.google.com/calendar/r";
} }, "Add Event to Google Calendar": { pageFn: () => {
  window.location.href = "https://calendar.google.com/calendar/r/eventedit";
} } } }))();

function initReSizerPage() {
  window.addEventListener("message", (event) => {
    if (event.data.type === "resize") {
      if (event.data.kind === "header") {
        const iframe = document.getElementById('headerframe');
        iframe.height = event.data.value + "px";
      }
      if (event.data.kind === "cv") {
        const cvframe = document.getElementById('cvframe');
        cvframe.height = event.data.value + "px";
      }
    }
  }, false);
}

function initReSizerChild(childName) {
  window.addEventListener("load", (event) => {
    const el = document.querySelector("html");
    
    const styles = window.getComputedStyle(el);
    const margin = parseFloat(styles['marginTop']) + parseFloat(styles['marginBottom']);
    const height = Math.ceil(el.offsetHeight + margin) + 5;

    window.parent.postMessage({
      type: "resize",
      value: height,
      kind: childName
    }, "*");
  });

}

function initReSizerHeader() {
  initReSizerChild("header");
}

function initReSizerCV() {
  initReSizerChild("cv");
}

/* Displays the first post */

/* Put your username here: */
const username = `zlflynn`;
const Converter = `https://api.rss2json.com/v1/api.json?rss_url=https://medium.com/feed/@${username}`;
const BlogWidgetId = "blogwidget" /* the id of the div you want to fill */

const getMediumFeed = async () => {
  const response = await fetch(Converter);
  const data = await response.json();
  return data;
};

const getLatest = async () => {
  const posts = await getMediumFeed();
  const post = posts.items[0]; /* Latest post */
  const title = post.title;
  const pubDate = post.pubDate;
  const link = post.link;
  const desc = post.description;
  const blog = document.getElementById(BlogWidgetId);

  blog.innerHTML = desc;
  var first = 0;

  /* find index of first paragraph */
  for (var i = 0; i < blog.children.length; i++) {
    if (blog.children[i].tagName === "P") {
      first = i;
      break;
    }
  }

  for (var i= blog.children.length; i-->0;) {
    if (i != first) {
      if ((blog.children[i].tagName != "H4") | (i > first)) {
        blog.removeChild(blog.children[i]);
      }
    }
    else {
      blog.children[i].innerHTML = blog.children[i].innerHTML + "...";
    }
    
  }
  blog.innerHTML = `<a href=\"${link}\">${title}</a><br/>${pubDate}<br/>` + 
    blog.innerHTML + 
    `<p><a href=\"${link}\">(continue)</a></p>`;
};

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

const username = `zlflynn`;
const RSSUrl = `https://medium.com/feed/@${username}`;
const RSSConverter = `https://api.rss2json.com/v1/api.json?rss_url=${RSSUrl}`;

const getMediumData = async () => {
    try {
        const response = await fetch(RSSConverter);
        const data = await response.json();
        console.log(data);
        return data
    } catch(error){
        console.log(error)
    }
};

const getLatest = async () => {
    const posts = await getMediumData();
    const post = posts.items[0]; // latest text (0 to 9)
    const title = post.title;
    const pubDate = post.pubDate;
    const link = post.link;
    const desc = post.description;
    const blog = document.getElementById('blogwidget');

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
            if ((blog.children[i].tagName != "H4") & (blog.children[i].tagName != "H2")) {
                blog.removeChild(blog.children[i]);
            }
        }
    }
    blog.innerHTML = `<a href=\"${link}\">${title}</a><br/>${pubDate}<br/>` + blog.innerHTML + `<p><a href=\"${link}\">(continue)</a></p>`;
};

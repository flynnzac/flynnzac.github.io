const username = `zlflynn`
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
    const blog = document.getElementById('blogwidget');
    console.log(post);
    console.log(blog);
    blog.innerHTML = `<a href=\"${link}\">${title}</a><br/>${pubDate}<br/>`;
};

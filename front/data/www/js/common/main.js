function appendScript(url) {
    const elem = document.createElement('script');
    elem.src = url;
    document.body.appendChild(elem);
}
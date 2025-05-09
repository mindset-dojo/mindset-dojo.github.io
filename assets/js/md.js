function initMD() {
    // moblie nav toggle
    var body = document.querySelector("body");
    var nav_menu_toggle = document.querySelector("header button");
    nav_menu_toggle.addEventListener("click", function() {
        body.classList.toggle("md-no-scroll");
        this.ariaExpanded = this.ariaExpanded !== 'true';
    });

    /*
    * Light YouTube Embeds by @labnol
    * Credit: https://www.labnol.org/
    */
    /* md-version */
    function labnolIframe(div) {
        var iframe = document.createElement('iframe');
        iframe.setAttribute('src', 'https://www.youtube.com/embed/' + div.dataset.id + '?autoplay=1');
        iframe.setAttribute('frameborder', '0');
        iframe.setAttribute('allowfullscreen', '1');
        iframe.setAttribute('scrolling', 'no');
        iframe.setAttribute('allow', 'accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture');
        div.appendChild(iframe);
    }

    function initYouTubeVideos() {
        var playerElements = document.querySelectorAll('.md-youtube-player');
        for (var n = 0; n < playerElements.length; n++) {
            var videoId = playerElements[n].dataset.id;
            var bgimgsrc = './assets/video-previews/' + playerElements[n].dataset.preview;
            var bgimgnosrc = '//i.ytimg.com/vi/ID/hqdefault.jpg'.replace('ID', videoId);
            if (playerElements[n].dataset.preview !== undefined && playerElements[n].dataset.preview !== '') {
                playerElements[n].style.backgroundImage = 'url('+bgimgsrc+')';
            } else {
                playerElements[n].style.backgroundImage = 'url('+bgimgnosrc+')';
            }
            var playButton = document.createElement('div');
            playButton.setAttribute('class', 'play');
            playerElements[n].appendChild(playButton);
            playerElements[n].onclick = function () {
            labnolIframe(this);
            this.style.backgroundImage = "none";
            };
        }
    }
    initYouTubeVideos();
}
document.addEventListener('DOMContentLoaded', initMD);

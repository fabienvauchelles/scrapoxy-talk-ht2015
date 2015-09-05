(function() {
    'use strict';

    var footerEl = document.getElementById('footer');
    
    Reveal.addEventListener('slidechanged', function(event) {
        if (event.indexh != 0 || event.indexv != 0) {
            footerEl.style.display = 'none';
        } else {
            footerEl.style.display = 'block';
        }
    });
})();

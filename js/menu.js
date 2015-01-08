$(document).ready(function() {

    $(".menu-item").hover(function() {
        $(this).animate({
            'margin-left': '+=95px'
        },1000);
    }, function() {
        $(this).animate({ 'margin-left': '-=95px' },1000);
    });
		
});
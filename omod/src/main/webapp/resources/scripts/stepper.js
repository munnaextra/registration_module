
function stepnext(n){

    if(n != 0){
		//$(".stepwizard-row a").switchClass('btn-primary','btn-default');
        $(".stepwizard-row a").removeClass('btn-primary');
        $(".stepwizard-row a").addClass('btn-default');
		$('.stepwizard a[href="#step-'+n+'"]').tab('show');
		//$('.stepwizard-row a[href="#step-'+n+'"]').switchClass('btn-default','btn-primary');
        $('.stepwizard-row a[href="#step-'+n+'"]').removeClass('btn-default');
        $('.stepwizard-row a[href="#step-'+n+'"]').addClass('btn-primary');
    }
}
stepnext(1);

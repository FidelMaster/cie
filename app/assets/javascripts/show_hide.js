// menu mobile
$(document).ready( function(){
	$("a").attr( "data-ajax", "false" );
} );

function unhide(divID) {
	var item = document.getElementById(divID);
	if (item) {
		if( item.className.indexOf("unhidden") != -1 ){
			item.className = item.className.replace( 'unhidden', 'hidden' );
		}else{
			item.className = item.className.replace( 'hidden', 'unhidden' );
		}
	}
	if (item) {
		if( item.className.indexOf("unselected") != -1 ){
			item.className = item.className.replace( 'unselected', 'selected' );
		}else{
			item.className = item.className.replace( 'selected', 'unselected' );
		}
	}
}
// hidding
function hide(divID) {
	var item = document.getElementById(divID);
	if (item) {
		if( item.className.indexOf("unselected") != -1 ){
			item.className = item.className.replace( 'unselected', 'unselected' );
		}else{
			item.className = item.className.replace( 'selected', 'unselected' );
		}
	}
}
$(function(){
    $('body').on('mouseover','.tooltip',function(){
      var $t = $(this);
    	var offset = $t.offset();
    	var timer = setTimeout(function(){
    		if(!$('#tooltip_hover')[0]){
    		    var ar_msg = [];
    		    ar_msg.push('<div id="tooltip_hover" class="tooltip-hover ihide">');
    		    ar_msg.push('<div class="line title"><span></span></div>');
    		    ar_msg.push('<div class="line msg"><i></i><span></span></div>');
    		    ar_msg.push('<div class="arrow"></div>');
    		    ar_msg.push('</div>');
    		    $('body').append(ar_msg.join(''));
    		}
    		var $msg = $('#tooltip_hover');
    		$msg.find('.line').hide();
    		var data = {};
    		data.title = $.trim($t.data('title'));
    		data.msg = $.trim($t.data('msg'));
    		$.each(data,function(i,n){
    			if(n && n !== ''){
    			    $msg.find('.line.'+i).show().find('span').html(n);
    			}
    		});
    		$msg.css('top', offset.top - $('#tooltip_hover').outerHeight() - 15).css('left', offset.left).fadeIn();
    	}, 500);
    	$t.data('timer', timer);
    });
    $('body').on('mouseout', '.tooltip', function(){
    	var timer = $(this).data('timer');
    	if(timer){
    	    clearTimeout(timer);
    	}
    	if($('#tooltip_hover').is(':visible')){
    	    $('#tooltip_hover').fadeOut();
    	}
    });
});

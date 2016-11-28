(function(){
    $.fn.loading = function(option){
        var $t = $(this);
        var loading_text = '<div class="fn_loading loading"><i></i><i></i><i></i></div>';
        if(option == "hide"){
            var $children = $t.find(".loading_clone").children();
            $t.append($children);
            $t.find(".loading_clone").remove();
            $t.find(".fn_loading").remove();
        }else{
            var $children = $t.children();
            var $clone = $('<div class="loading_clone hide"></div>').appendTo($t);
            $clone.append($children);
            $t.append(loading_text);
        }
        return $t;
    }
})(jQuery)

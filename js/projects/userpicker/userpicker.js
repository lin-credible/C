"use strict";

(function(){
	var _cache = {};
	var _defaults = {
		tabs:["mate","org","group","ext","contact"], //多选弹窗显示的tab页签
		multi : "y",//是否多选y or n
		external_member_option:false,
		ext_group:false,     //是否在外部显示全部外部成员
		at : 0,
		limits:{}, //限制只能从给定的id中选择。参数示例{"user":[222,333,444],"org":[444,555,666],"group":[234,35]},
		auth_limit : [],//权限范围。 示例值：["control"]。如control,则只能取下级。目前只限制了人员
		claim : 0,//是否显示待认领
		callback : function(res){},//点击确定后的回调函数。
		lock : 0, //是否锁住不可点击
		ext_all : 0,//是否显示全部外部成员，包括自己没有权限看到的
		with_not_actived : 0,	//是否可选未激活成员
		url : '' //自定义查询url。可参考日志统计表中选择发起人：ajax/userpicker/sch_share
	};
	var UserPicker = function(t){
		var options = t.data("option");
		this.ipt = t;
		this.tabs = options.tabs || this.ipt.data("tabs") || _defaults.tabs.slice(0, 4);
		this.external_member_option = options.external_member_option || this.ipt.data("external_member_option") || _defaults.external_member_option;

		if(iwk_user_type == 1 && !this.external_member_option){//如果是外部成员，tabs只允许是mate与group
			var _tabs = [];
			if($.inArray('mate',this.tabs) != -1){
				_tabs.push('mate');
			}
			if($.inArray('group',this.tabs) != -1){
				_tabs.push('group');
			}
			this.tabs = _tabs;
		}
		this.at = options.at || this.ipt.data("at") || _defaults.at;
		this.multi = options.multi || this.ipt.data("multi") || _defaults.multi;

		this.limits = options.limits || this.ipt.data("limits") || _defaults.limits;
		this.auth_limit = options.auth_limit || this.ipt.data("auth_limit") || _defaults.auth_limit;
		this.claim = options.claim || this.ipt.data("claim") || _defaults.claim;
		this.lock = options.lock || this.ipt.data("lock") || _defaults.lock;
		this.ext_all = options.ext_all || this.ipt.data("ext_all") || _defaults.ext_all;
		this.with_not_actived = options.with_not_actived || this.ipt.data("with_not_actived") || _defaults.with_not_actived;
		this.url = options.url || this.ipt.data("url") || _defaults.url;
		this.ext_group = $.fn.userpicker.EXT_GROUP|| options.ext_group || this.ipt.data("ext_group") || _defaults.ext_group;

		this.callback = options.callback || eval(this.ipt.data("callback"));
		this.init_picker();
		this.ele = $("#userpicker");
		this.init_data();
	}

	var methods = {
		lock : function(){
			var t = this;
			t.ipt.removeData("userpicker");
			t.ipt.data("lock",1);
			t.lock = 1;
			t.ipt.addClass("lock");
		},
		unlock : function(){
			var t = this;
			t.ipt.removeData("userpicker");
			t.ipt.data("lock",0);
			t.lock = 0;
			t.ipt.removeClass("lock");
		},
		//主动弹出选人窗口
		show : function(){
			var t = this;
			if(t.lock){
				return;
			}
			//判断在弹出选人控件之前是否已经存在模态窗口
			if($("body").is(".modal-open")){
				$("#userpicker").data("exist_modal",1);
			}
			$("#userpicker").modal("show");
			$("#userpicker .col1 .nav li:first").trigger("click");
		},
		//设置或者获取选人value，不传参数即为获取。format : {"is_claim":0,"user":[{id:1,name:'我是谁'}],"org":[],"group":[]}
		val : function(args){
			var t = this;
			if(args[0]){
				t.val = args[0];
				t.set_val();
			}else{
				var _res = {};
				if(t.ipt.find(".is_claim").length > 0){
					_res.is_claim = 1;
					return _res;
				}
				_res.user = [];
				_res.user_name = [];
				t.ipt.find(">.user").each(function(){
					$t = $(this);
					_res.user.push($t.attr("data"));
					_res.user_name.push($t.find('span').text());
				});
				_res.org = [];
				_res.org_name = [];
				t.ipt.find(">.org").each(function(){
					$t = $(this);
					_res.org.push($t.attr("data"));
					_res.org_name.push($t.find('span').text());
				});
				_res.group = [];
				_res.group_name = [];
				t.ipt.find(">.group").each(function(){
					$t = $(this);
					_res.group.push($t.attr("data"));
					_res.group_name.push($t.find('span').text());
				});
				_res.ext_group = [];
				t.ipt.find(">.ext_group").each(function(){
					$t = $(this);
					_res.ext_group.push($t.attr("data"));
				});
				_res.number = t.ipt.find(">div").length;
				return _res;
			}
		},
		clear : function(args){
			var t = this;
			t.ipt.empty();
		}
	}

	UserPicker.prototype = {
		//初始化选人弹窗
		init_picker : function(){
			var t = this;
			if(!t.ipt.is("[atwho]")){
				t.ipt.addClass("userpicker");
			}
			if(t.lock){
				t.ipt.addClass("lock");
			}else{
				t.ipt.removeClass("lock");
			}
			$("#userpicker").remove();
			var _html = '<div id="userpicker" class="modal picker_modal">\
			    <div class="modal-dialog">\
					<div class="modal-content">\
						<div class="modal-header">\
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>\
							<h4 class="modal-title">请选择人员</h4>\
						</div>\
						<div class="modal-body">\
							<div class="picker_cont clearfix">\
						    	<div class="col1">\
						    		<ul class="nav nav-stacked">\
									</ul>\
						    	</div>\
						    	<div class="col2">\
						    		<input type="text" class="form-control search_box">\
						    		<div class="body">\
						    		</div>\
						    	</div>\
						    	<div class="col3">\
						    		<div class="title">已选成员</div>\
						    		<div class="right_body">\
						    			<ul class="sel_ul user_list">\
							    		</ul>\
						    		</div>\
						    	</div>\
						    </div>\
						</div>\
					    <div class="modal-footer">\
					   		<button type="button" class="iwk blue fl selectall">全选</button>\
							<button type="button" class="iwk fl reselect">重选</button>\
							<button type="button" class="iwk cancel" data-dismiss="modal">取消</button>\
							<button type="button" class="iwk blue save">保存</button>\
						</div>\
				    </div>\
			    </div>\
		    </div>';
			$("body").append(_html);
			var _r = [];
			var _h = {mate:"成员",org:"部门",group:"群组",ext:"外部",contact:""};
			for(var i = 0;i < t.tabs.length;i++){
				var _tab = t.tabs[i];
				_r.push('<li data-type="'+_tab+'"><a href="javascript:;">'+_h[_tab]+'</a></li>');
			}
			$("#userpicker .col1 .nav").html(_r.join(""));
			$("#userpicker").modal({show:false});
			$('#userpicker').on('hidden.bs.modal', function (e) {
				if($("#userpicker").data("exist_modal")){
					$("body").addClass("modal-open");
				}
				$("#userpicker").remove();
				$("body").removeData("body-userpicker");
//				t.clear_userpicker();
				t.ipt.removeData("userpicker");
			})
		},
		set_val : function(){
			var t = this;
			var ipt = this.ipt;
			var _html = [];
			if(t.val.is_claim){
				_html.push('<div class="is_claim">待认领</div>');
			}else{
				if(t.val.user){
					$.each(t.val.user,function(i,n){
						_html.push('<div class="user" data="'+n.id+'">');
						_html.push('<span>'+n.name+'</span><i></i></div>');
					});
				}
				if(t.val.org){
					$.each(t.val.org,function(i,n){
						_html.push('<div class="org" data="'+n.id+'">');
						if(n.avatar){
							_html.push('<img src="'+n.avatar+'">');
						}
						_html.push('<span>'+n.name+'</span><i></i></div>');
					});
				}
				if(t.val.group){
					$.each(t.val.group,function(i,n){
						_html.push('<div class="group" data="'+n.id+'">');
						if(n.avatar){
							_html.push('<img src="'+n.avatar+'">');
						}
						_html.push('<span>'+n.name+'</span><i></i></div>');
					});
				}
				if(t.val.ext_group){
					$.each(t.val.ext_group,function(i,n){
						_html.push('<div class="ext_group" data="'+n.id+'">');
						if(n.avatar){
							_html.push('<img src="'+n.avatar+'">');
						}
						_html.push('<span>'+n.name+'</span><i></i></div>');
					});
				}
			}
			ipt.html(_html.join(""));
		},
		init_data : function(){
			this.init_right_data();
			this.bind_multi_event();
		},
		//选人控件输入框中的值需要显示在多选弹窗右侧
		init_right_data : function(){
			var arr_html =[];
			var t = this;
			var ipt = this.ipt;
			var $lis = ipt.find(">div");
			var _mates = {a:[]};
			var _orgs = {org:[],user:[]};
			var _groups = {group:[],project:[]};
			var _ext_groups = {ext_group:[]};
			$lis.each(function(){
				var $li = $(this);
				switch($li.attr("class")){
					case "user":
						_mates.a.push({id:$li.attr("data"),fullname:$li.find(">span").html(),ime:1});
						break;
					case "org":
						_orgs.org.push({id:$li.attr("data"),name:$li.find(">span").html()});
						break;
					case "group":
						_groups.group.push({id:$li.attr("data"),name:$li.find(">span").html()});
						break;
					case "ext_group":
						_ext_groups.ext_group.push({id:$li.attr("data"),name:$li.find(">span").html()});
						break;
				}
			});
			arr_html.push(t.get_mate_html(_mates).join(""));
			arr_html.push(t.get_org_html(_orgs).join(""));
			arr_html.push(t.get_group_html(_groups).join(""));
			arr_html.push(t.get_group_html(_ext_groups,"ext_group").join(""));
			this.ele.find(".sel_ul").html(arr_html.join(""));
			this.ele.find(".sel_ul li.title").remove();
		},
		//重置userpicker数据
		clear_userpicker : function(){
			$("#userpicker .sel_ul").empty();
		},
		//绑定多选框事件
		bind_multi_event : function(){
			var t = this;
			var ele = this.ele;
			//弹窗左侧导航栏点击事件
			ele.find(".nav li").click(function(){
				var $t = $(this);
				$t.addClass("active").siblings().removeClass("active");
				ele.find(".search_box").val("").unbind("keyup");
				ele.data("data_obj","");
				switch($t.data("type")){
					case "mate":
						t.load_mate();
						break;
					case "org":
						t.load_org();
						break;
					case "group":
						t.load_group();
						break;
					case "ext":
						t.load_ext();
						break;
					case "contact":
						t.load_contact();
						break;
				}
			});
			t.ipt.off("click.son").on("click.son",".user,.org,.group,.ext_group",function(e){
				if(!t.lock){
					$(this).remove();
					var _cls = $(this).attr("class");
					var _id = $(this).attr("data");
					var _name = $(this).find("span").html();
					//erp部分默认回填 add by xiuhaojun
					if(t.ipt.closest(".scene-container").length > 0){
						var target_items = t.ipt.data("target_items");
						if(target_items){
							var $scene_detail = t.ipt.closest(".scene_detail");
							var exist_ids = $scene_detail.find("[data-itemid='"+target_items[_cls+"_id"]+"']").val();
							var exist_names = $scene_detail.find("[data-itemid='"+target_items[_cls+"_name"]+"']").val();
							var exist_id_arr = exist_ids.split(",");
							var exist_name_arr = exist_names.split(",");
							exist_id_arr.splice($.inArray(_id,exist_id_arr),1);
							exist_name_arr.splice($.inArray(_name,exist_name_arr),1);
							$scene_detail.find("[data-itemid='"+target_items[_cls+"_id"]+"']").val(exist_id_arr.join(","));
							$scene_detail.find("[data-itemid='"+target_items[_cls+"_name"]+"']").val(exist_name_arr.join(","));
						}
						if(_cls == "user"){
							$scene_detail.find("[data-itemid='"+target_items["work_mobile"]+"']").val("");
						}
					}
				}
				iwk_common.stop_propagation(e);
			});
			ele.find(".col2").delegate(".mate_line,.org_line,.user_line,.group_line","click",function(e){e.stopPropagation();t.left_click(this,e);});
			ele.find(".col3").delegate(".mate_line,.org_line,.user_line,.group_line","click",function(e){e.stopPropagation();t.right_click(this,e);});
			ele.find(".selectall").click({that:this},t.selectall);
			ele.find(".reselect").click(t.reselect);
			ele.find(".save").unbind("click").bind("click",$.proxy(t.certain_multi,t));

			ele.on("click",".is_claim",function(){
				t.ipt.html('<div class="is_claim">待认领</div>');
				t.ele.modal("hide");
			});
		},
		//点击确定触发，将所有已选的内容保存到之前的选人控件中。
		certain_multi : function(){
			var t = this;
			var ele = t.ele;
			var arr_html = [];
			var arr_id = [];
			var $sels = ele.find(".sel_ul>li");
			var _type;
			var _res = {user:[],org:[],group:[],ext_group:[]};
			$sels.each(function(i,n){
				var $t = $(this);
				switch($.trim($t.attr("class"))){
					case "mate_line":
						_type = "user";
						_res[_type].push({id:$t.attr("data"),name:$t.find(".name").html(),work_mobile : $t.data("work_mobile"),org_name : $t.data("org_name") });
					break;
					case "org_line":
						_type = "org";
						_res[_type].push({id:$t.attr("data"),name:$t.find(".name").html()});
					break;
					case "group_line":
						_type = "group";
						_res[_type].push({id:$t.attr("data"),name:$t.find(".name").html()});
					break;
                    case "ext_group_line group_line":
                        _type = "ext_group";
                        _res[_type].push({id:$t.attr("data"),name:$t.find(".name").html()});
                        break;
				}
				arr_html.push('<div class="'+_type+'" data="'+$t.attr("data")+'"><span>'+$t.find(".name").html()+'</span><i></i></div>');
                arr_id.push($t.attr("data"));
			});
			t.ipt.html(arr_html.join(""));

			//erp部分默认回填 add by xiuhaojun
			if(t.ipt.closest(".scene-container").length > 0){
				var target_items = t.ipt.data("target_items");
				if(target_items){
					var $scene_detail = t.ipt.closest(".scene_detail");
					for(var i in _res){
						var _id = [];
						var _name = [];
						if(i == "user"){
							var _work_mobile = [];
						}
						for(var j in _res[i]){
							_id.push(_res[i][j].id);
							_name.push(_res[i][j].name);
							!!_work_mobile && (_work_mobile.push(_res[i][j].work_mobile));
						}
						$scene_detail.find("[data-itemid='"+target_items[i+"_id"]+"']").val(_id.join(","));
						$scene_detail.find("[data-itemid='"+target_items[i+"_name"]+"']").val(_name.join(","));
						!!_work_mobile && ($scene_detail.find("[data-itemid='"+target_items["work_mobile"]+"']").val(_work_mobile.join(",")));
					}
				}
			}

			t.ele.modal("hide");
			t.callback && t.callback(_res);
		},
		selectall : function(e){
			switch(e.data.that.ele.find(".nav li.active").data("type")){
				case "mate":
				case "group":
					$("#userpicker .unsel_ul li").click();
					break;
				case "org":
					$("#userpicker .unsel_ul li:first").click();
					break;
				case "ext":
					if($("#userpicker .unsel_ul li.ext_group_line").length > 0){
						$("#userpicker .unsel_ul li.ext_group_line").click();
					}else{
						$("#userpicker .unsel_ul li").click();
					}
					break;
			}

		},
		reselect : function(){
			$("#userpicker .sel_ul li").click();
		},
		//弹窗列表左侧点击事件
		left_click : function(t,e){
			var $this = $(t);
			var ele = this.ele;
			if($this.is(".disabled")){
				return;
			}
			var $new = $this.clone();
			if($new.is(".org_line")){
				$new.find("[data]").each(function(){
					ele.find(".sel_ul .org_line[data="+$(this).attr("data")+"]").remove();
				});
				$new.find(">ul").empty();
			}
			var _id = $this.attr("data");
			$this.closest("li").addClass("hide");
			ele.find(".sel_ul").append($new);
			ele.find(".right_body").scrollTop(ele.find(".sel_ul").height()-ele.find(".right_body").height());
			if(this.multi == "n"){
				this.ele.find(".sel_ul li:not(:last)").remove();
				this.certain_multi();
			}
			iwk_common.stop_propagation(e);
		},

		//弹窗列表右侧点击事件
		right_click : function(t,e){
			var $this = $(t);
			var ele = this.ele;
			var _id = $this.attr("data");
			ele.find(".unsel_ul li[class='"+$this.attr("class")+" hide'][data='"+_id+"']").removeClass("hide");
			$this.remove();
			iwk_common.stop_propagation(e);
		},
		//初始化按人员查询页签内容
		load_mate : function(){
			var t = this;
			var ele = this.ele;
			var _html = '<div class="firstchar_list">\
				<span>全部</span>\
				<span data-val="a">A</span><span data-val="b">B</span><span data-val="c">C</span><span data-val="d">D</span>\
				<span data-val="e">E</span><span data-val="f">F</span><span data-val="g">G</span><span data-val="h">H</span>\
				<span data-val="i">I</span><span data-val="j">J</span><span data-val="k">K</span><span data-val="l">L</span>\
				<span data-val="m">M</span><span data-val="n">N</span><span data-val="o">O</span><span data-val="p">P</span>\
				<span data-val="q">Q</span><span data-val="r">R</span><span data-val="s">S</span><span data-val="t">T</span>\
				<span data-val="u">U</span><span data-val="v">V</span><span data-val="w">W</span><span data-val="x">X</span>\
				<span data-val="y">Y</span><span data-val="z">Z</span>\
				</div>';
			if(t.claim){
				_html += '<div class="is_claim" data-val="is_claim"><i></i><span>待认领</span></div>';
				_html += '<div class="left_body with_claim">\
					<div class="loading" style="margin:100px auto;"><i></i><i></i><i></i></div>\
					<ul class="unsel_ul user_list">\
					</ul>\
					</div>'
				;
			}else{
				_html += '<div class="left_body">\
					<div class="loading" style="margin:100px auto;"><i></i><i></i><i></i></div>\
					<ul class="unsel_ul user_list">\
					</ul>\
					</div>'
				;
			}
			ele.find(".body").html(_html);
			ele.find(".search_box").bind("keyup",$.proxy(t.search_mates,t));
			ele.delegate(".firstchar_list span.enable","click",t.filter_mates);

			if(t.url){
				var _url = t.url;
			}else{
				var _url = iwk_cfg.siteurl + "ajax/muti_userpicker";
			}
			var _data = {type:"mate"};
			_data.user_type = 0;
			_data.onlyControlled = 0;
			_data.with_not_actived = t.with_not_actived;
			if (iwk_user_type == 1 && !this.external_member_option){
				_data.my_user_type = 1;
			}
			if(t.limits.user){
				_data.limit_user = t.limits.user;
				if(t.limits.user.length == 0){
					_data.limit_user = [-1];
				}
			}
			_data.auth_limit = t.auth_limit;
			var _key = _url + JSON.stringify(_data);
			if(!_cache[_key]){
				iwk_common.post(_url,_data,function(_data){
					_cache[_key] = _data;
					ele.data("data_obj",_data);
					var arr_html = t.get_mate_html(_data);
					ele.find(".left_body .loading").hide();
					ele.find(".unsel_ul").html(arr_html.join(""));
					ele.find(".search_box").focus();
				},'json');
			}else{
				_data = _cache[_key];
				ele.data("data_obj",_data);
				var arr_html = t.get_mate_html(_data);
				ele.find(".left_body .loading").hide();
				ele.find(".unsel_ul").html(arr_html.join(""));
				ele.find(".search_box").focus();
			}
		},
		//初始化按外部成员查询页签内容
		load_ext : function(){
			var t = this;
			var ele = this.ele;
			var _html = '<div class="firstchar_list">\
				<span>全部</span>\
				<span data-val="a">A</span><span data-val="b">B</span><span data-val="c">C</span><span data-val="d">D</span>\
				<span data-val="e">E</span><span data-val="f">F</span><span data-val="g">G</span><span data-val="h">H</span>\
				<span data-val="i">I</span><span data-val="j">J</span><span data-val="k">K</span><span data-val="l">L</span>\
				<span data-val="m">M</span><span data-val="n">N</span><span data-val="o">O</span><span data-val="p">P</span>\
				<span data-val="q">Q</span><span data-val="r">R</span><span data-val="s">S</span><span data-val="t">T</span>\
				<span data-val="u">U</span><span data-val="v">V</span><span data-val="w">W</span><span data-val="x">X</span>\
				<span data-val="y">Y</span><span data-val="z">Z</span>\
				</div>\
				<div class="left_body">\
				<div class="loading" style="margin:100px auto;"><i></i><i></i><i></i></div>\
				<ul class="unsel_ul user_list">\
				</ul>\
				</div>'
				;
			ele.find(".body").html(_html);
			ele.find(".search_box").bind("keyup",$.proxy(t.search_mates,t));
			ele.delegate(".firstchar_list span.enable","click",t.filter_mates);

			var _url = iwk_cfg.siteurl + "ajax/muti_userpicker";
			var _data = {type:"mate"};
			_data.user_type = 1;
			if(t.limits.user){
				_data.limit_user = t.limits.user;
				if(t.limits.user.length == 0){
					_data.limit_user = [-1];
				}
			}
			_data.ext_all = t.ext_all;
			iwk_common.post(_url,_data,function(_data){
				ele.data("data_obj",_data);
				var arr_html = t.get_mate_html(_data,t.ext_group);
				ele.find(".left_body .loading").hide();
				ele.find(".unsel_ul").html(arr_html.join(""));
				ele.find(".search_box").focus();
			},'json');
		},
		load_contact : function(){
			var t = this;
			var ele = this.ele;
			var _html = '<div class="firstchar_list">\
				<span>全部</span>\
				<span data-val="a">A</span><span data-val="b">B</span><span data-val="c">C</span><span data-val="d">D</span>\
				<span data-val="e">E</span><span data-val="f">F</span><span data-val="g">G</span><span data-val="h">H</span>\
				<span data-val="i">I</span><span data-val="j">J</span><span data-val="k">K</span><span data-val="l">L</span>\
				<span data-val="m">M</span><span data-val="n">N</span><span data-val="o">O</span><span data-val="p">P</span>\
				<span data-val="q">Q</span><span data-val="r">R</span><span data-val="s">S</span><span data-val="t">T</span>\
				<span data-val="u">U</span><span data-val="v">V</span><span data-val="w">W</span><span data-val="x">X</span>\
				<span data-val="y">Y</span><span data-val="z">Z</span>\
				</div>\
				<div class="left_body">\
				<div class="loading" style="margin:100px auto;"><i></i><i></i><i></i></div>\
				<ul class="unsel_ul user_list">\
				</ul>\
				</div>'
				;
			ele.find(".body").html(_html);
			ele.find(".search_box").bind("keyup",$.proxy(t.search_mates,t));
			ele.delegate(".firstchar_list span.enable","click",t.filter_mates);
			var _url = iwk_cfg.siteurl + "ajax/muti_userpicker";
			var _data = {type:"contact"};
			iwk_common.post(_url,_data,function(_data){
				ele.data("data_obj",_data);
				var arr_html = t.get_mate_html(_data);
				ele.find(".left_body .loading").hide();
				ele.find(".unsel_ul").html(arr_html.join(""));
				ele.find(".search_box").focus();
			},'json');
		},
		//根据数据生成html数据
		get_mate_html : function(_data,ext_all){
			var ele = this.ele;
			//获取右侧已显示的成员，左侧对应的成员要隐藏
			var selected = [];
			var $selected = ele.find(".sel_ul .mate_line");
			$selected.each(function(i,n){
				selected.push($(this).attr("data"));
			});

			$(".firstchar_list span").removeClass("enable");
			$(".firstchar_list span:first").addClass("enable");
			var arr_html = [];
			if(ext_all){
				var tmp = ele.find(".sel_ul .ext_group_line").length == 0;
				arr_html.push('<li class="ext_group_line group_line'+(tmp?"":" hide")+'" data="0"><a><div class="img"></div><div class="name">所有外部成员</div></a></li>');
			}
			for(var i in _data){
				$(".firstchar_list span[data-val='"+i.toLowerCase()+"']").addClass("enable");
				var arr_data = _data[i];
				arr_html.push('<li class="title" id="sec_'+i.toLowerCase()+'"><a>'+(i?i:"#")+'</a></li>');
				for(var j = 0;j < arr_data.length;j++){
					var o = arr_data[j];
					var is_hid = $.inArray(o.id,selected)==-1?"":" hide";
					arr_html.push('<li class="mate_line'+is_hid+'" section="'+i+'" data="'+o.id+'" data-org_name="'+ o.org_name+'" data-work_mobile="'+ o.work_mobile+'"><a>');
					if(iwk_cfg.private_id == 10 || iwk_cfg.private_id == 13){
						arr_html.push('<span title="'+ o.employee_number +'" class="name">'+o.fullname+'</span>');
					}else{
						arr_html.push('<span class="name">'+o.fullname+'</span>');
					}
					arr_html.push(o.org_name?('<span class="org">（'+o.org_name+'）</span>'):"");
					arr_html.push('</a></li>');
				}
			}
			return arr_html;
		},
		//根据A B C D等首字母过滤成员
		filter_mates : function(){
			var $t = $(this);
			var _id = $t.html().toLowerCase();
			if(_id == "全部"){
				_scrollTop = 0;
			}else{
				var $sec = $("#sec_"+_id);
				_scrollTop = $sec.position().top;
			}
			$("#userpicker .left_body").scrollTop(_scrollTop);
		},
		//根据输入框内容过滤成员
		search_mates : function(){
			var ele = this.ele;
			var mate_obj = ele.data("data_obj");
			var _search = $.trim(ele.find(".search_box").val());
			var _reg = new RegExp(_search,'i');
			//获取右侧已显示的成员，左侧对应的成员要隐藏
			var selected = [];
			var $selected = ele.find(".sel_ul .mate_line");
			$selected.each(function(i,n){
				selected.push($(this).attr("data"));
			});
			
			var arr_html = [];
			if(_search != ""){
				for(var i in mate_obj){
					//常用里的数据不进行搜索，否则会重复
					if(i == "常用"){
						continue;
					}
					var arr_data = mate_obj[i];
					for(var j = 0;j < arr_data.length;j++){
						var o = arr_data[j];
						var is_hid = $.inArray(o.id,selected)==-1?"":"hide";
						if((o.first_char && o.first_char.search(_reg) != -1) || (o.full_char && o.full_char.search(_reg) != -1) || o.fullname.search(_reg) != -1){
							arr_html.push('<li class="mate_line '+is_hid+'" section="'+i+'" data="'+o.id+'">');
							arr_html.push('<a>');
							arr_html.push('<span class="name">'+o.fullname+'</span>');
							arr_html.push('<span class="org">（'+o.org_name+'）</span>');
							arr_html.push('</a></li>');
						}
					}
				}
			}else{
				arr_html = this.get_mate_html(mate_obj);
			}
			ele.find(".unsel_ul").html(arr_html.join(""));
		},
		//初始化按组织查询页签内容
		load_org : function(){
			var t = this;
			var ele = t.ele;
			var $selected = ele.find(".sel_ul .org_line[data=0]").length;

			var _html = '<div class="left_body">\
				<ul class="unsel_ul user_list ztree">\
				<li class="org_line'+($selected?" hide":"")+'" data="0">\
				<a><span class="glyphicon switch glyphicon-menu-right" aria-hidden="true"></span><span class="name">全公司</span></a>\
				<ul></ul>\
				</li>\
				</ul></div>';
			ele.find(".body").html(_html).addClass("org_body");
			ele.find(".unsel_ul").delegate(".switch","click",function(e){t.change_state(this,e)});
			ele.find(".search_box").bind("keyup",function(){t.search_orgs();});
			t.change_state(ele.find(".unsel_ul li:first .switch"));
			//判断全公司是否在选择列表中，兼容数组类型和字符串类型
			if(t.limits.org){
				var isAllCompany = Math.max($.inArray("0",t.limits.org),$.inArray(0,t.limits.org));
				if(isAllCompany === -1){
					ele.find(".unsel_ul li:first>a").hide();
				}

			}
		},
		//点击组织左边三角触发事件
		change_state : function(icon,e){
			var t = this;
			var $icon = $(icon);
			if($icon.is(".glyphicon-menu-right")){
				$icon.removeClass("glyphicon-menu-right").addClass("glyphicon-menu-down");
				t.get_son($icon.closest(".org_line").attr("data"),$icon.closest(".org_line").find(">ul"));
			}else{
				$icon.removeClass("glyphicon-menu-down").addClass("glyphicon-menu-right");
				$icon.closest(".org_line").find(">ul").empty();
			}
			iwk_common.stop_propagation(e);
		},
		//根据组织ID获取下级组织和成员
		get_son : function(parent,$ul){
			var t = this;
			var ele = t.ele;
			if(t.url){
				var _url = t.url;
			}else{
				var _url = iwk_cfg.siteurl + "ajax/muti_userpicker";
			}
			var _data = {type:"org"};
			_data.parent = parent?parent:0;
			_data.onlyControlled = 0;
			if(t.limits.org){
				_data.limit_org = t.limits.org;
				if(t.limits.org.length == 0){
					_data.limit_org = [-1];
				}
			}
			iwk_common.post(_url,_data,function(_data){
				ele.data("data_obj",_data);
				arr_html = t.get_org_html(_data);
				ele.find(".left_body .loading").hide();
				$ul.html(arr_html.join(""));
			},'json');
		},

		//根据部门数据对象生成html代码
		get_org_html : function(_data){
			var t = this;
			var ele = t.ele;
			//获取右侧已显示的成员或部门，左侧对应的成员或部门要隐藏
			var selected_org = [];
			var $selected_org = ele.find(".sel_ul .org_line");
			$selected_org.each(function(i,n){
				selected_org.push($(this).attr("data"));
			});
			var selected_mate = [];
			var $selected_mate = ele.find(".sel_ul .mate_line");
			$selected_mate.each(function(i,n){
				selected_mate.push($(this).attr("data"));
			});

			var arr_html = [];
			for(var i = 0,l = _data.org.length;i < l;i++){
				var _org = _data.org[i];
				is_hid = $.inArray(_org.id,selected_org)==-1?"":" hide";
				arr_html.push('<li class="org_line'+is_hid+'" data="'+_org.id+'"><a>');
				arr_html.push('<span class="glyphicon switch glyphicon-menu-right" aria-hidden="true"></span>');
				arr_html.push('<span class="name">'+_org.name+'</span>');
				arr_html.push('</a><ul></ul></li>');
			}
			return arr_html;
		},

		//部门搜索
		search_orgs : function(){
			var t = this;
			var ele = t.ele;
			var _url = iwk_cfg.siteurl + "ajax/muti_userpicker";
			var _data = {type:"org"};
			_data.f = $.trim(ele.find(".search_box").val()).toLowerCase();
			_data.onlyControlled = 0;
			iwk_common.post(_url,_data,function(_data){
				arr_html = t.get_org_html(_data);
				ele.find(".unsel_ul").html(arr_html.join(""));
			},'json');
		},
		//初始化按群组查询
		load_group : function(){
			var t = this;
			var ele = t.ele;
			var _html = '<div class="left_body">\
						<div class="loading" style="margin:100px auto;"><i></i><i></i><i></i></div>\
		 				<ul class="unsel_ul user_list"></ul>\
		 			</div>';
			ele.find(".body").html(_html).addClass("group_body");
			var _url = iwk_cfg.siteurl + "ajax/muti_userpicker";
			var _data = {type:"group"};
			if(t.limits.group){
				_data.limit_group = t.limits.group;
				if(t.limits.group.length == 0){
					_data.limit_group =[-1];
				}
			}
			iwk_common.post(_url,_data,function(_data){
				ele.data("data_obj",_data);
				arr_html = t.get_group_html(_data);
				ele.find(".left_body .loading").hide();
				ele.find(".unsel_ul").html(arr_html.join(""));
			},'json');
			ele.find(".search_box").bind("keyup",$.proxy(t.search_group,t));
		},

		//根据组织数据对象生成相应的html代码
		get_group_html : function(_data,ext_group){
			var t = this;
			var ele = this.ele;
			//获取右侧已显示的群组，左侧对应的群组要隐藏
			var selected_groups = [];
			var $selected_groups = ele.find(".sel_ul .group_line");
			$selected_groups.each(function(i,n){
				selected_groups.push($(this).attr("data"));
			});

			var arr_html = [];
			_data.group = _data.group || _data.ext_group;
			arr_html.push('<li class="title"><a>群组</a></li>');
			for(var i = 0,l = _data.group.length;i < l;i++){
				var _group = _data.group[i];
				var is_hid = $.inArray(_group.id,selected_groups)==-1?"":" hide";
				arr_html.push('<li class="'+(ext_group?"ext_group_line ":"")+'group_line'+is_hid+'" data="'+_group.id+'"><a><div class="img"></div><div class="name">'+_group.name+'</div></a></li>');
			}
			if(_data.project) {
				arr_html.push('<li class="title"><a>项目组</a></li>');
				for (var i = 0, l = _data.project.length; i < l; i++) {
					var _project = _data.project[i];
					var is_hid = $.inArray(_project.id, selected_groups) == -1 ? "" : " hide";
					arr_html.push('<li class="group_line' + is_hid + '" data="' + _project.id + '"><a><div class="img"></div><div class="name">' + _project.name + '</div></a></li>');
				}
			}
			return arr_html;
		},

		//群组搜索
		search_group : function(){
			var t = this;
			var ele = t.ele;
			var mate_obj = ele.data("data_obj");
			var _search = $.trim(ele.find(".search_box").val());
			var _reg = new RegExp(_search,'i');
			var arr_html = [];
			var arr_obj = {group:[],project:[]};
			if(_search != ""){
				for(var i in mate_obj){
					var arr_data = mate_obj[i];
					for(var j = 0;j < arr_data.length;j++){
						var o = arr_data[j];
						if($.trim(o.first_char).search(_reg) != -1 || $.trim(o.full_char).search(_reg) != -1 || $.trim(o.name).search(_reg) != -1){
							arr_obj[i].push(o);
						}
					}
				}
			}else{
				arr_obj = mate_obj;
			}
			arr_html = t.get_group_html(arr_obj);
			ele.find(".unsel_ul").html(arr_html.join(""));
		}
	};

	$.fn.userpicker = function(_r){
		var option = {};
		if(_r && typeof _r == "object"){
			option = _r;
		}
		var args = Array.apply(null, arguments);
		args.shift();
		var _res;
		this.each(function(){
			var $this = $(this);
			$this.removeData("userpicker");
			var old_option = $this.data("option");
			if(old_option){
				option = $.extend(old_option, option);
			}
			$this.data("option",option);
			var _data = new UserPicker($this);
			$this.data("userpicker",_data);
			if(typeof _r == "string"){
				_res = methods[_r].call(_data, args);
				if(_res !== undefined){
					return false;
				}
			}
		});
		if (_res !== undefined)
			return _res;
		else
			return this;
	}

	$("body").on("click.userpicker",".userpicker",function(){
		if($(this).data("lock")){
			return;
		}
		if(!$("body").data("body-userpicker")){
			$("body").data("body-userpicker",1);
			$(this).userpicker("show");
		}
	});
})(jQuery);

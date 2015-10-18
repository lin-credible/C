<script type="text/javascript">

var link_id_now = $('#link_id').val();
var modle_id_now = $('#modle_id').val();
var options;
now = new Date();
year = "" + now.getFullYear();
month = "" + (now.getMonth() + 1); if (month.length == 1) { month = "0" + month; }
day = "" + now.getDate(); if (day.length == 1) { day = "0" + day; }
hour = "" + now.getHours(); if (hour.length == 1) { hour = "0" + hour; }
minute = "" + now.getMinutes(); if (minute.length == 1) { minute = "0" + minute; }
second = "" + now.getSeconds(); if (second.length == 1) { second = "0" + second; }
var default_time= year + "/" + month + "/" + day + " " + hour + ":" + minute;
var default_mode = '1';
mode_now.value=default_mode;
alarm_date.value=default_time;
	
$(function()
{
   options = {
	chart: {
		renderTo: 'div-bubble',
		type: 'bubble'
	},
	credits:{
		enabled:false
	},
	title: {
		text: null
	},
	xAxis: {
		type: 'datetime',
		dateTimeLabelFormats: {
			second: '%H:%M:%S',
			minute: '%H:%M',
			hour: '%H:%M',
			day: '%Y<br/>%m-%d',
			week: '%Y<br/>%m-%d',
			month: '%Y-%m',
			year: '%Y'
		}
	}, 
	yAxis: {
		gridLineWidth: 0.5,
		labels: {
			align: 'right',
			formatter: function() {
				var details=this.value;
				var x=details.indexOf("####");
				var module_id=details.slice(x+4);
				var module_name=details.substring(0,x);
				return '<div onclick="">'+module_name+'</div>';    
			},
			rotation: 0,
			step: 0,
			style: {
				color: '#000000',
				cursor: 'pointer',
				fontFamily: "Microsoft YaHei",
				fontSize: '13px'
			},
			useHTML: true
		},
		title: {
		   text: null
		},
		min:0,
		startOnTick:false,
		endOnTick:false,
		categories:[]
	},
	scrollbar: {
		enabled: true,
		height: 2,
		trackBackgroundColor: 'steelblue'
	},
	navigator:{
		enabled: true,
		height: 35,
		outlineColor: 'steelblue',
		outlineWidth: 1,
		maskInside: true
	},
	tooltip: {
	   useHTML: true,
	   crosshairs: [{
		   width: 1.2,
		   dashStyle: 'LongDashDotDot',
		   color: 'red'
	   }, {width: 1.2,color:'red',dashStyle:'LongDashDotDot'}],
	   pointFormat: '{point.name}',
	   backgroundColor: "rgba(255,255,255,1)"
	},
	rangeSelector: {
		buttonTheme: {
			fill: 'none',
			stroke: 'none',
			'stroke-width': 0,
			r: 8,
		style: {
			color: '#A2B5CD',
			fontWeight: 'bold'
			},
		states: {
			hover: {
				},
			select: {
				fill: '#A2B5CD',
				style: {
					color: 'white'
					}
				}
			}
		},
		enabled:true,
		buttons: [{
			type: 'minute',
			count: 30,
			text: '30M '
		}, {
			type: 'hour',
			count: 1,
			text: '1H '
		}, {
			type: 'hour',
			count: 3,
			text: '3H '
		}, {
			type: 'hour',
			count: 12,
			text: '12H '
		}, {
			type: 'all',
			text: 'ALL '
		}],
		labelStyle: {
			color: 'silver',
			fontWeight: 'bold',
			display: 'none'
		},
		inputBoxBorderColor: '#333333',
		inputEabled: false,
		inputBoxWidth: 1,
		inputDateFormat: '%b',
		selected: 5,
		inputStyle: {
            color: '#333333',
            fontWeight: 'normal'
        },
        labelStyle: {
            color: '#333333',
            fontWeight: 'normal'
        }
	},      

	legend: {
		enabled: true 
	},
	plotOptions: {
		bubble: {
		minSize: 22,
		maxSize: 22,
		cursor: 'pointer',
			point: {
			events: {
				click: function() {
					var renderer = this.series.chart.renderer;
					var point = this.graphic;
					var plotBox = point.renderer.plotBox;
					var path = renderer.path(['M',point.cx+plotBox.x,point.cy+plotBox.y,'L',900,30])
						.attr({
							'stroke-width': 0.3,
							stroke: 'red'
						}).add();
					this.graphic.animate({                                  
						opacity: 0.2
					});
					if($('#mode_now').val() == '2'){
					   var date_temp = $('#alarm_date').val();
					   var date_temp1 = date_temp.substr(0,10);
					   var date_temp3;
					   if((this.x+1)<10){
						   date_temp3= '0' + (this.x+1);
					   }else{
						   date_temp3= (this.x+1);
					   }
					   var date_temp2 = date_temp1+' '+ date_temp3 +':00:00';
					   ChangeMode(date_temp2,'2');
					}else if($('#mode_now').val() == '1'){
						var details=this.point.z;
						var w=details.indexOf("@@");
						var x=details.indexOf("##");
						var module_id=details.slice(x+2);
						var abc='<a href="http://xxx.com/show?mid='+module_id+'" target="_blank">☺</a>';
					   window.open("http://xxx.com/show?mid="+module_id);
					}
				}
			}
		},
		dataLabels: {
			 enabled: true,
			 useHTML: true,
			 style: { color: 'red',textShadow: 'none'},
			 formatter: function() {
				 var details1=this.point.name;
			 }
		}
	   }
	}, 
	series: []
	}

	$.getJSON("/path/to/cgi?link_id="+link_id_now+"&time="+default_time+"&mode="+$('#mode_now').val()+"&modle_id="+$('#modle_id').val()+"&iTwin="+$('#iTwin').val(), function(json) {
	options.yAxis.categories = json[1]['data'];
	options.series[0] = json[2];
	options.series[1] = json[3];
	options.series[2] = json[4];
	chart = new Highcharts.Chart(options);
	chart.rangeSelector.clickButton(2,{},true);
	});
});

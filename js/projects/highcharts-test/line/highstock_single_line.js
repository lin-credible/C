$(document).ready(function() {
    Highcharts.setOptions({
        global: {
            useUTC: false
        }
    });
    
    var allChart = {
        credits: {
            enabled: false
        },
        chart: {
            type: 'spline',
            borderWidth: 0
        },
        scrollbar : {
            enabled : true 
        },
        title: {
            text: null
        },
        tooltip: {
            shared: true,
            dateTimeLabelFormats: {
                day: '%Y年%m月%d日(%A)'
            }       
        },
        rangeSelector: {
            buttonTheme: { // styles for the buttons
                fill: 'none',
                stroke: 'none',
                'stroke-width': 0,
                r: 8,
            style: {
                //color: '#039',
                color: '#A2B5CD',
                fontWeight: 'bold'
                },
            states: {
                hover: {
                    },
                select: {
                    //fill: '#039',
                    fill: '#A2B5CD',
                    style: {
                        color: 'white'
                        }
                    }
                }
            },
            buttons: [{
                type: 'week',
                count: 2,
                text: '2W'
            }, {
                type: 'month',
                count: 1,
                text: '30D'
            }, {
                type: 'month',
                count: 3,
                text: '3M'
            }, {
                type: 'ytd',
                text: '1Y'
            }, {
                type: 'all',
                text: 'ALL'
            }],
            labelStyle: {
                color: 'silver',
                fontWeight: 'bold'
            },
            inputEabled: false,
            selected: 0
        },      
        yAxis: [{
            min: 0,
            startOnTick: false,
            endOnTick: false
        }, {
            linkedTo: 0,
            opposite: true
        }],
        series: []
    };
    var colors = ["#058DC7", "#ED561B", "#50B432", "#DDDF00", "#24CBE5", "#64E572", "#FF9655", "#FFF263", "#6AF9C4"];
    
    $.getJSON('highstock_single_line.php', function(data) {
        allChart.series = data;
        $('#Highstock_single_line').highcharts('StockChart', allChart);
    });
});

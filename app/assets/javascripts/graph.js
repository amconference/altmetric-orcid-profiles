
function plotTimes(data, colors){
  var resolution = 'month'
  function roundDate(d){
    return new Date(moment(d).startOf(resolution));
  }



  var finalData = [];

  var endDate = new roundDate(new Date());

  var startDate = new roundDate(moment().subtract(2,'years'));

  var allDates = [startDate];

  //get all discretized dates in the range
  var i = startDate;
  while (i < endDate){
    i = roundDate(moment(i).add(1,resolution));
    allDates.push(i);
  }


  //format finalData with counts for each date
  for (key in data) {
    if (data.hasOwnProperty(key)){
       var d = data[key].map(function(x){return roundDate(x)});
       var bins = {};
       allDates.forEach(function(date){
         bins[date]=0;
       });
       d.forEach(function(date){
         if (date > startDate){
           bins[date] = bins[date]+1;
         }
       });
       var counts = [];
       for (bin in bins){
         if (bins.hasOwnProperty(bin)){
            counts.push({x:new Date(bin),y:bins[bin]}); 
         }
       }
       finalData.push({key:key, values:counts, color: colors[key]});
    }
  }


  nv.addGraph(function() {
    var chart = nv.models.multiBarChart()
    .stacked(true)
    .margin({right: 100})
    .reduceXTicks(true)   //If 'false', every single x-axis tick label will be rendered.
    .rotateLabels(0)      //Angle to rotate x-axis labels.
    .showControls(true)   //Allow user to switch between 'Grouped' and 'Stacked' mode.
    .groupSpacing(0.1)    //Distance between each group of bars.
    ;

  chart.yAxis
    .tickFormat(d3.format(',.1f'));

  chart.xAxis.ticks(12).tickFormat(d3.time.format('%m/%y'));

  d3.select('#graph svg')
    .datum(finalData)
    .call(chart);

  nv.utils.windowResize(chart.update);
  return chart;

  }, function(){
  d3.selectAll(".nv-bar").on('click',
   function(a,b,c){
     window.lightbox.show(window.location.href + "/posts/" + encodeURIComponent(a.x.toJSON().replace('.', ',')) + "/" + a.series);
     return false;
   });
  });
}

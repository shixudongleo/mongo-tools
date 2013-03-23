// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

 window.onload = function(){

  var canvas = document.getElementById("myCanvas");
  var height = canvas.height;
  var width = canvas.width;
  var background_color = canvas.getAttribute("color");
  var count = canvas.getAttribute("count");

  paper.setup(canvas);
  with(paper){
    var rect = new Path.Rectangle(0, 0, width, height);
    rect.strokeColor = "white"
    rect.fillColor = background_color;

    var center = new Point(width / 2, height / 2);
    var factor = 3 / 4;
    var radius = height / 2 * factor;
    var point = new Point(center.x, center.y - radius);
    var stroke_width = height / 2 * 2 / 5;
    for (var i = 0; i < count; i++)
    {
      var percent = canvas.getAttribute("shard_" + i + "_size");
      var color = canvas.getAttribute("shard_" + i + "_color");
      var circle = new Path();
      circle.strokeWidth = stroke_width;
      circle.strokeColor = color;

      for (var j = 0; j < parseInt(360 * percent); j++)
      {
        circle.add(point);
        point = point.rotate(1, center);
      }
    }
    view.draw();

  }
}


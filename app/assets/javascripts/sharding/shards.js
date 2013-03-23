// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.onload = function(){

  var charts = document.getElementById("charts");
  var shards = charts.getElementsByTagName("canvas");
  console.log(shards);
  for (var i = 0; i < shards.length; i++){
    paper = new paper.PaperScope();
    var shard = shards[i];
    console.log(shard);
    var id = shard.id;
    console.log(id);
    paper.setup(id);

    //draw inert collections
    var count = shard.getAttribute("count");
    console.log(count);
    var total = shard.getAttribute("total");
    console.log(total);

    with (paper) {
      var rect = new Path.Rectangle(0, 0, 640, 50);
      rect.fillColor = "#3182bd";

      var j = 0;
      var x = 0;
      while (j < count){
        var collection_size = shard.getAttribute("collection_" + j + "_size");
        console.log(collection_size);
        var collection_color = shard.getAttribute("collection_" + j + "_color");
        console.log(collection_color);
        var len = collection_size * 640 / total;
        var coll_rect = new Path.Rectangle(x, 0, len, 50);
        x += len;
        coll_rect.fillColor = collection_color;

        j++;
      }

      view.draw();
    }   
  }
}

    



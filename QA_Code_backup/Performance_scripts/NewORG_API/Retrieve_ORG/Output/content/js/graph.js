/*
   Licensed to the Apache Software Foundation (ASF) under one or more
   contributor license agreements.  See the NOTICE file distributed with
   this work for additional information regarding copyright ownership.
   The ASF licenses this file to You under the Apache License, Version 2.0
   (the "License"); you may not use this file except in compliance with
   the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
$(document).ready(function() {

    $(".click-title").mouseenter( function(    e){
        e.preventDefault();
        this.style.cursor="pointer";
    });
    $(".click-title").mousedown( function(event){
        event.preventDefault();
    });

    // Ugly code while this script is shared among several pages
    try{
        refreshHitsPerSecond(true);
    } catch(e){}
    try{
        refreshResponseTimeOverTime(true);
    } catch(e){}
    try{
        refreshResponseTimePercentiles();
    } catch(e){}
});


var responseTimePercentilesInfos = {
        data: {"result": {"minY": 354.0, "minX": 0.0, "maxY": 3118.0, "series": [{"data": [[0.0, 354.0], [0.1, 354.0], [0.2, 354.0], [0.3, 354.0], [0.4, 354.0], [0.5, 354.0], [0.6, 354.0], [0.7, 354.0], [0.8, 354.0], [0.9, 364.0], [1.0, 364.0], [1.1, 364.0], [1.2, 364.0], [1.3, 364.0], [1.4, 364.0], [1.5, 364.0], [1.6, 364.0], [1.7, 372.0], [1.8, 372.0], [1.9, 372.0], [2.0, 372.0], [2.1, 372.0], [2.2, 372.0], [2.3, 372.0], [2.4, 372.0], [2.5, 375.0], [2.6, 375.0], [2.7, 375.0], [2.8, 375.0], [2.9, 375.0], [3.0, 375.0], [3.1, 375.0], [3.2, 375.0], [3.3, 375.0], [3.4, 377.0], [3.5, 377.0], [3.6, 377.0], [3.7, 377.0], [3.8, 377.0], [3.9, 377.0], [4.0, 377.0], [4.1, 377.0], [4.2, 385.0], [4.3, 385.0], [4.4, 385.0], [4.5, 385.0], [4.6, 385.0], [4.7, 385.0], [4.8, 385.0], [4.9, 385.0], [5.0, 389.0], [5.1, 389.0], [5.2, 389.0], [5.3, 389.0], [5.4, 389.0], [5.5, 389.0], [5.6, 389.0], [5.7, 389.0], [5.8, 389.0], [5.9, 397.0], [6.0, 397.0], [6.1, 397.0], [6.2, 397.0], [6.3, 397.0], [6.4, 397.0], [6.5, 397.0], [6.6, 397.0], [6.7, 404.0], [6.8, 404.0], [6.9, 404.0], [7.0, 404.0], [7.1, 404.0], [7.2, 404.0], [7.3, 404.0], [7.4, 404.0], [7.5, 406.0], [7.6, 406.0], [7.7, 406.0], [7.8, 406.0], [7.9, 406.0], [8.0, 406.0], [8.1, 406.0], [8.2, 406.0], [8.3, 406.0], [8.4, 416.0], [8.5, 416.0], [8.6, 416.0], [8.7, 416.0], [8.8, 416.0], [8.9, 416.0], [9.0, 416.0], [9.1, 416.0], [9.2, 426.0], [9.3, 426.0], [9.4, 426.0], [9.5, 426.0], [9.6, 426.0], [9.7, 426.0], [9.8, 426.0], [9.9, 426.0], [10.0, 440.0], [10.1, 440.0], [10.2, 440.0], [10.3, 440.0], [10.4, 440.0], [10.5, 440.0], [10.6, 440.0], [10.7, 440.0], [10.8, 440.0], [10.9, 440.0], [11.0, 440.0], [11.1, 440.0], [11.2, 440.0], [11.3, 440.0], [11.4, 440.0], [11.5, 440.0], [11.6, 440.0], [11.7, 444.0], [11.8, 444.0], [11.9, 444.0], [12.0, 444.0], [12.1, 444.0], [12.2, 444.0], [12.3, 444.0], [12.4, 444.0], [12.5, 464.0], [12.6, 464.0], [12.7, 464.0], [12.8, 464.0], [12.9, 464.0], [13.0, 464.0], [13.1, 464.0], [13.2, 464.0], [13.3, 464.0], [13.4, 471.0], [13.5, 471.0], [13.6, 471.0], [13.7, 471.0], [13.8, 471.0], [13.9, 471.0], [14.0, 471.0], [14.1, 471.0], [14.2, 476.0], [14.3, 476.0], [14.4, 476.0], [14.5, 476.0], [14.6, 476.0], [14.7, 476.0], [14.8, 476.0], [14.9, 476.0], [15.0, 476.0], [15.1, 481.0], [15.2, 481.0], [15.3, 481.0], [15.4, 481.0], [15.5, 481.0], [15.6, 481.0], [15.7, 481.0], [15.8, 481.0], [15.9, 485.0], [16.0, 485.0], [16.1, 485.0], [16.2, 485.0], [16.3, 485.0], [16.4, 485.0], [16.5, 485.0], [16.6, 485.0], [16.7, 485.0], [16.8, 485.0], [16.9, 485.0], [17.0, 485.0], [17.1, 485.0], [17.2, 485.0], [17.3, 485.0], [17.4, 485.0], [17.5, 485.0], [17.6, 489.0], [17.7, 489.0], [17.8, 489.0], [17.9, 489.0], [18.0, 489.0], [18.1, 489.0], [18.2, 489.0], [18.3, 489.0], [18.4, 490.0], [18.5, 490.0], [18.6, 490.0], [18.7, 490.0], [18.8, 490.0], [18.9, 490.0], [19.0, 490.0], [19.1, 490.0], [19.2, 491.0], [19.3, 491.0], [19.4, 491.0], [19.5, 491.0], [19.6, 491.0], [19.7, 491.0], [19.8, 491.0], [19.9, 491.0], [20.0, 503.0], [20.1, 503.0], [20.2, 503.0], [20.3, 503.0], [20.4, 503.0], [20.5, 503.0], [20.6, 503.0], [20.7, 503.0], [20.8, 503.0], [20.9, 507.0], [21.0, 507.0], [21.1, 507.0], [21.2, 507.0], [21.3, 507.0], [21.4, 507.0], [21.5, 507.0], [21.6, 507.0], [21.7, 509.0], [21.8, 509.0], [21.9, 509.0], [22.0, 509.0], [22.1, 509.0], [22.2, 509.0], [22.3, 509.0], [22.4, 509.0], [22.5, 515.0], [22.6, 515.0], [22.7, 515.0], [22.8, 515.0], [22.9, 515.0], [23.0, 515.0], [23.1, 515.0], [23.2, 515.0], [23.3, 515.0], [23.4, 518.0], [23.5, 518.0], [23.6, 518.0], [23.7, 518.0], [23.8, 518.0], [23.9, 518.0], [24.0, 518.0], [24.1, 518.0], [24.2, 520.0], [24.3, 520.0], [24.4, 520.0], [24.5, 520.0], [24.6, 520.0], [24.7, 520.0], [24.8, 520.0], [24.9, 520.0], [25.0, 522.0], [25.1, 522.0], [25.2, 522.0], [25.3, 522.0], [25.4, 522.0], [25.5, 522.0], [25.6, 522.0], [25.7, 522.0], [25.8, 522.0], [25.9, 526.0], [26.0, 526.0], [26.1, 526.0], [26.2, 526.0], [26.3, 526.0], [26.4, 526.0], [26.5, 526.0], [26.6, 526.0], [26.7, 527.0], [26.8, 527.0], [26.9, 527.0], [27.0, 527.0], [27.1, 527.0], [27.2, 527.0], [27.3, 527.0], [27.4, 527.0], [27.5, 535.0], [27.6, 535.0], [27.7, 535.0], [27.8, 535.0], [27.9, 535.0], [28.0, 535.0], [28.1, 535.0], [28.2, 535.0], [28.3, 535.0], [28.4, 539.0], [28.5, 539.0], [28.6, 539.0], [28.7, 539.0], [28.8, 539.0], [28.9, 539.0], [29.0, 539.0], [29.1, 539.0], [29.2, 540.0], [29.3, 540.0], [29.4, 540.0], [29.5, 540.0], [29.6, 540.0], [29.7, 540.0], [29.8, 540.0], [29.9, 540.0], [30.0, 540.0], [30.1, 540.0], [30.2, 540.0], [30.3, 540.0], [30.4, 540.0], [30.5, 540.0], [30.6, 540.0], [30.7, 540.0], [30.8, 540.0], [30.9, 546.0], [31.0, 546.0], [31.1, 546.0], [31.2, 546.0], [31.3, 546.0], [31.4, 546.0], [31.5, 546.0], [31.6, 546.0], [31.7, 547.0], [31.8, 547.0], [31.9, 547.0], [32.0, 547.0], [32.1, 547.0], [32.2, 547.0], [32.3, 547.0], [32.4, 547.0], [32.5, 552.0], [32.6, 552.0], [32.7, 552.0], [32.8, 552.0], [32.9, 552.0], [33.0, 552.0], [33.1, 552.0], [33.2, 552.0], [33.3, 552.0], [33.4, 562.0], [33.5, 562.0], [33.6, 562.0], [33.7, 562.0], [33.8, 562.0], [33.9, 562.0], [34.0, 562.0], [34.1, 562.0], [34.2, 569.0], [34.3, 569.0], [34.4, 569.0], [34.5, 569.0], [34.6, 569.0], [34.7, 569.0], [34.8, 569.0], [34.9, 569.0], [35.0, 570.0], [35.1, 570.0], [35.2, 570.0], [35.3, 570.0], [35.4, 570.0], [35.5, 570.0], [35.6, 570.0], [35.7, 570.0], [35.8, 570.0], [35.9, 570.0], [36.0, 570.0], [36.1, 570.0], [36.2, 570.0], [36.3, 570.0], [36.4, 570.0], [36.5, 570.0], [36.6, 570.0], [36.7, 585.0], [36.8, 585.0], [36.9, 585.0], [37.0, 585.0], [37.1, 585.0], [37.2, 585.0], [37.3, 585.0], [37.4, 585.0], [37.5, 592.0], [37.6, 592.0], [37.7, 592.0], [37.8, 592.0], [37.9, 592.0], [38.0, 592.0], [38.1, 592.0], [38.2, 592.0], [38.3, 592.0], [38.4, 602.0], [38.5, 602.0], [38.6, 602.0], [38.7, 602.0], [38.8, 602.0], [38.9, 602.0], [39.0, 602.0], [39.1, 602.0], [39.2, 617.0], [39.3, 617.0], [39.4, 617.0], [39.5, 617.0], [39.6, 617.0], [39.7, 617.0], [39.8, 617.0], [39.9, 617.0], [40.0, 622.0], [40.1, 622.0], [40.2, 622.0], [40.3, 622.0], [40.4, 622.0], [40.5, 622.0], [40.6, 622.0], [40.7, 622.0], [40.8, 622.0], [40.9, 627.0], [41.0, 627.0], [41.1, 627.0], [41.2, 627.0], [41.3, 627.0], [41.4, 627.0], [41.5, 627.0], [41.6, 627.0], [41.7, 633.0], [41.8, 633.0], [41.9, 633.0], [42.0, 633.0], [42.1, 633.0], [42.2, 633.0], [42.3, 633.0], [42.4, 633.0], [42.5, 633.0], [42.6, 642.0], [42.7, 642.0], [42.8, 642.0], [42.9, 642.0], [43.0, 642.0], [43.1, 642.0], [43.2, 642.0], [43.3, 642.0], [43.4, 649.0], [43.5, 649.0], [43.6, 649.0], [43.7, 649.0], [43.8, 649.0], [43.9, 649.0], [44.0, 649.0], [44.1, 649.0], [44.2, 659.0], [44.3, 659.0], [44.4, 659.0], [44.5, 659.0], [44.6, 659.0], [44.7, 659.0], [44.8, 659.0], [44.9, 659.0], [45.0, 659.0], [45.1, 668.0], [45.2, 668.0], [45.3, 668.0], [45.4, 668.0], [45.5, 668.0], [45.6, 668.0], [45.7, 668.0], [45.8, 668.0], [45.9, 668.0], [46.0, 668.0], [46.1, 668.0], [46.2, 668.0], [46.3, 668.0], [46.4, 668.0], [46.5, 668.0], [46.6, 668.0], [46.7, 682.0], [46.8, 682.0], [46.9, 682.0], [47.0, 682.0], [47.1, 682.0], [47.2, 682.0], [47.3, 682.0], [47.4, 682.0], [47.5, 682.0], [47.6, 692.0], [47.7, 692.0], [47.8, 692.0], [47.9, 692.0], [48.0, 692.0], [48.1, 692.0], [48.2, 692.0], [48.3, 692.0], [48.4, 693.0], [48.5, 693.0], [48.6, 693.0], [48.7, 693.0], [48.8, 693.0], [48.9, 693.0], [49.0, 693.0], [49.1, 693.0], [49.2, 761.0], [49.3, 761.0], [49.4, 761.0], [49.5, 761.0], [49.6, 761.0], [49.7, 761.0], [49.8, 761.0], [49.9, 761.0], [50.0, 761.0], [50.1, 776.0], [50.2, 776.0], [50.3, 776.0], [50.4, 776.0], [50.5, 776.0], [50.6, 776.0], [50.7, 776.0], [50.8, 776.0], [50.9, 808.0], [51.0, 808.0], [51.1, 808.0], [51.2, 808.0], [51.3, 808.0], [51.4, 808.0], [51.5, 808.0], [51.6, 808.0], [51.7, 889.0], [51.8, 889.0], [51.9, 889.0], [52.0, 889.0], [52.1, 889.0], [52.2, 889.0], [52.3, 889.0], [52.4, 889.0], [52.5, 889.0], [52.6, 1167.0], [52.7, 1167.0], [52.8, 1167.0], [52.9, 1167.0], [53.0, 1167.0], [53.1, 1167.0], [53.2, 1167.0], [53.3, 1167.0], [53.4, 1192.0], [53.5, 1192.0], [53.6, 1192.0], [53.7, 1192.0], [53.8, 1192.0], [53.9, 1192.0], [54.0, 1192.0], [54.1, 1192.0], [54.2, 1194.0], [54.3, 1194.0], [54.4, 1194.0], [54.5, 1194.0], [54.6, 1194.0], [54.7, 1194.0], [54.8, 1194.0], [54.9, 1194.0], [55.0, 1194.0], [55.1, 1211.0], [55.2, 1211.0], [55.3, 1211.0], [55.4, 1211.0], [55.5, 1211.0], [55.6, 1211.0], [55.7, 1211.0], [55.8, 1211.0], [55.9, 1221.0], [56.0, 1221.0], [56.1, 1221.0], [56.2, 1221.0], [56.3, 1221.0], [56.4, 1221.0], [56.5, 1221.0], [56.6, 1221.0], [56.7, 1228.0], [56.8, 1228.0], [56.9, 1228.0], [57.0, 1228.0], [57.1, 1228.0], [57.2, 1228.0], [57.3, 1228.0], [57.4, 1228.0], [57.5, 1228.0], [57.6, 1236.0], [57.7, 1236.0], [57.8, 1236.0], [57.9, 1236.0], [58.0, 1236.0], [58.1, 1236.0], [58.2, 1236.0], [58.3, 1236.0], [58.4, 1244.0], [58.5, 1244.0], [58.6, 1244.0], [58.7, 1244.0], [58.8, 1244.0], [58.9, 1244.0], [59.0, 1244.0], [59.1, 1244.0], [59.2, 1251.0], [59.3, 1251.0], [59.4, 1251.0], [59.5, 1251.0], [59.6, 1251.0], [59.7, 1251.0], [59.8, 1251.0], [59.9, 1251.0], [60.0, 1251.0], [60.1, 1259.0], [60.2, 1259.0], [60.3, 1259.0], [60.4, 1259.0], [60.5, 1259.0], [60.6, 1259.0], [60.7, 1259.0], [60.8, 1259.0], [60.9, 1260.0], [61.0, 1260.0], [61.1, 1260.0], [61.2, 1260.0], [61.3, 1260.0], [61.4, 1260.0], [61.5, 1260.0], [61.6, 1260.0], [61.7, 1262.0], [61.8, 1262.0], [61.9, 1262.0], [62.0, 1262.0], [62.1, 1262.0], [62.2, 1262.0], [62.3, 1262.0], [62.4, 1262.0], [62.5, 1262.0], [62.6, 1263.0], [62.7, 1263.0], [62.8, 1263.0], [62.9, 1263.0], [63.0, 1263.0], [63.1, 1263.0], [63.2, 1263.0], [63.3, 1263.0], [63.4, 1265.0], [63.5, 1265.0], [63.6, 1265.0], [63.7, 1265.0], [63.8, 1265.0], [63.9, 1265.0], [64.0, 1265.0], [64.1, 1265.0], [64.2, 1265.0], [64.3, 1265.0], [64.4, 1265.0], [64.5, 1265.0], [64.6, 1265.0], [64.7, 1265.0], [64.8, 1265.0], [64.9, 1265.0], [65.0, 1265.0], [65.1, 1282.0], [65.2, 1282.0], [65.3, 1282.0], [65.4, 1282.0], [65.5, 1282.0], [65.6, 1282.0], [65.7, 1282.0], [65.8, 1282.0], [65.9, 1284.0], [66.0, 1284.0], [66.1, 1284.0], [66.2, 1284.0], [66.3, 1284.0], [66.4, 1284.0], [66.5, 1284.0], [66.6, 1284.0], [66.7, 1289.0], [66.8, 1289.0], [66.9, 1289.0], [67.0, 1289.0], [67.1, 1289.0], [67.2, 1289.0], [67.3, 1289.0], [67.4, 1289.0], [67.5, 1289.0], [67.6, 1290.0], [67.7, 1290.0], [67.8, 1290.0], [67.9, 1290.0], [68.0, 1290.0], [68.1, 1290.0], [68.2, 1290.0], [68.3, 1290.0], [68.4, 1291.0], [68.5, 1291.0], [68.6, 1291.0], [68.7, 1291.0], [68.8, 1291.0], [68.9, 1291.0], [69.0, 1291.0], [69.1, 1291.0], [69.2, 1296.0], [69.3, 1296.0], [69.4, 1296.0], [69.5, 1296.0], [69.6, 1296.0], [69.7, 1296.0], [69.8, 1296.0], [69.9, 1296.0], [70.0, 1296.0], [70.1, 1306.0], [70.2, 1306.0], [70.3, 1306.0], [70.4, 1306.0], [70.5, 1306.0], [70.6, 1306.0], [70.7, 1306.0], [70.8, 1306.0], [70.9, 1307.0], [71.0, 1307.0], [71.1, 1307.0], [71.2, 1307.0], [71.3, 1307.0], [71.4, 1307.0], [71.5, 1307.0], [71.6, 1307.0], [71.7, 1307.0], [71.8, 1307.0], [71.9, 1307.0], [72.0, 1307.0], [72.1, 1307.0], [72.2, 1307.0], [72.3, 1307.0], [72.4, 1307.0], [72.5, 1307.0], [72.6, 1321.0], [72.7, 1321.0], [72.8, 1321.0], [72.9, 1321.0], [73.0, 1321.0], [73.1, 1321.0], [73.2, 1321.0], [73.3, 1321.0], [73.4, 1327.0], [73.5, 1327.0], [73.6, 1327.0], [73.7, 1327.0], [73.8, 1327.0], [73.9, 1327.0], [74.0, 1327.0], [74.1, 1327.0], [74.2, 1328.0], [74.3, 1328.0], [74.4, 1328.0], [74.5, 1328.0], [74.6, 1328.0], [74.7, 1328.0], [74.8, 1328.0], [74.9, 1328.0], [75.0, 1328.0], [75.1, 1336.0], [75.2, 1336.0], [75.3, 1336.0], [75.4, 1336.0], [75.5, 1336.0], [75.6, 1336.0], [75.7, 1336.0], [75.8, 1336.0], [75.9, 1341.0], [76.0, 1341.0], [76.1, 1341.0], [76.2, 1341.0], [76.3, 1341.0], [76.4, 1341.0], [76.5, 1341.0], [76.6, 1341.0], [76.7, 1354.0], [76.8, 1354.0], [76.9, 1354.0], [77.0, 1354.0], [77.1, 1354.0], [77.2, 1354.0], [77.3, 1354.0], [77.4, 1354.0], [77.5, 1356.0], [77.6, 1356.0], [77.7, 1356.0], [77.8, 1356.0], [77.9, 1356.0], [78.0, 1356.0], [78.1, 1356.0], [78.2, 1356.0], [78.3, 1356.0], [78.4, 1362.0], [78.5, 1362.0], [78.6, 1362.0], [78.7, 1362.0], [78.8, 1362.0], [78.9, 1362.0], [79.0, 1362.0], [79.1, 1362.0], [79.2, 1374.0], [79.3, 1374.0], [79.4, 1374.0], [79.5, 1374.0], [79.6, 1374.0], [79.7, 1374.0], [79.8, 1374.0], [79.9, 1374.0], [80.0, 1375.0], [80.1, 1375.0], [80.2, 1375.0], [80.3, 1375.0], [80.4, 1375.0], [80.5, 1375.0], [80.6, 1375.0], [80.7, 1375.0], [80.8, 1375.0], [80.9, 1379.0], [81.0, 1379.0], [81.1, 1379.0], [81.2, 1379.0], [81.3, 1379.0], [81.4, 1379.0], [81.5, 1379.0], [81.6, 1379.0], [81.7, 1383.0], [81.8, 1383.0], [81.9, 1383.0], [82.0, 1383.0], [82.1, 1383.0], [82.2, 1383.0], [82.3, 1383.0], [82.4, 1383.0], [82.5, 1387.0], [82.6, 1387.0], [82.7, 1387.0], [82.8, 1387.0], [82.9, 1387.0], [83.0, 1387.0], [83.1, 1387.0], [83.2, 1387.0], [83.3, 1387.0], [83.4, 1393.0], [83.5, 1393.0], [83.6, 1393.0], [83.7, 1393.0], [83.8, 1393.0], [83.9, 1393.0], [84.0, 1393.0], [84.1, 1393.0], [84.2, 1400.0], [84.3, 1400.0], [84.4, 1400.0], [84.5, 1400.0], [84.6, 1400.0], [84.7, 1400.0], [84.8, 1400.0], [84.9, 1400.0], [85.0, 1403.0], [85.1, 1403.0], [85.2, 1403.0], [85.3, 1403.0], [85.4, 1403.0], [85.5, 1403.0], [85.6, 1403.0], [85.7, 1403.0], [85.8, 1403.0], [85.9, 1411.0], [86.0, 1411.0], [86.1, 1411.0], [86.2, 1411.0], [86.3, 1411.0], [86.4, 1411.0], [86.5, 1411.0], [86.6, 1411.0], [86.7, 1414.0], [86.8, 1414.0], [86.9, 1414.0], [87.0, 1414.0], [87.1, 1414.0], [87.2, 1414.0], [87.3, 1414.0], [87.4, 1414.0], [87.5, 1428.0], [87.6, 1428.0], [87.7, 1428.0], [87.8, 1428.0], [87.9, 1428.0], [88.0, 1428.0], [88.1, 1428.0], [88.2, 1428.0], [88.3, 1428.0], [88.4, 1436.0], [88.5, 1436.0], [88.6, 1436.0], [88.7, 1436.0], [88.8, 1436.0], [88.9, 1436.0], [89.0, 1436.0], [89.1, 1436.0], [89.2, 1454.0], [89.3, 1454.0], [89.4, 1454.0], [89.5, 1454.0], [89.6, 1454.0], [89.7, 1454.0], [89.8, 1454.0], [89.9, 1454.0], [90.0, 1459.0], [90.1, 1459.0], [90.2, 1459.0], [90.3, 1459.0], [90.4, 1459.0], [90.5, 1459.0], [90.6, 1459.0], [90.7, 1459.0], [90.8, 1459.0], [90.9, 1511.0], [91.0, 1511.0], [91.1, 1511.0], [91.2, 1511.0], [91.3, 1511.0], [91.4, 1511.0], [91.5, 1511.0], [91.6, 1511.0], [91.7, 1529.0], [91.8, 1529.0], [91.9, 1529.0], [92.0, 1529.0], [92.1, 1529.0], [92.2, 1529.0], [92.3, 1529.0], [92.4, 1529.0], [92.5, 1541.0], [92.6, 1541.0], [92.7, 1541.0], [92.8, 1541.0], [92.9, 1541.0], [93.0, 1541.0], [93.1, 1541.0], [93.2, 1541.0], [93.3, 1541.0], [93.4, 1545.0], [93.5, 1545.0], [93.6, 1545.0], [93.7, 1545.0], [93.8, 1545.0], [93.9, 1545.0], [94.0, 1545.0], [94.1, 1545.0], [94.2, 1546.0], [94.3, 1546.0], [94.4, 1546.0], [94.5, 1546.0], [94.6, 1546.0], [94.7, 1546.0], [94.8, 1546.0], [94.9, 1546.0], [95.0, 1568.0], [95.1, 1568.0], [95.2, 1568.0], [95.3, 1568.0], [95.4, 1568.0], [95.5, 1568.0], [95.6, 1568.0], [95.7, 1568.0], [95.8, 1568.0], [95.9, 1573.0], [96.0, 1573.0], [96.1, 1573.0], [96.2, 1573.0], [96.3, 1573.0], [96.4, 1573.0], [96.5, 1573.0], [96.6, 1573.0], [96.7, 1627.0], [96.8, 1627.0], [96.9, 1627.0], [97.0, 1627.0], [97.1, 1627.0], [97.2, 1627.0], [97.3, 1627.0], [97.4, 1627.0], [97.5, 1934.0], [97.6, 1934.0], [97.7, 1934.0], [97.8, 1934.0], [97.9, 1934.0], [98.0, 1934.0], [98.1, 1934.0], [98.2, 1934.0], [98.3, 1934.0], [98.4, 2706.0], [98.5, 2706.0], [98.6, 2706.0], [98.7, 2706.0], [98.8, 2706.0], [98.9, 2706.0], [99.0, 2706.0], [99.1, 2706.0], [99.2, 3118.0], [99.3, 3118.0], [99.4, 3118.0], [99.5, 3118.0], [99.6, 3118.0], [99.7, 3118.0], [99.8, 3118.0], [99.9, 3118.0]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "maxX": 100.0, "title": "Response Time Percentiles"}},
        getOptions: function() {
            return {
                series: {
                    points: { show: false }
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendResponseTimePercentiles'
                },
                xaxis: {
                    tickDecimals: 1,
                    axisLabel: "Percentiles",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Percentile value in ms",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s : %x.2 percentile was %y ms"
                },
                selection: { mode: "xy" },
            };
        },
        createGraph: function() {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesResponseTimePercentiles"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotResponseTimesPercentiles"), dataset, options);
            // setup overview
            $.plot($("#overviewResponseTimesPercentiles"), dataset, prepareOverviewOptions(options));
        }
};

/**
 * @param elementId Id of element where we display message
 */
function setEmptyGraph(elementId) {
    $(function() {
        $(elementId).text("No graph series with filter="+seriesFilter);
    });
}

// Response times percentiles
function refreshResponseTimePercentiles() {
    var infos = responseTimePercentilesInfos;
    prepareSeries(infos.data);
    if(infos.data.result.series.length == 0) {
        setEmptyGraph("#bodyResponseTimePercentiles");
        return;
    }
    if (isGraph($("#flotResponseTimesPercentiles"))){
        infos.createGraph();
    } else {
        var choiceContainer = $("#choicesResponseTimePercentiles");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotResponseTimesPercentiles", "#overviewResponseTimesPercentiles");
        $('#bodyResponseTimePercentiles .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
}

var responseTimeDistributionInfos = {
        data: {"result": {"minY": 1.0, "minX": 300.0, "maxY": 22.0, "series": [{"data": [[600.0, 13.0], [700.0, 2.0], [2700.0, 1.0], [3100.0, 1.0], [800.0, 2.0], [1100.0, 3.0], [1200.0, 18.0], [300.0, 8.0], [1300.0, 17.0], [1400.0, 8.0], [1500.0, 7.0], [400.0, 16.0], [1600.0, 1.0], [1900.0, 1.0], [500.0, 22.0]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 100, "maxX": 3100.0, "title": "Response Time Distribution"}},
        getOptions: function() {
            var granularity = this.data.result.granularity;
            return {
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendResponseTimeDistribution'
                },
                xaxis:{
                    axisLabel: "Response times in ms",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Number of responses",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                bars : {
                    show: true,
                    barWidth: this.data.result.granularity
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: function(label, xval, yval, flotItem){
                        return yval + " responses for " + label + " were between " + xval + " and " + (xval + granularity) + " ms";
                    }
                }
            };
        },
        createGraph: function() {
            var data = this.data;
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotResponseTimeDistribution"), prepareData(data.result.series, $("#choicesResponseTimeDistribution")), options);
        }

};

// Response time distribution
function refreshResponseTimeDistribution() {
    var infos = responseTimeDistributionInfos;
    prepareSeries(infos.data);
    if(infos.data.result.series.length == 0) {
        setEmptyGraph("#bodyResponseTimeDistribution");
        return;
    }
    if (isGraph($("#flotResponseTimeDistribution"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesResponseTimeDistribution");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        $('#footerResponseTimeDistribution .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};


var syntheticResponseTimeDistributionInfos = {
        data: {"result": {"minY": 1.0, "minX": 0.0, "ticks": [[0, "Requests having \nresponse time <= 500ms"], [1, "Requests having \nresponse time > 500ms and <= 1,500ms"], [2, "Requests having \nresponse time > 1,500ms"], [3, "Requests in error"]], "maxY": 85.0, "series": [{"data": [[0.0, 23.0]], "color": "#9ACD32", "isOverall": false, "label": "Requests having \nresponse time <= 500ms", "isController": false}, {"data": [[1.0, 85.0]], "color": "yellow", "isOverall": false, "label": "Requests having \nresponse time > 500ms and <= 1,500ms", "isController": false}, {"data": [[2.0, 11.0]], "color": "orange", "isOverall": false, "label": "Requests having \nresponse time > 1,500ms", "isController": false}, {"data": [[3.0, 1.0]], "color": "#FF6347", "isOverall": false, "label": "Requests in error", "isController": false}], "supportsControllersDiscrimination": false, "maxX": 3.0, "title": "Synthetic Response Times Distribution"}},
        getOptions: function() {
            return {
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendSyntheticResponseTimeDistribution'
                },
                xaxis:{
                    axisLabel: "Response times ranges",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                    tickLength:0,
                    min:-0.5,
                    max:3.5
                },
                yaxis: {
                    axisLabel: "Number of responses",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                bars : {
                    show: true,
                    align: "center",
                    barWidth: 0.25,
                    fill:.75
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: function(label, xval, yval, flotItem){
                        return yval + " " + label;
                    }
                }
            };
        },
        createGraph: function() {
            var data = this.data;
            var options = this.getOptions();
            prepareOptions(options, data);
            options.xaxis.ticks = data.result.ticks;
            $.plot($("#flotSyntheticResponseTimeDistribution"), prepareData(data.result.series, $("#choicesSyntheticResponseTimeDistribution")), options);
        }

};

// Response time distribution
function refreshSyntheticResponseTimeDistribution() {
    var infos = syntheticResponseTimeDistributionInfos;
    prepareSeries(infos.data, true);
    if (isGraph($("#flotSyntheticResponseTimeDistribution"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesSyntheticResponseTimeDistribution");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        $('#footerSyntheticResponseTimeDistribution .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var activeThreadsOverTimeInfos = {
        data: {"result": {"minY": 1.0, "minX": 1.67947824E12, "maxY": 1.0, "series": [{"data": [[1.67947842E12, 1.0], [1.67947824E12, 1.0], [1.67947872E12, 1.0], [1.6794783E12, 1.0], [1.67947878E12, 1.0], [1.6794786E12, 1.0], [1.67947866E12, 1.0], [1.67947848E12, 1.0], [1.67947854E12, 1.0], [1.67947836E12, 1.0]], "isOverall": false, "label": "org_API", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.67947878E12, "title": "Active Threads Over Time"}},
        getOptions: function() {
            return {
                series: {
                    stack: true,
                    lines: {
                        show: true,
                        fill: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Number of active threads",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20
                },
                legend: {
                    noColumns: 6,
                    show: true,
                    container: '#legendActiveThreadsOverTime'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                selection: {
                    mode: 'xy'
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s : At %x there were %y active threads"
                }
            };
        },
        createGraph: function() {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesActiveThreadsOverTime"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotActiveThreadsOverTime"), dataset, options);
            // setup overview
            $.plot($("#overviewActiveThreadsOverTime"), dataset, prepareOverviewOptions(options));
        }
};

// Active Threads Over Time
function refreshActiveThreadsOverTime(fixTimestamps) {
    var infos = activeThreadsOverTimeInfos;
    prepareSeries(infos.data);
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotActiveThreadsOverTime"))) {
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesActiveThreadsOverTime");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotActiveThreadsOverTime", "#overviewActiveThreadsOverTime");
        $('#footerActiveThreadsOverTime .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var timeVsThreadsInfos = {
        data: {"result": {"minY": 955.7666666666668, "minX": 1.0, "maxY": 955.7666666666668, "series": [{"data": [[1.0, 955.7666666666668]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}, {"data": [[1.0, 955.7666666666668]], "isOverall": false, "label": "Org_api_Retrieve-Aggregated", "isController": false}], "supportsControllersDiscrimination": true, "maxX": 1.0, "title": "Time VS Threads"}},
        getOptions: function() {
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    axisLabel: "Number of active threads",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Average response times in ms",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20
                },
                legend: { noColumns: 2,show: true, container: '#legendTimeVsThreads' },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s: At %x.2 active threads, Average response time was %y.2 ms"
                }
            };
        },
        createGraph: function() {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesTimeVsThreads"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotTimesVsThreads"), dataset, options);
            // setup overview
            $.plot($("#overviewTimesVsThreads"), dataset, prepareOverviewOptions(options));
        }
};

// Time vs threads
function refreshTimeVsThreads(){
    var infos = timeVsThreadsInfos;
    prepareSeries(infos.data);
    if(infos.data.result.series.length == 0) {
        setEmptyGraph("#bodyTimeVsThreads");
        return;
    }
    if(isGraph($("#flotTimesVsThreads"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesTimeVsThreads");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotTimesVsThreads", "#overviewTimesVsThreads");
        $('#footerTimeVsThreads .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var bytesThroughputOverTimeInfos = {
        data : {"result": {"minY": 351.0, "minX": 1.67947824E12, "maxY": 403.4, "series": [{"data": [[1.67947842E12, 403.4], [1.67947824E12, 403.4], [1.67947872E12, 403.4], [1.6794783E12, 403.4], [1.67947878E12, 403.4], [1.6794786E12, 403.4], [1.67947866E12, 395.51666666666665], [1.67947848E12, 403.4], [1.67947854E12, 403.4], [1.67947836E12, 403.4]], "isOverall": false, "label": "Bytes received per second", "isController": false}, {"data": [[1.67947842E12, 351.0], [1.67947824E12, 351.0], [1.67947872E12, 351.0], [1.6794783E12, 351.0], [1.67947878E12, 351.0], [1.6794786E12, 351.0], [1.67947866E12, 351.0], [1.67947848E12, 351.0], [1.67947854E12, 351.0], [1.67947836E12, 351.0]], "isOverall": false, "label": "Bytes sent per second", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.67947878E12, "title": "Bytes Throughput Over Time"}},
        getOptions : function(){
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity) ,
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Bytes / sec",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendBytesThroughputOverTime'
                },
                selection: {
                    mode: "xy"
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s at %x was %y"
                }
            };
        },
        createGraph : function() {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesBytesThroughputOverTime"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotBytesThroughputOverTime"), dataset, options);
            // setup overview
            $.plot($("#overviewBytesThroughputOverTime"), dataset, prepareOverviewOptions(options));
        }
};

// Bytes throughput Over Time
function refreshBytesThroughputOverTime(fixTimestamps) {
    var infos = bytesThroughputOverTimeInfos;
    prepareSeries(infos.data);
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotBytesThroughputOverTime"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesBytesThroughputOverTime");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotBytesThroughputOverTime", "#overviewBytesThroughputOverTime");
        $('#footerBytesThroughputOverTime .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
}

var responseTimesOverTimeInfos = {
        data: {"result": {"minY": 746.4166666666667, "minX": 1.67947824E12, "maxY": 1100.1666666666667, "series": [{"data": [[1.67947842E12, 858.25], [1.67947824E12, 1036.5833333333335], [1.67947872E12, 1100.1666666666667], [1.6794783E12, 1086.1666666666665], [1.67947878E12, 746.4166666666667], [1.6794786E12, 821.9166666666667], [1.67947866E12, 894.9166666666669], [1.67947848E12, 1021.5833333333333], [1.67947854E12, 1033.4166666666667], [1.67947836E12, 958.2500000000001]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.67947878E12, "title": "Response Time Over Time"}},
        getOptions: function(){
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Average response time in ms",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendResponseTimesOverTime'
                },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s : at %x Average response time was %y ms"
                }
            };
        },
        createGraph: function() {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesResponseTimesOverTime"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotResponseTimesOverTime"), dataset, options);
            // setup overview
            $.plot($("#overviewResponseTimesOverTime"), dataset, prepareOverviewOptions(options));
        }
};

// Response Times Over Time
function refreshResponseTimeOverTime(fixTimestamps) {
    var infos = responseTimesOverTimeInfos;
    prepareSeries(infos.data);
    if(infos.data.result.series.length == 0) {
        setEmptyGraph("#bodyResponseTimeOverTime");
        return;
    }
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotResponseTimesOverTime"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesResponseTimesOverTime");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotResponseTimesOverTime", "#overviewResponseTimesOverTime");
        $('#footerResponseTimesOverTime .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var latenciesOverTimeInfos = {
        data: {"result": {"minY": 746.4166666666667, "minX": 1.67947824E12, "maxY": 1100.0833333333335, "series": [{"data": [[1.67947842E12, 858.25], [1.67947824E12, 1036.0833333333333], [1.67947872E12, 1100.0833333333335], [1.6794783E12, 1086.083333333333], [1.67947878E12, 746.4166666666667], [1.6794786E12, 821.6666666666666], [1.67947866E12, 894.75], [1.67947848E12, 1021.5833333333333], [1.67947854E12, 1033.3333333333335], [1.67947836E12, 958.1666666666667]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.67947878E12, "title": "Latencies Over Time"}},
        getOptions: function() {
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Average response latencies in ms",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendLatenciesOverTime'
                },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s : at %x Average latency was %y ms"
                }
            };
        },
        createGraph: function () {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesLatenciesOverTime"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotLatenciesOverTime"), dataset, options);
            // setup overview
            $.plot($("#overviewLatenciesOverTime"), dataset, prepareOverviewOptions(options));
        }
};

// Latencies Over Time
function refreshLatenciesOverTime(fixTimestamps) {
    var infos = latenciesOverTimeInfos;
    prepareSeries(infos.data);
    if(infos.data.result.series.length == 0) {
        setEmptyGraph("#bodyLatenciesOverTime");
        return;
    }
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotLatenciesOverTime"))) {
        infos.createGraph();
    }else {
        var choiceContainer = $("#choicesLatenciesOverTime");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotLatenciesOverTime", "#overviewLatenciesOverTime");
        $('#footerLatenciesOverTime .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var connectTimeOverTimeInfos = {
        data: {"result": {"minY": 147.25, "minX": 1.67947824E12, "maxY": 241.58333333333334, "series": [{"data": [[1.67947842E12, 181.83333333333331], [1.67947824E12, 211.41666666666666], [1.67947872E12, 241.58333333333334], [1.6794783E12, 197.91666666666663], [1.67947878E12, 208.91666666666669], [1.6794786E12, 147.25], [1.67947866E12, 216.08333333333331], [1.67947848E12, 218.66666666666666], [1.67947854E12, 227.41666666666669], [1.67947836E12, 226.16666666666669]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.67947878E12, "title": "Connect Time Over Time"}},
        getOptions: function() {
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getConnectTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Average Connect Time in ms",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendConnectTimeOverTime'
                },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s : at %x Average connect time was %y ms"
                }
            };
        },
        createGraph: function () {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesConnectTimeOverTime"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotConnectTimeOverTime"), dataset, options);
            // setup overview
            $.plot($("#overviewConnectTimeOverTime"), dataset, prepareOverviewOptions(options));
        }
};

// Connect Time Over Time
function refreshConnectTimeOverTime(fixTimestamps) {
    var infos = connectTimeOverTimeInfos;
    prepareSeries(infos.data);
    if(infos.data.result.series.length == 0) {
        setEmptyGraph("#bodyConnectTimeOverTime");
        return;
    }
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotConnectTimeOverTime"))) {
        infos.createGraph();
    }else {
        var choiceContainer = $("#choicesConnectTimeOverTime");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotConnectTimeOverTime", "#overviewConnectTimeOverTime");
        $('#footerConnectTimeOverTime .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var responseTimePercentilesOverTimeInfos = {
        data: {"result": {"minY": 354.0, "minX": 1.67947824E12, "maxY": 3118.0, "series": [{"data": [[1.67947842E12, 3118.0], [1.67947824E12, 1934.0], [1.67947872E12, 2706.0], [1.6794783E12, 1511.0], [1.67947878E12, 1383.0], [1.6794786E12, 1454.0], [1.67947866E12, 1546.0], [1.67947848E12, 1545.0], [1.67947854E12, 1573.0], [1.67947836E12, 1541.0]], "isOverall": false, "label": "Max", "isController": false}, {"data": [[1.67947842E12, 354.0], [1.67947824E12, 426.0], [1.67947872E12, 397.0], [1.6794783E12, 406.0], [1.67947878E12, 440.0], [1.6794786E12, 364.0], [1.67947866E12, 416.0], [1.67947848E12, 375.0], [1.67947854E12, 404.0], [1.67947836E12, 440.0]], "isOverall": false, "label": "Min", "isController": false}, {"data": [[1.67947842E12, 2574.7000000000016], [1.67947824E12, 1774.7000000000005], [1.67947872E12, 2382.300000000001], [1.6794783E12, 1486.1000000000001], [1.67947878E12, 1374.3], [1.6794786E12, 1442.0], [1.67947866E12, 1512.6000000000001], [1.67947848E12, 1504.8000000000002], [1.67947854E12, 1571.5], [1.67947836E12, 1516.4]], "isOverall": false, "label": "90th percentile", "isController": false}, {"data": [[1.67947842E12, 3118.0], [1.67947824E12, 1934.0], [1.67947872E12, 2706.0], [1.6794783E12, 1511.0], [1.67947878E12, 1383.0], [1.6794786E12, 1454.0], [1.67947866E12, 1546.0], [1.67947848E12, 1545.0], [1.67947854E12, 1573.0], [1.67947836E12, 1541.0]], "isOverall": false, "label": "99th percentile", "isController": false}, {"data": [[1.67947842E12, 549.5], [1.67947824E12, 1254.5], [1.67947872E12, 987.5], [1.6794783E12, 1289.0], [1.67947878E12, 540.5], [1.6794786E12, 600.5], [1.67947866E12, 649.0], [1.67947848E12, 1221.5], [1.67947854E12, 1298.0], [1.67947836E12, 1058.5]], "isOverall": false, "label": "Median", "isController": false}, {"data": [[1.67947842E12, 3118.0], [1.67947824E12, 1934.0], [1.67947872E12, 2706.0], [1.6794783E12, 1511.0], [1.67947878E12, 1383.0], [1.6794786E12, 1454.0], [1.67947866E12, 1546.0], [1.67947848E12, 1545.0], [1.67947854E12, 1573.0], [1.67947836E12, 1541.0]], "isOverall": false, "label": "95th percentile", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.67947878E12, "title": "Response Time Percentiles Over Time (successful requests only)"}},
        getOptions: function() {
            return {
                series: {
                    lines: {
                        show: true,
                        fill: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Response Time in ms",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: '#legendResponseTimePercentilesOverTime'
                },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s : at %x Response time was %y ms"
                }
            };
        },
        createGraph: function () {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesResponseTimePercentilesOverTime"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotResponseTimePercentilesOverTime"), dataset, options);
            // setup overview
            $.plot($("#overviewResponseTimePercentilesOverTime"), dataset, prepareOverviewOptions(options));
        }
};

// Response Time Percentiles Over Time
function refreshResponseTimePercentilesOverTime(fixTimestamps) {
    var infos = responseTimePercentilesOverTimeInfos;
    prepareSeries(infos.data);
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotResponseTimePercentilesOverTime"))) {
        infos.createGraph();
    }else {
        var choiceContainer = $("#choicesResponseTimePercentilesOverTime");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotResponseTimePercentilesOverTime", "#overviewResponseTimePercentilesOverTime");
        $('#footerResponseTimePercentilesOverTime .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};


var responseTimeVsRequestInfos = {
    data: {"result": {"minY": 481.0, "minX": 1.0, "maxY": 776.0, "series": [{"data": [[1.0, 776.0]], "isOverall": false, "label": "Successes", "isController": false}, {"data": [[1.0, 481.0]], "isOverall": false, "label": "Failures", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 1000, "maxX": 1.0, "title": "Response Time Vs Request"}},
    getOptions: function() {
        return {
            series: {
                lines: {
                    show: false
                },
                points: {
                    show: true
                }
            },
            xaxis: {
                axisLabel: "Global number of requests per second",
                axisLabelUseCanvas: true,
                axisLabelFontSizePixels: 12,
                axisLabelFontFamily: 'Verdana, Arial',
                axisLabelPadding: 20,
            },
            yaxis: {
                axisLabel: "Median Response Time in ms",
                axisLabelUseCanvas: true,
                axisLabelFontSizePixels: 12,
                axisLabelFontFamily: 'Verdana, Arial',
                axisLabelPadding: 20,
            },
            legend: {
                noColumns: 2,
                show: true,
                container: '#legendResponseTimeVsRequest'
            },
            selection: {
                mode: 'xy'
            },
            grid: {
                hoverable: true // IMPORTANT! this is needed for tooltip to work
            },
            tooltip: true,
            tooltipOpts: {
                content: "%s : Median response time at %x req/s was %y ms"
            },
            colors: ["#9ACD32", "#FF6347"]
        };
    },
    createGraph: function () {
        var data = this.data;
        var dataset = prepareData(data.result.series, $("#choicesResponseTimeVsRequest"));
        var options = this.getOptions();
        prepareOptions(options, data);
        $.plot($("#flotResponseTimeVsRequest"), dataset, options);
        // setup overview
        $.plot($("#overviewResponseTimeVsRequest"), dataset, prepareOverviewOptions(options));

    }
};

// Response Time vs Request
function refreshResponseTimeVsRequest() {
    var infos = responseTimeVsRequestInfos;
    prepareSeries(infos.data);
    if (isGraph($("#flotResponseTimeVsRequest"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesResponseTimeVsRequest");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotResponseTimeVsRequest", "#overviewResponseTimeVsRequest");
        $('#footerResponseRimeVsRequest .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};


var latenciesVsRequestInfos = {
    data: {"result": {"minY": 481.0, "minX": 1.0, "maxY": 776.0, "series": [{"data": [[1.0, 776.0]], "isOverall": false, "label": "Successes", "isController": false}, {"data": [[1.0, 481.0]], "isOverall": false, "label": "Failures", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 1000, "maxX": 1.0, "title": "Latencies Vs Request"}},
    getOptions: function() {
        return{
            series: {
                lines: {
                    show: false
                },
                points: {
                    show: true
                }
            },
            xaxis: {
                axisLabel: "Global number of requests per second",
                axisLabelUseCanvas: true,
                axisLabelFontSizePixels: 12,
                axisLabelFontFamily: 'Verdana, Arial',
                axisLabelPadding: 20,
            },
            yaxis: {
                axisLabel: "Median Latency in ms",
                axisLabelUseCanvas: true,
                axisLabelFontSizePixels: 12,
                axisLabelFontFamily: 'Verdana, Arial',
                axisLabelPadding: 20,
            },
            legend: { noColumns: 2,show: true, container: '#legendLatencyVsRequest' },
            selection: {
                mode: 'xy'
            },
            grid: {
                hoverable: true // IMPORTANT! this is needed for tooltip to work
            },
            tooltip: true,
            tooltipOpts: {
                content: "%s : Median Latency time at %x req/s was %y ms"
            },
            colors: ["#9ACD32", "#FF6347"]
        };
    },
    createGraph: function () {
        var data = this.data;
        var dataset = prepareData(data.result.series, $("#choicesLatencyVsRequest"));
        var options = this.getOptions();
        prepareOptions(options, data);
        $.plot($("#flotLatenciesVsRequest"), dataset, options);
        // setup overview
        $.plot($("#overviewLatenciesVsRequest"), dataset, prepareOverviewOptions(options));
    }
};

// Latencies vs Request
function refreshLatenciesVsRequest() {
        var infos = latenciesVsRequestInfos;
        prepareSeries(infos.data);
        if(isGraph($("#flotLatenciesVsRequest"))){
            infos.createGraph();
        }else{
            var choiceContainer = $("#choicesLatencyVsRequest");
            createLegend(choiceContainer, infos);
            infos.createGraph();
            setGraphZoomable("#flotLatenciesVsRequest", "#overviewLatenciesVsRequest");
            $('#footerLatenciesVsRequest .legendColorBox > div').each(function(i){
                $(this).clone().prependTo(choiceContainer.find("li").eq(i));
            });
        }
};

var hitsPerSecondInfos = {
        data: {"result": {"minY": 0.2, "minX": 1.67947824E12, "maxY": 0.2, "series": [{"data": [[1.67947842E12, 0.2], [1.67947824E12, 0.2], [1.67947872E12, 0.2], [1.6794783E12, 0.2], [1.67947878E12, 0.2], [1.6794786E12, 0.2], [1.67947866E12, 0.2], [1.67947848E12, 0.2], [1.67947854E12, 0.2], [1.67947836E12, 0.2]], "isOverall": false, "label": "hitsPerSecond", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.67947878E12, "title": "Hits Per Second"}},
        getOptions: function() {
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Number of hits / sec",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: "#legendHitsPerSecond"
                },
                selection: {
                    mode : 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s at %x was %y.2 hits/sec"
                }
            };
        },
        createGraph: function createGraph() {
            var data = this.data;
            var dataset = prepareData(data.result.series, $("#choicesHitsPerSecond"));
            var options = this.getOptions();
            prepareOptions(options, data);
            $.plot($("#flotHitsPerSecond"), dataset, options);
            // setup overview
            $.plot($("#overviewHitsPerSecond"), dataset, prepareOverviewOptions(options));
        }
};

// Hits per second
function refreshHitsPerSecond(fixTimestamps) {
    var infos = hitsPerSecondInfos;
    prepareSeries(infos.data);
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if (isGraph($("#flotHitsPerSecond"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesHitsPerSecond");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotHitsPerSecond", "#overviewHitsPerSecond");
        $('#footerHitsPerSecond .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
}

var codesPerSecondInfos = {
        data: {"result": {"minY": 0.016666666666666666, "minX": 1.67947824E12, "maxY": 0.2, "series": [{"data": [[1.67947842E12, 0.2], [1.67947824E12, 0.2], [1.67947872E12, 0.2], [1.6794783E12, 0.2], [1.67947878E12, 0.2], [1.6794786E12, 0.2], [1.67947866E12, 0.18333333333333332], [1.67947848E12, 0.2], [1.67947854E12, 0.2], [1.67947836E12, 0.2]], "isOverall": false, "label": "200", "isController": false}, {"data": [[1.67947866E12, 0.016666666666666666]], "isOverall": false, "label": "503", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.67947878E12, "title": "Codes Per Second"}},
        getOptions: function(){
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Number of responses / sec",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: "#legendCodesPerSecond"
                },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "Number of Response Codes %s at %x was %y.2 responses / sec"
                }
            };
        },
    createGraph: function() {
        var data = this.data;
        var dataset = prepareData(data.result.series, $("#choicesCodesPerSecond"));
        var options = this.getOptions();
        prepareOptions(options, data);
        $.plot($("#flotCodesPerSecond"), dataset, options);
        // setup overview
        $.plot($("#overviewCodesPerSecond"), dataset, prepareOverviewOptions(options));
    }
};

// Codes per second
function refreshCodesPerSecond(fixTimestamps) {
    var infos = codesPerSecondInfos;
    prepareSeries(infos.data);
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotCodesPerSecond"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesCodesPerSecond");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotCodesPerSecond", "#overviewCodesPerSecond");
        $('#footerCodesPerSecond .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var transactionsPerSecondInfos = {
        data: {"result": {"minY": 0.016666666666666666, "minX": 1.67947824E12, "maxY": 0.2, "series": [{"data": [[1.67947866E12, 0.016666666666666666]], "isOverall": false, "label": "Org_api_Retrieve-failure", "isController": false}, {"data": [[1.67947842E12, 0.2], [1.67947824E12, 0.2], [1.67947872E12, 0.2], [1.6794783E12, 0.2], [1.67947878E12, 0.2], [1.6794786E12, 0.2], [1.67947866E12, 0.18333333333333332], [1.67947848E12, 0.2], [1.67947854E12, 0.2], [1.67947836E12, 0.2]], "isOverall": false, "label": "Org_api_Retrieve-success", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.67947878E12, "title": "Transactions Per Second"}},
        getOptions: function(){
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Number of transactions / sec",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: "#legendTransactionsPerSecond"
                },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s at %x was %y transactions / sec"
                }
            };
        },
    createGraph: function () {
        var data = this.data;
        var dataset = prepareData(data.result.series, $("#choicesTransactionsPerSecond"));
        var options = this.getOptions();
        prepareOptions(options, data);
        $.plot($("#flotTransactionsPerSecond"), dataset, options);
        // setup overview
        $.plot($("#overviewTransactionsPerSecond"), dataset, prepareOverviewOptions(options));
    }
};

// Transactions per second
function refreshTransactionsPerSecond(fixTimestamps) {
    var infos = transactionsPerSecondInfos;
    prepareSeries(infos.data);
    if(infos.data.result.series.length == 0) {
        setEmptyGraph("#bodyTransactionsPerSecond");
        return;
    }
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotTransactionsPerSecond"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesTransactionsPerSecond");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotTransactionsPerSecond", "#overviewTransactionsPerSecond");
        $('#footerTransactionsPerSecond .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

var totalTPSInfos = {
        data: {"result": {"minY": 0.016666666666666666, "minX": 1.67947824E12, "maxY": 0.2, "series": [{"data": [[1.67947842E12, 0.2], [1.67947824E12, 0.2], [1.67947872E12, 0.2], [1.6794783E12, 0.2], [1.67947878E12, 0.2], [1.6794786E12, 0.2], [1.67947866E12, 0.18333333333333332], [1.67947848E12, 0.2], [1.67947854E12, 0.2], [1.67947836E12, 0.2]], "isOverall": false, "label": "Transaction-success", "isController": false}, {"data": [[1.67947866E12, 0.016666666666666666]], "isOverall": false, "label": "Transaction-failure", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.67947878E12, "title": "Total Transactions Per Second"}},
        getOptions: function(){
            return {
                series: {
                    lines: {
                        show: true
                    },
                    points: {
                        show: true
                    }
                },
                xaxis: {
                    mode: "time",
                    timeformat: getTimeFormat(this.data.result.granularity),
                    axisLabel: getElapsedTimeLabel(this.data.result.granularity),
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20,
                },
                yaxis: {
                    axisLabel: "Number of transactions / sec",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Verdana, Arial',
                    axisLabelPadding: 20
                },
                legend: {
                    noColumns: 2,
                    show: true,
                    container: "#legendTotalTPS"
                },
                selection: {
                    mode: 'xy'
                },
                grid: {
                    hoverable: true // IMPORTANT! this is needed for tooltip to
                                    // work
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s at %x was %y transactions / sec"
                },
                colors: ["#9ACD32", "#FF6347"]
            };
        },
    createGraph: function () {
        var data = this.data;
        var dataset = prepareData(data.result.series, $("#choicesTotalTPS"));
        var options = this.getOptions();
        prepareOptions(options, data);
        $.plot($("#flotTotalTPS"), dataset, options);
        // setup overview
        $.plot($("#overviewTotalTPS"), dataset, prepareOverviewOptions(options));
    }
};

// Total Transactions per second
function refreshTotalTPS(fixTimestamps) {
    var infos = totalTPSInfos;
    // We want to ignore seriesFilter
    prepareSeries(infos.data, false, true);
    if(fixTimestamps) {
        fixTimeStamps(infos.data.result.series, 19800000);
    }
    if(isGraph($("#flotTotalTPS"))){
        infos.createGraph();
    }else{
        var choiceContainer = $("#choicesTotalTPS");
        createLegend(choiceContainer, infos);
        infos.createGraph();
        setGraphZoomable("#flotTotalTPS", "#overviewTotalTPS");
        $('#footerTotalTPS .legendColorBox > div').each(function(i){
            $(this).clone().prependTo(choiceContainer.find("li").eq(i));
        });
    }
};

// Collapse the graph matching the specified DOM element depending the collapsed
// status
function collapse(elem, collapsed){
    if(collapsed){
        $(elem).parent().find(".fa-chevron-up").removeClass("fa-chevron-up").addClass("fa-chevron-down");
    } else {
        $(elem).parent().find(".fa-chevron-down").removeClass("fa-chevron-down").addClass("fa-chevron-up");
        if (elem.id == "bodyBytesThroughputOverTime") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshBytesThroughputOverTime(true);
            }
            document.location.href="#bytesThroughputOverTime";
        } else if (elem.id == "bodyLatenciesOverTime") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshLatenciesOverTime(true);
            }
            document.location.href="#latenciesOverTime";
        } else if (elem.id == "bodyCustomGraph") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshCustomGraph(true);
            }
            document.location.href="#responseCustomGraph";
        } else if (elem.id == "bodyConnectTimeOverTime") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshConnectTimeOverTime(true);
            }
            document.location.href="#connectTimeOverTime";
        } else if (elem.id == "bodyResponseTimePercentilesOverTime") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshResponseTimePercentilesOverTime(true);
            }
            document.location.href="#responseTimePercentilesOverTime";
        } else if (elem.id == "bodyResponseTimeDistribution") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshResponseTimeDistribution();
            }
            document.location.href="#responseTimeDistribution" ;
        } else if (elem.id == "bodySyntheticResponseTimeDistribution") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshSyntheticResponseTimeDistribution();
            }
            document.location.href="#syntheticResponseTimeDistribution" ;
        } else if (elem.id == "bodyActiveThreadsOverTime") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshActiveThreadsOverTime(true);
            }
            document.location.href="#activeThreadsOverTime";
        } else if (elem.id == "bodyTimeVsThreads") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshTimeVsThreads();
            }
            document.location.href="#timeVsThreads" ;
        } else if (elem.id == "bodyCodesPerSecond") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshCodesPerSecond(true);
            }
            document.location.href="#codesPerSecond";
        } else if (elem.id == "bodyTransactionsPerSecond") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshTransactionsPerSecond(true);
            }
            document.location.href="#transactionsPerSecond";
        } else if (elem.id == "bodyTotalTPS") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshTotalTPS(true);
            }
            document.location.href="#totalTPS";
        } else if (elem.id == "bodyResponseTimeVsRequest") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshResponseTimeVsRequest();
            }
            document.location.href="#responseTimeVsRequest";
        } else if (elem.id == "bodyLatenciesVsRequest") {
            if (isGraph($(elem).find('.flot-chart-content')) == false) {
                refreshLatenciesVsRequest();
            }
            document.location.href="#latencyVsRequest";
        }
    }
}

/*
 * Activates or deactivates all series of the specified graph (represented by id parameter)
 * depending on checked argument.
 */
function toggleAll(id, checked){
    var placeholder = document.getElementById(id);

    var cases = $(placeholder).find(':checkbox');
    cases.prop('checked', checked);
    $(cases).parent().children().children().toggleClass("legend-disabled", !checked);

    var choiceContainer;
    if ( id == "choicesBytesThroughputOverTime"){
        choiceContainer = $("#choicesBytesThroughputOverTime");
        refreshBytesThroughputOverTime(false);
    } else if(id == "choicesResponseTimesOverTime"){
        choiceContainer = $("#choicesResponseTimesOverTime");
        refreshResponseTimeOverTime(false);
    }else if(id == "choicesResponseCustomGraph"){
        choiceContainer = $("#choicesResponseCustomGraph");
        refreshCustomGraph(false);
    } else if ( id == "choicesLatenciesOverTime"){
        choiceContainer = $("#choicesLatenciesOverTime");
        refreshLatenciesOverTime(false);
    } else if ( id == "choicesConnectTimeOverTime"){
        choiceContainer = $("#choicesConnectTimeOverTime");
        refreshConnectTimeOverTime(false);
    } else if ( id == "choicesResponseTimePercentilesOverTime"){
        choiceContainer = $("#choicesResponseTimePercentilesOverTime");
        refreshResponseTimePercentilesOverTime(false);
    } else if ( id == "choicesResponseTimePercentiles"){
        choiceContainer = $("#choicesResponseTimePercentiles");
        refreshResponseTimePercentiles();
    } else if(id == "choicesActiveThreadsOverTime"){
        choiceContainer = $("#choicesActiveThreadsOverTime");
        refreshActiveThreadsOverTime(false);
    } else if ( id == "choicesTimeVsThreads"){
        choiceContainer = $("#choicesTimeVsThreads");
        refreshTimeVsThreads();
    } else if ( id == "choicesSyntheticResponseTimeDistribution"){
        choiceContainer = $("#choicesSyntheticResponseTimeDistribution");
        refreshSyntheticResponseTimeDistribution();
    } else if ( id == "choicesResponseTimeDistribution"){
        choiceContainer = $("#choicesResponseTimeDistribution");
        refreshResponseTimeDistribution();
    } else if ( id == "choicesHitsPerSecond"){
        choiceContainer = $("#choicesHitsPerSecond");
        refreshHitsPerSecond(false);
    } else if(id == "choicesCodesPerSecond"){
        choiceContainer = $("#choicesCodesPerSecond");
        refreshCodesPerSecond(false);
    } else if ( id == "choicesTransactionsPerSecond"){
        choiceContainer = $("#choicesTransactionsPerSecond");
        refreshTransactionsPerSecond(false);
    } else if ( id == "choicesTotalTPS"){
        choiceContainer = $("#choicesTotalTPS");
        refreshTotalTPS(false);
    } else if ( id == "choicesResponseTimeVsRequest"){
        choiceContainer = $("#choicesResponseTimeVsRequest");
        refreshResponseTimeVsRequest();
    } else if ( id == "choicesLatencyVsRequest"){
        choiceContainer = $("#choicesLatencyVsRequest");
        refreshLatenciesVsRequest();
    }
    var color = checked ? "black" : "#818181";
    if(choiceContainer != null) {
        choiceContainer.find("label").each(function(){
            this.style.color = color;
        });
    }
}


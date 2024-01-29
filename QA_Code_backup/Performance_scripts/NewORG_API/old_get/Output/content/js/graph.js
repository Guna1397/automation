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
        data: {"result": {"minY": 322.0, "minX": 0.0, "maxY": 4266.0, "series": [{"data": [[0.0, 322.0], [0.1, 322.0], [0.2, 322.0], [0.3, 322.0], [0.4, 322.0], [0.5, 322.0], [0.6, 322.0], [0.7, 322.0], [0.8, 322.0], [0.9, 322.0], [1.0, 322.0], [1.1, 322.0], [1.2, 351.0], [1.3, 351.0], [1.4, 351.0], [1.5, 351.0], [1.6, 351.0], [1.7, 351.0], [1.8, 351.0], [1.9, 351.0], [2.0, 351.0], [2.1, 351.0], [2.2, 351.0], [2.3, 352.0], [2.4, 352.0], [2.5, 352.0], [2.6, 352.0], [2.7, 352.0], [2.8, 352.0], [2.9, 352.0], [3.0, 352.0], [3.1, 352.0], [3.2, 352.0], [3.3, 352.0], [3.4, 360.0], [3.5, 360.0], [3.6, 360.0], [3.7, 360.0], [3.8, 360.0], [3.9, 360.0], [4.0, 360.0], [4.1, 360.0], [4.2, 360.0], [4.3, 360.0], [4.4, 360.0], [4.5, 382.0], [4.6, 382.0], [4.7, 382.0], [4.8, 382.0], [4.9, 382.0], [5.0, 382.0], [5.1, 382.0], [5.2, 382.0], [5.3, 382.0], [5.4, 382.0], [5.5, 382.0], [5.6, 404.0], [5.7, 404.0], [5.8, 404.0], [5.9, 404.0], [6.0, 404.0], [6.1, 404.0], [6.2, 404.0], [6.3, 404.0], [6.4, 404.0], [6.5, 404.0], [6.6, 404.0], [6.7, 420.0], [6.8, 420.0], [6.9, 420.0], [7.0, 420.0], [7.1, 420.0], [7.2, 420.0], [7.3, 420.0], [7.4, 420.0], [7.5, 420.0], [7.6, 420.0], [7.7, 420.0], [7.8, 439.0], [7.9, 439.0], [8.0, 439.0], [8.1, 439.0], [8.2, 439.0], [8.3, 439.0], [8.4, 439.0], [8.5, 439.0], [8.6, 439.0], [8.7, 439.0], [8.8, 439.0], [8.9, 472.0], [9.0, 472.0], [9.1, 472.0], [9.2, 472.0], [9.3, 472.0], [9.4, 472.0], [9.5, 472.0], [9.6, 472.0], [9.7, 472.0], [9.8, 472.0], [9.9, 472.0], [10.0, 512.0], [10.1, 512.0], [10.2, 512.0], [10.3, 512.0], [10.4, 512.0], [10.5, 512.0], [10.6, 512.0], [10.7, 512.0], [10.8, 512.0], [10.9, 512.0], [11.0, 512.0], [11.1, 512.0], [11.2, 1012.0], [11.3, 1012.0], [11.4, 1012.0], [11.5, 1012.0], [11.6, 1012.0], [11.7, 1012.0], [11.8, 1012.0], [11.9, 1012.0], [12.0, 1012.0], [12.1, 1012.0], [12.2, 1012.0], [12.3, 1053.0], [12.4, 1053.0], [12.5, 1053.0], [12.6, 1053.0], [12.7, 1053.0], [12.8, 1053.0], [12.9, 1053.0], [13.0, 1053.0], [13.1, 1053.0], [13.2, 1053.0], [13.3, 1053.0], [13.4, 1063.0], [13.5, 1063.0], [13.6, 1063.0], [13.7, 1063.0], [13.8, 1063.0], [13.9, 1063.0], [14.0, 1063.0], [14.1, 1063.0], [14.2, 1063.0], [14.3, 1063.0], [14.4, 1063.0], [14.5, 1070.0], [14.6, 1070.0], [14.7, 1070.0], [14.8, 1070.0], [14.9, 1070.0], [15.0, 1070.0], [15.1, 1070.0], [15.2, 1070.0], [15.3, 1070.0], [15.4, 1070.0], [15.5, 1070.0], [15.6, 1076.0], [15.7, 1076.0], [15.8, 1076.0], [15.9, 1076.0], [16.0, 1076.0], [16.1, 1076.0], [16.2, 1076.0], [16.3, 1076.0], [16.4, 1076.0], [16.5, 1076.0], [16.6, 1076.0], [16.7, 1076.0], [16.8, 1076.0], [16.9, 1076.0], [17.0, 1076.0], [17.1, 1076.0], [17.2, 1076.0], [17.3, 1076.0], [17.4, 1076.0], [17.5, 1076.0], [17.6, 1076.0], [17.7, 1076.0], [17.8, 1078.0], [17.9, 1078.0], [18.0, 1078.0], [18.1, 1078.0], [18.2, 1078.0], [18.3, 1078.0], [18.4, 1078.0], [18.5, 1078.0], [18.6, 1078.0], [18.7, 1078.0], [18.8, 1078.0], [18.9, 1078.0], [19.0, 1078.0], [19.1, 1078.0], [19.2, 1078.0], [19.3, 1078.0], [19.4, 1078.0], [19.5, 1078.0], [19.6, 1078.0], [19.7, 1078.0], [19.8, 1078.0], [19.9, 1078.0], [20.0, 1079.0], [20.1, 1079.0], [20.2, 1079.0], [20.3, 1079.0], [20.4, 1079.0], [20.5, 1079.0], [20.6, 1079.0], [20.7, 1079.0], [20.8, 1079.0], [20.9, 1079.0], [21.0, 1079.0], [21.1, 1079.0], [21.2, 1080.0], [21.3, 1080.0], [21.4, 1080.0], [21.5, 1080.0], [21.6, 1080.0], [21.7, 1080.0], [21.8, 1080.0], [21.9, 1080.0], [22.0, 1080.0], [22.1, 1080.0], [22.2, 1080.0], [22.3, 1081.0], [22.4, 1081.0], [22.5, 1081.0], [22.6, 1081.0], [22.7, 1081.0], [22.8, 1081.0], [22.9, 1081.0], [23.0, 1081.0], [23.1, 1081.0], [23.2, 1081.0], [23.3, 1081.0], [23.4, 1092.0], [23.5, 1092.0], [23.6, 1092.0], [23.7, 1092.0], [23.8, 1092.0], [23.9, 1092.0], [24.0, 1092.0], [24.1, 1092.0], [24.2, 1092.0], [24.3, 1092.0], [24.4, 1092.0], [24.5, 1095.0], [24.6, 1095.0], [24.7, 1095.0], [24.8, 1095.0], [24.9, 1095.0], [25.0, 1095.0], [25.1, 1095.0], [25.2, 1095.0], [25.3, 1095.0], [25.4, 1095.0], [25.5, 1095.0], [25.6, 1098.0], [25.7, 1098.0], [25.8, 1098.0], [25.9, 1098.0], [26.0, 1098.0], [26.1, 1098.0], [26.2, 1098.0], [26.3, 1098.0], [26.4, 1098.0], [26.5, 1098.0], [26.6, 1098.0], [26.7, 1101.0], [26.8, 1101.0], [26.9, 1101.0], [27.0, 1101.0], [27.1, 1101.0], [27.2, 1101.0], [27.3, 1101.0], [27.4, 1101.0], [27.5, 1101.0], [27.6, 1101.0], [27.7, 1101.0], [27.8, 1102.0], [27.9, 1102.0], [28.0, 1102.0], [28.1, 1102.0], [28.2, 1102.0], [28.3, 1102.0], [28.4, 1102.0], [28.5, 1102.0], [28.6, 1102.0], [28.7, 1102.0], [28.8, 1102.0], [28.9, 1112.0], [29.0, 1112.0], [29.1, 1112.0], [29.2, 1112.0], [29.3, 1112.0], [29.4, 1112.0], [29.5, 1112.0], [29.6, 1112.0], [29.7, 1112.0], [29.8, 1112.0], [29.9, 1112.0], [30.0, 1112.0], [30.1, 1112.0], [30.2, 1112.0], [30.3, 1112.0], [30.4, 1112.0], [30.5, 1112.0], [30.6, 1112.0], [30.7, 1112.0], [30.8, 1112.0], [30.9, 1112.0], [31.0, 1112.0], [31.1, 1112.0], [31.2, 1112.0], [31.3, 1112.0], [31.4, 1112.0], [31.5, 1112.0], [31.6, 1112.0], [31.7, 1112.0], [31.8, 1112.0], [31.9, 1112.0], [32.0, 1112.0], [32.1, 1112.0], [32.2, 1112.0], [32.3, 1114.0], [32.4, 1114.0], [32.5, 1114.0], [32.6, 1114.0], [32.7, 1114.0], [32.8, 1114.0], [32.9, 1114.0], [33.0, 1114.0], [33.1, 1114.0], [33.2, 1114.0], [33.3, 1114.0], [33.4, 1115.0], [33.5, 1115.0], [33.6, 1115.0], [33.7, 1115.0], [33.8, 1115.0], [33.9, 1115.0], [34.0, 1115.0], [34.1, 1115.0], [34.2, 1115.0], [34.3, 1115.0], [34.4, 1115.0], [34.5, 1116.0], [34.6, 1116.0], [34.7, 1116.0], [34.8, 1116.0], [34.9, 1116.0], [35.0, 1116.0], [35.1, 1116.0], [35.2, 1116.0], [35.3, 1116.0], [35.4, 1116.0], [35.5, 1116.0], [35.6, 1117.0], [35.7, 1117.0], [35.8, 1117.0], [35.9, 1117.0], [36.0, 1117.0], [36.1, 1117.0], [36.2, 1117.0], [36.3, 1117.0], [36.4, 1117.0], [36.5, 1117.0], [36.6, 1117.0], [36.7, 1117.0], [36.8, 1117.0], [36.9, 1117.0], [37.0, 1117.0], [37.1, 1117.0], [37.2, 1117.0], [37.3, 1117.0], [37.4, 1117.0], [37.5, 1117.0], [37.6, 1117.0], [37.7, 1117.0], [37.8, 1118.0], [37.9, 1118.0], [38.0, 1118.0], [38.1, 1118.0], [38.2, 1118.0], [38.3, 1118.0], [38.4, 1118.0], [38.5, 1118.0], [38.6, 1118.0], [38.7, 1118.0], [38.8, 1118.0], [38.9, 1118.0], [39.0, 1118.0], [39.1, 1118.0], [39.2, 1118.0], [39.3, 1118.0], [39.4, 1118.0], [39.5, 1118.0], [39.6, 1118.0], [39.7, 1118.0], [39.8, 1118.0], [39.9, 1118.0], [40.0, 1121.0], [40.1, 1121.0], [40.2, 1121.0], [40.3, 1121.0], [40.4, 1121.0], [40.5, 1121.0], [40.6, 1121.0], [40.7, 1121.0], [40.8, 1121.0], [40.9, 1121.0], [41.0, 1121.0], [41.1, 1121.0], [41.2, 1122.0], [41.3, 1122.0], [41.4, 1122.0], [41.5, 1122.0], [41.6, 1122.0], [41.7, 1122.0], [41.8, 1122.0], [41.9, 1122.0], [42.0, 1122.0], [42.1, 1122.0], [42.2, 1122.0], [42.3, 1125.0], [42.4, 1125.0], [42.5, 1125.0], [42.6, 1125.0], [42.7, 1125.0], [42.8, 1125.0], [42.9, 1125.0], [43.0, 1125.0], [43.1, 1125.0], [43.2, 1125.0], [43.3, 1125.0], [43.4, 1126.0], [43.5, 1126.0], [43.6, 1126.0], [43.7, 1126.0], [43.8, 1126.0], [43.9, 1126.0], [44.0, 1126.0], [44.1, 1126.0], [44.2, 1126.0], [44.3, 1126.0], [44.4, 1126.0], [44.5, 1129.0], [44.6, 1129.0], [44.7, 1129.0], [44.8, 1129.0], [44.9, 1129.0], [45.0, 1129.0], [45.1, 1129.0], [45.2, 1129.0], [45.3, 1129.0], [45.4, 1129.0], [45.5, 1129.0], [45.6, 1132.0], [45.7, 1132.0], [45.8, 1132.0], [45.9, 1132.0], [46.0, 1132.0], [46.1, 1132.0], [46.2, 1132.0], [46.3, 1132.0], [46.4, 1132.0], [46.5, 1132.0], [46.6, 1132.0], [46.7, 1134.0], [46.8, 1134.0], [46.9, 1134.0], [47.0, 1134.0], [47.1, 1134.0], [47.2, 1134.0], [47.3, 1134.0], [47.4, 1134.0], [47.5, 1134.0], [47.6, 1134.0], [47.7, 1134.0], [47.8, 1138.0], [47.9, 1138.0], [48.0, 1138.0], [48.1, 1138.0], [48.2, 1138.0], [48.3, 1138.0], [48.4, 1138.0], [48.5, 1138.0], [48.6, 1138.0], [48.7, 1138.0], [48.8, 1138.0], [48.9, 1142.0], [49.0, 1142.0], [49.1, 1142.0], [49.2, 1142.0], [49.3, 1142.0], [49.4, 1142.0], [49.5, 1142.0], [49.6, 1142.0], [49.7, 1142.0], [49.8, 1142.0], [49.9, 1142.0], [50.0, 1142.0], [50.1, 1144.0], [50.2, 1144.0], [50.3, 1144.0], [50.4, 1144.0], [50.5, 1144.0], [50.6, 1144.0], [50.7, 1144.0], [50.8, 1144.0], [50.9, 1144.0], [51.0, 1144.0], [51.1, 1144.0], [51.2, 1153.0], [51.3, 1153.0], [51.4, 1153.0], [51.5, 1153.0], [51.6, 1153.0], [51.7, 1153.0], [51.8, 1153.0], [51.9, 1153.0], [52.0, 1153.0], [52.1, 1153.0], [52.2, 1153.0], [52.3, 1154.0], [52.4, 1154.0], [52.5, 1154.0], [52.6, 1154.0], [52.7, 1154.0], [52.8, 1154.0], [52.9, 1154.0], [53.0, 1154.0], [53.1, 1154.0], [53.2, 1154.0], [53.3, 1154.0], [53.4, 1154.0], [53.5, 1154.0], [53.6, 1154.0], [53.7, 1154.0], [53.8, 1154.0], [53.9, 1154.0], [54.0, 1154.0], [54.1, 1154.0], [54.2, 1154.0], [54.3, 1154.0], [54.4, 1154.0], [54.5, 1159.0], [54.6, 1159.0], [54.7, 1159.0], [54.8, 1159.0], [54.9, 1159.0], [55.0, 1159.0], [55.1, 1159.0], [55.2, 1159.0], [55.3, 1159.0], [55.4, 1159.0], [55.5, 1159.0], [55.6, 1161.0], [55.7, 1161.0], [55.8, 1161.0], [55.9, 1161.0], [56.0, 1161.0], [56.1, 1161.0], [56.2, 1161.0], [56.3, 1161.0], [56.4, 1161.0], [56.5, 1161.0], [56.6, 1161.0], [56.7, 1164.0], [56.8, 1164.0], [56.9, 1164.0], [57.0, 1164.0], [57.1, 1164.0], [57.2, 1164.0], [57.3, 1164.0], [57.4, 1164.0], [57.5, 1164.0], [57.6, 1164.0], [57.7, 1164.0], [57.8, 1167.0], [57.9, 1167.0], [58.0, 1167.0], [58.1, 1167.0], [58.2, 1167.0], [58.3, 1167.0], [58.4, 1167.0], [58.5, 1167.0], [58.6, 1167.0], [58.7, 1167.0], [58.8, 1167.0], [58.9, 1168.0], [59.0, 1168.0], [59.1, 1168.0], [59.2, 1168.0], [59.3, 1168.0], [59.4, 1168.0], [59.5, 1168.0], [59.6, 1168.0], [59.7, 1168.0], [59.8, 1168.0], [59.9, 1168.0], [60.0, 1168.0], [60.1, 1170.0], [60.2, 1170.0], [60.3, 1170.0], [60.4, 1170.0], [60.5, 1170.0], [60.6, 1170.0], [60.7, 1170.0], [60.8, 1170.0], [60.9, 1170.0], [61.0, 1170.0], [61.1, 1170.0], [61.2, 1173.0], [61.3, 1173.0], [61.4, 1173.0], [61.5, 1173.0], [61.6, 1173.0], [61.7, 1173.0], [61.8, 1173.0], [61.9, 1173.0], [62.0, 1173.0], [62.1, 1173.0], [62.2, 1173.0], [62.3, 1179.0], [62.4, 1179.0], [62.5, 1179.0], [62.6, 1179.0], [62.7, 1179.0], [62.8, 1179.0], [62.9, 1179.0], [63.0, 1179.0], [63.1, 1179.0], [63.2, 1179.0], [63.3, 1179.0], [63.4, 1179.0], [63.5, 1179.0], [63.6, 1179.0], [63.7, 1179.0], [63.8, 1179.0], [63.9, 1179.0], [64.0, 1179.0], [64.1, 1179.0], [64.2, 1179.0], [64.3, 1179.0], [64.4, 1179.0], [64.5, 1180.0], [64.6, 1180.0], [64.7, 1180.0], [64.8, 1180.0], [64.9, 1180.0], [65.0, 1180.0], [65.1, 1180.0], [65.2, 1180.0], [65.3, 1180.0], [65.4, 1180.0], [65.5, 1180.0], [65.6, 1181.0], [65.7, 1181.0], [65.8, 1181.0], [65.9, 1181.0], [66.0, 1181.0], [66.1, 1181.0], [66.2, 1181.0], [66.3, 1181.0], [66.4, 1181.0], [66.5, 1181.0], [66.6, 1181.0], [66.7, 1185.0], [66.8, 1185.0], [66.9, 1185.0], [67.0, 1185.0], [67.1, 1185.0], [67.2, 1185.0], [67.3, 1185.0], [67.4, 1185.0], [67.5, 1185.0], [67.6, 1185.0], [67.7, 1185.0], [67.8, 1186.0], [67.9, 1186.0], [68.0, 1186.0], [68.1, 1186.0], [68.2, 1186.0], [68.3, 1186.0], [68.4, 1186.0], [68.5, 1186.0], [68.6, 1186.0], [68.7, 1186.0], [68.8, 1186.0], [68.9, 1192.0], [69.0, 1192.0], [69.1, 1192.0], [69.2, 1192.0], [69.3, 1192.0], [69.4, 1192.0], [69.5, 1192.0], [69.6, 1192.0], [69.7, 1192.0], [69.8, 1192.0], [69.9, 1192.0], [70.0, 1192.0], [70.1, 1197.0], [70.2, 1197.0], [70.3, 1197.0], [70.4, 1197.0], [70.5, 1197.0], [70.6, 1197.0], [70.7, 1197.0], [70.8, 1197.0], [70.9, 1197.0], [71.0, 1197.0], [71.1, 1197.0], [71.2, 1201.0], [71.3, 1201.0], [71.4, 1201.0], [71.5, 1201.0], [71.6, 1201.0], [71.7, 1201.0], [71.8, 1201.0], [71.9, 1201.0], [72.0, 1201.0], [72.1, 1201.0], [72.2, 1201.0], [72.3, 1202.0], [72.4, 1202.0], [72.5, 1202.0], [72.6, 1202.0], [72.7, 1202.0], [72.8, 1202.0], [72.9, 1202.0], [73.0, 1202.0], [73.1, 1202.0], [73.2, 1202.0], [73.3, 1202.0], [73.4, 1209.0], [73.5, 1209.0], [73.6, 1209.0], [73.7, 1209.0], [73.8, 1209.0], [73.9, 1209.0], [74.0, 1209.0], [74.1, 1209.0], [74.2, 1209.0], [74.3, 1209.0], [74.4, 1209.0], [74.5, 1211.0], [74.6, 1211.0], [74.7, 1211.0], [74.8, 1211.0], [74.9, 1211.0], [75.0, 1211.0], [75.1, 1211.0], [75.2, 1211.0], [75.3, 1211.0], [75.4, 1211.0], [75.5, 1211.0], [75.6, 1212.0], [75.7, 1212.0], [75.8, 1212.0], [75.9, 1212.0], [76.0, 1212.0], [76.1, 1212.0], [76.2, 1212.0], [76.3, 1212.0], [76.4, 1212.0], [76.5, 1212.0], [76.6, 1212.0], [76.7, 1213.0], [76.8, 1213.0], [76.9, 1213.0], [77.0, 1213.0], [77.1, 1213.0], [77.2, 1213.0], [77.3, 1213.0], [77.4, 1213.0], [77.5, 1213.0], [77.6, 1213.0], [77.7, 1213.0], [77.8, 1216.0], [77.9, 1216.0], [78.0, 1216.0], [78.1, 1216.0], [78.2, 1216.0], [78.3, 1216.0], [78.4, 1216.0], [78.5, 1216.0], [78.6, 1216.0], [78.7, 1216.0], [78.8, 1216.0], [78.9, 1220.0], [79.0, 1220.0], [79.1, 1220.0], [79.2, 1220.0], [79.3, 1220.0], [79.4, 1220.0], [79.5, 1220.0], [79.6, 1220.0], [79.7, 1220.0], [79.8, 1220.0], [79.9, 1220.0], [80.0, 1220.0], [80.1, 1233.0], [80.2, 1233.0], [80.3, 1233.0], [80.4, 1233.0], [80.5, 1233.0], [80.6, 1233.0], [80.7, 1233.0], [80.8, 1233.0], [80.9, 1233.0], [81.0, 1233.0], [81.1, 1233.0], [81.2, 1234.0], [81.3, 1234.0], [81.4, 1234.0], [81.5, 1234.0], [81.6, 1234.0], [81.7, 1234.0], [81.8, 1234.0], [81.9, 1234.0], [82.0, 1234.0], [82.1, 1234.0], [82.2, 1234.0], [82.3, 1237.0], [82.4, 1237.0], [82.5, 1237.0], [82.6, 1237.0], [82.7, 1237.0], [82.8, 1237.0], [82.9, 1237.0], [83.0, 1237.0], [83.1, 1237.0], [83.2, 1237.0], [83.3, 1237.0], [83.4, 1245.0], [83.5, 1245.0], [83.6, 1245.0], [83.7, 1245.0], [83.8, 1245.0], [83.9, 1245.0], [84.0, 1245.0], [84.1, 1245.0], [84.2, 1245.0], [84.3, 1245.0], [84.4, 1245.0], [84.5, 1263.0], [84.6, 1263.0], [84.7, 1263.0], [84.8, 1263.0], [84.9, 1263.0], [85.0, 1263.0], [85.1, 1263.0], [85.2, 1263.0], [85.3, 1263.0], [85.4, 1263.0], [85.5, 1263.0], [85.6, 1277.0], [85.7, 1277.0], [85.8, 1277.0], [85.9, 1277.0], [86.0, 1277.0], [86.1, 1277.0], [86.2, 1277.0], [86.3, 1277.0], [86.4, 1277.0], [86.5, 1277.0], [86.6, 1277.0], [86.7, 1281.0], [86.8, 1281.0], [86.9, 1281.0], [87.0, 1281.0], [87.1, 1281.0], [87.2, 1281.0], [87.3, 1281.0], [87.4, 1281.0], [87.5, 1281.0], [87.6, 1281.0], [87.7, 1281.0], [87.8, 1311.0], [87.9, 1311.0], [88.0, 1311.0], [88.1, 1311.0], [88.2, 1311.0], [88.3, 1311.0], [88.4, 1311.0], [88.5, 1311.0], [88.6, 1311.0], [88.7, 1311.0], [88.8, 1311.0], [88.9, 1359.0], [89.0, 1359.0], [89.1, 1359.0], [89.2, 1359.0], [89.3, 1359.0], [89.4, 1359.0], [89.5, 1359.0], [89.6, 1359.0], [89.7, 1359.0], [89.8, 1359.0], [89.9, 1359.0], [90.0, 1359.0], [90.1, 1442.0], [90.2, 1442.0], [90.3, 1442.0], [90.4, 1442.0], [90.5, 1442.0], [90.6, 1442.0], [90.7, 1442.0], [90.8, 1442.0], [90.9, 1442.0], [91.0, 1442.0], [91.1, 1442.0], [91.2, 1725.0], [91.3, 1725.0], [91.4, 1725.0], [91.5, 1725.0], [91.6, 1725.0], [91.7, 1725.0], [91.8, 1725.0], [91.9, 1725.0], [92.0, 1725.0], [92.1, 1725.0], [92.2, 1725.0], [92.3, 2537.0], [92.4, 2537.0], [92.5, 2537.0], [92.6, 2537.0], [92.7, 2537.0], [92.8, 2537.0], [92.9, 2537.0], [93.0, 2537.0], [93.1, 2537.0], [93.2, 2537.0], [93.3, 2537.0], [93.4, 2608.0], [93.5, 2608.0], [93.6, 2608.0], [93.7, 2608.0], [93.8, 2608.0], [93.9, 2608.0], [94.0, 2608.0], [94.1, 2608.0], [94.2, 2608.0], [94.3, 2608.0], [94.4, 2608.0], [94.5, 3048.0], [94.6, 3048.0], [94.7, 3048.0], [94.8, 3048.0], [94.9, 3048.0], [95.0, 3048.0], [95.1, 3048.0], [95.2, 3048.0], [95.3, 3048.0], [95.4, 3048.0], [95.5, 3048.0], [95.6, 3307.0], [95.7, 3307.0], [95.8, 3307.0], [95.9, 3307.0], [96.0, 3307.0], [96.1, 3307.0], [96.2, 3307.0], [96.3, 3307.0], [96.4, 3307.0], [96.5, 3307.0], [96.6, 3307.0], [96.7, 3594.0], [96.8, 3594.0], [96.9, 3594.0], [97.0, 3594.0], [97.1, 3594.0], [97.2, 3594.0], [97.3, 3594.0], [97.4, 3594.0], [97.5, 3594.0], [97.6, 3594.0], [97.7, 3594.0], [97.8, 3684.0], [97.9, 3684.0], [98.0, 3684.0], [98.1, 3684.0], [98.2, 3684.0], [98.3, 3684.0], [98.4, 3684.0], [98.5, 3684.0], [98.6, 3684.0], [98.7, 3684.0], [98.8, 3684.0], [98.9, 4266.0], [99.0, 4266.0], [99.1, 4266.0], [99.2, 4266.0], [99.3, 4266.0], [99.4, 4266.0], [99.5, 4266.0], [99.6, 4266.0], [99.7, 4266.0], [99.8, 4266.0], [99.9, 4266.0], [100.0, 4266.0]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "maxX": 100.0, "title": "Response Time Percentiles"}},
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
        data: {"result": {"minY": 1.0, "minX": 300.0, "maxY": 40.0, "series": [{"data": [[2500.0, 1.0], [2600.0, 1.0], [3000.0, 1.0], [3300.0, 1.0], [3500.0, 1.0], [3600.0, 1.0], [1000.0, 14.0], [4200.0, 1.0], [1100.0, 40.0], [300.0, 5.0], [1200.0, 15.0], [1300.0, 2.0], [1400.0, 1.0], [400.0, 4.0], [1700.0, 1.0], [500.0, 1.0]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 100, "maxX": 4200.0, "title": "Response Time Distribution"}},
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
        data: {"result": {"minY": 8.0, "minX": 0.0, "ticks": [[0, "Requests having \nresponse time <= 500ms"], [1, "Requests having \nresponse time > 500ms and <= 1,500ms"], [2, "Requests having \nresponse time > 1,500ms"], [3, "Requests in error"]], "maxY": 73.0, "series": [{"data": [[0.0, 9.0]], "color": "#9ACD32", "isOverall": false, "label": "Requests having \nresponse time <= 500ms", "isController": false}, {"data": [[1.0, 73.0]], "color": "yellow", "isOverall": false, "label": "Requests having \nresponse time > 500ms and <= 1,500ms", "isController": false}, {"data": [[2.0, 8.0]], "color": "orange", "isOverall": false, "label": "Requests having \nresponse time > 1,500ms", "isController": false}, {"data": [], "color": "#FF6347", "isOverall": false, "label": "Requests in error", "isController": false}], "supportsControllersDiscrimination": false, "maxX": 2.0, "title": "Synthetic Response Times Distribution"}},
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
        data: {"result": {"minY": 1.0, "minX": 1.6790394E12, "maxY": 1.0, "series": [{"data": [[1.67903952E12, 1.0], [1.67904114E12, 1.0], [1.67904084E12, 1.0], [1.67904054E12, 1.0], [1.67904024E12, 1.0], [1.67903994E12, 1.0], [1.67903964E12, 1.0], [1.67904E12, 1.0], [1.6790397E12, 1.0], [1.6790394E12, 1.0], [1.67904102E12, 1.0], [1.67904072E12, 1.0], [1.67904042E12, 1.0], [1.67904012E12, 1.0], [1.67903982E12, 1.0], [1.67904048E12, 1.0], [1.67904018E12, 1.0], [1.67903988E12, 1.0], [1.67903958E12, 1.0], [1.6790409E12, 1.0], [1.6790412E12, 1.0], [1.6790406E12, 1.0], [1.6790403E12, 1.0], [1.67904096E12, 1.0], [1.67904066E12, 1.0], [1.67904036E12, 1.0], [1.67904006E12, 1.0], [1.67903976E12, 1.0], [1.67903946E12, 1.0], [1.67904078E12, 1.0], [1.67904108E12, 1.0]], "isOverall": false, "label": "org_API", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.6790412E12, "title": "Active Threads Over Time"}},
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
        data: {"result": {"minY": 1246.0999999999997, "minX": 1.0, "maxY": 1246.0999999999997, "series": [{"data": [[1.0, 1246.0999999999997]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}, {"data": [[1.0, 1246.0999999999997]], "isOverall": false, "label": "Org_api_Retrieve-Aggregated", "isController": false}], "supportsControllersDiscrimination": true, "maxX": 1.0, "title": "Time VS Threads"}},
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
        data : {"result": {"minY": 29.316666666666666, "minX": 1.6790394E12, "maxY": 100.85, "series": [{"data": [[1.67903952E12, 100.85], [1.67904114E12, 67.23333333333333], [1.67904084E12, 100.85], [1.67904054E12, 100.85], [1.67904024E12, 100.85], [1.67903994E12, 100.85], [1.67903964E12, 100.85], [1.67904E12, 100.85], [1.6790397E12, 100.85], [1.6790394E12, 100.85], [1.67904102E12, 100.85], [1.67904072E12, 100.85], [1.67904042E12, 100.85], [1.67904012E12, 100.85], [1.67903982E12, 100.85], [1.67904048E12, 100.85], [1.67904018E12, 100.85], [1.67903988E12, 100.85], [1.67903958E12, 100.85], [1.6790409E12, 100.85], [1.6790412E12, 33.61666666666667], [1.6790406E12, 100.85], [1.6790403E12, 100.85], [1.67904096E12, 100.85], [1.67904066E12, 100.85], [1.67904036E12, 100.85], [1.67904006E12, 100.85], [1.67903976E12, 100.85], [1.67903946E12, 100.85], [1.67904078E12, 100.85], [1.67904108E12, 100.85]], "isOverall": false, "label": "Bytes received per second", "isController": false}, {"data": [[1.67903952E12, 87.95], [1.67904114E12, 58.63333333333333], [1.67904084E12, 87.95], [1.67904054E12, 87.95], [1.67904024E12, 87.95], [1.67903994E12, 87.95], [1.67903964E12, 87.95], [1.67904E12, 87.95], [1.6790397E12, 87.95], [1.6790394E12, 87.95], [1.67904102E12, 87.95], [1.67904072E12, 87.95], [1.67904042E12, 87.95], [1.67904012E12, 87.95], [1.67903982E12, 87.95], [1.67904048E12, 87.95], [1.67904018E12, 87.95], [1.67903988E12, 87.95], [1.67903958E12, 87.95], [1.6790409E12, 87.95], [1.6790412E12, 29.316666666666666], [1.6790406E12, 87.95], [1.6790403E12, 87.95], [1.67904096E12, 87.95], [1.67904066E12, 87.95], [1.67904036E12, 87.95], [1.67904006E12, 87.95], [1.67903976E12, 87.95], [1.67903946E12, 87.95], [1.67904078E12, 87.95], [1.67904108E12, 87.95]], "isOverall": false, "label": "Bytes sent per second", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.6790412E12, "title": "Bytes Throughput Over Time"}},
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
        data: {"result": {"minY": 666.6666666666667, "minX": 1.6790394E12, "maxY": 2191.0, "series": [{"data": [[1.67903952E12, 942.0], [1.67904114E12, 1155.0], [1.67904084E12, 1158.3333333333333], [1.67904054E12, 1197.3333333333333], [1.67904024E12, 1168.6666666666667], [1.67903994E12, 1233.0], [1.67903964E12, 1153.0], [1.67904E12, 1213.0], [1.6790397E12, 1169.6666666666667], [1.6790394E12, 2191.0], [1.67904102E12, 1951.3333333333335], [1.67904072E12, 2076.0], [1.67904042E12, 1625.0], [1.67904012E12, 892.6666666666666], [1.67903982E12, 905.3333333333334], [1.67904048E12, 700.3333333333333], [1.67904018E12, 1114.3333333333333], [1.67903988E12, 1157.0], [1.67903958E12, 869.6666666666666], [1.6790409E12, 1297.6666666666667], [1.6790412E12, 1112.0], [1.6790406E12, 1130.6666666666667], [1.6790403E12, 1064.3333333333333], [1.67904096E12, 1138.6666666666667], [1.67904066E12, 894.0], [1.67904036E12, 906.0], [1.67904006E12, 1643.6666666666667], [1.67903976E12, 1750.6666666666667], [1.67903946E12, 1875.0], [1.67904078E12, 1157.3333333333333], [1.67904108E12, 666.6666666666667]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.6790412E12, "title": "Response Time Over Time"}},
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
        data: {"result": {"minY": 666.6666666666667, "minX": 1.6790394E12, "maxY": 2191.0, "series": [{"data": [[1.67903952E12, 942.0], [1.67904114E12, 1155.0], [1.67904084E12, 1158.3333333333333], [1.67904054E12, 1197.0], [1.67904024E12, 1168.6666666666667], [1.67903994E12, 1233.0], [1.67903964E12, 1153.0], [1.67904E12, 1213.0], [1.6790397E12, 1169.3333333333333], [1.6790394E12, 2191.0], [1.67904102E12, 1951.3333333333335], [1.67904072E12, 2075.6666666666665], [1.67904042E12, 1625.0], [1.67904012E12, 892.3333333333334], [1.67903982E12, 905.3333333333334], [1.67904048E12, 700.3333333333333], [1.67904018E12, 1114.3333333333333], [1.67903988E12, 1157.0], [1.67903958E12, 869.6666666666666], [1.6790409E12, 1297.6666666666667], [1.6790412E12, 1112.0], [1.6790406E12, 1130.6666666666667], [1.6790403E12, 1064.0], [1.67904096E12, 1138.6666666666667], [1.67904066E12, 894.0], [1.67904036E12, 906.0], [1.67904006E12, 1643.6666666666667], [1.67903976E12, 1750.6666666666667], [1.67903946E12, 1875.0], [1.67904078E12, 1157.3333333333333], [1.67904108E12, 666.6666666666667]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.6790412E12, "title": "Latencies Over Time"}},
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
        data: {"result": {"minY": 66.0, "minX": 1.6790394E12, "maxY": 151.0, "series": [{"data": [[1.67903952E12, 121.66666666666667], [1.67904114E12, 99.0], [1.67904084E12, 112.0], [1.67904054E12, 75.66666666666667], [1.67904024E12, 90.33333333333333], [1.67903994E12, 102.33333333333333], [1.67903964E12, 104.66666666666667], [1.67904E12, 151.0], [1.6790397E12, 75.66666666666667], [1.6790394E12, 107.0], [1.67904102E12, 141.66666666666666], [1.67904072E12, 126.33333333333333], [1.67904042E12, 66.0], [1.67904012E12, 109.66666666666667], [1.67903982E12, 95.0], [1.67904048E12, 129.0], [1.67904018E12, 96.33333333333333], [1.67903988E12, 111.0], [1.67903958E12, 77.66666666666667], [1.6790409E12, 93.0], [1.6790412E12, 66.0], [1.6790406E12, 123.33333333333333], [1.6790403E12, 77.0], [1.67904096E12, 103.66666666666667], [1.67904066E12, 77.0], [1.67904036E12, 101.0], [1.67904006E12, 105.66666666666667], [1.67903976E12, 104.0], [1.67903946E12, 85.66666666666667], [1.67904078E12, 74.0], [1.67904108E12, 123.0]], "isOverall": false, "label": "Org_api_Retrieve", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.6790412E12, "title": "Connect Time Over Time"}},
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
        data: {"result": {"minY": 322.0, "minX": 1.6790394E12, "maxY": 4266.0, "series": [{"data": [[1.67903952E12, 1311.0], [1.67904114E12, 1212.0], [1.67904084E12, 1181.0], [1.67904054E12, 1234.0], [1.67904024E12, 1233.0], [1.67903994E12, 1442.0], [1.67903964E12, 1245.0], [1.67904E12, 1359.0], [1.6790397E12, 1237.0], [1.6790394E12, 4266.0], [1.67904102E12, 3594.0], [1.67904072E12, 3684.0], [1.67904042E12, 2537.0], [1.67904012E12, 1153.0], [1.67903982E12, 1126.0], [1.67904048E12, 1277.0], [1.67904018E12, 1167.0], [1.67903988E12, 1201.0], [1.67903958E12, 1170.0], [1.6790409E12, 1725.0], [1.6790412E12, 1112.0], [1.6790406E12, 1138.0], [1.6790403E12, 1101.0], [1.67904096E12, 1197.0], [1.67904066E12, 1213.0], [1.67904036E12, 1202.0], [1.67904006E12, 2608.0], [1.67903976E12, 3048.0], [1.67903946E12, 3307.0], [1.67904078E12, 1216.0], [1.67904108E12, 1220.0]], "isOverall": false, "label": "Max", "isController": false}, {"data": [[1.67903952E12, 439.0], [1.67904114E12, 1098.0], [1.67904084E12, 1114.0], [1.67904054E12, 1173.0], [1.67904024E12, 1129.0], [1.67903994E12, 1078.0], [1.67903964E12, 1053.0], [1.67904E12, 1112.0], [1.6790397E12, 1063.0], [1.6790394E12, 1115.0], [1.67904102E12, 1118.0], [1.67904072E12, 1263.0], [1.67904042E12, 1159.0], [1.67904012E12, 404.0], [1.67903982E12, 512.0], [1.67904048E12, 352.0], [1.67904018E12, 1081.0], [1.67903988E12, 1116.0], [1.67903958E12, 322.0], [1.6790409E12, 1076.0], [1.6790412E12, 1112.0], [1.6790406E12, 1122.0], [1.6790403E12, 1012.0], [1.67904096E12, 1102.0], [1.67904066E12, 351.0], [1.67904036E12, 382.0], [1.67904006E12, 1112.0], [1.67903976E12, 1079.0], [1.67903946E12, 1154.0], [1.67904078E12, 1070.0], [1.67904108E12, 360.0]], "isOverall": false, "label": "Min", "isController": false}, {"data": [[1.67903952E12, 1311.0], [1.67904114E12, 1212.0], [1.67904084E12, 1181.0], [1.67904054E12, 1234.0], [1.67904024E12, 1233.0], [1.67903994E12, 1442.0], [1.67903964E12, 1245.0], [1.67904E12, 1359.0], [1.6790397E12, 1237.0], [1.6790394E12, 4266.0], [1.67904102E12, 3594.0], [1.67904072E12, 3684.0], [1.67904042E12, 2537.0], [1.67904012E12, 1153.0], [1.67903982E12, 1126.0], [1.67904048E12, 1277.0], [1.67904018E12, 1167.0], [1.67903988E12, 1201.0], [1.67903958E12, 1170.0], [1.6790409E12, 1725.0], [1.6790412E12, 1112.0], [1.6790406E12, 1138.0], [1.6790403E12, 1101.0], [1.67904096E12, 1197.0], [1.67904066E12, 1213.0], [1.67904036E12, 1202.0], [1.67904006E12, 2608.0], [1.67903976E12, 3048.0], [1.67903946E12, 3307.0], [1.67904078E12, 1216.0], [1.67904108E12, 1220.0]], "isOverall": false, "label": "90th percentile", "isController": false}, {"data": [[1.67903952E12, 1311.0], [1.67904114E12, 1212.0], [1.67904084E12, 1181.0], [1.67904054E12, 1234.0], [1.67904024E12, 1233.0], [1.67903994E12, 1442.0], [1.67903964E12, 1245.0], [1.67904E12, 1359.0], [1.6790397E12, 1237.0], [1.6790394E12, 4266.0], [1.67904102E12, 3594.0], [1.67904072E12, 3684.0], [1.67904042E12, 2537.0], [1.67904012E12, 1153.0], [1.67903982E12, 1126.0], [1.67904048E12, 1277.0], [1.67904018E12, 1167.0], [1.67903988E12, 1201.0], [1.67903958E12, 1170.0], [1.6790409E12, 1725.0], [1.6790412E12, 1112.0], [1.6790406E12, 1138.0], [1.6790403E12, 1101.0], [1.67904096E12, 1197.0], [1.67904066E12, 1213.0], [1.67904036E12, 1202.0], [1.67904006E12, 2608.0], [1.67903976E12, 3048.0], [1.67903946E12, 3307.0], [1.67904078E12, 1216.0], [1.67904108E12, 1220.0]], "isOverall": false, "label": "99th percentile", "isController": false}, {"data": [[1.67903952E12, 1076.0], [1.67904114E12, 1155.0], [1.67904084E12, 1180.0], [1.67904054E12, 1185.0], [1.67904024E12, 1144.0], [1.67903994E12, 1179.0], [1.67903964E12, 1161.0], [1.67904E12, 1168.0], [1.6790397E12, 1209.0], [1.6790394E12, 1192.0], [1.67904102E12, 1142.0], [1.67904072E12, 1281.0], [1.67904042E12, 1179.0], [1.67904012E12, 1121.0], [1.67903982E12, 1078.0], [1.67904048E12, 472.0], [1.67904018E12, 1095.0], [1.67903988E12, 1154.0], [1.67903958E12, 1117.0], [1.6790409E12, 1092.0], [1.6790412E12, 1112.0], [1.6790406E12, 1132.0], [1.6790403E12, 1080.0], [1.67904096E12, 1117.0], [1.67904066E12, 1118.0], [1.67904036E12, 1134.0], [1.67904006E12, 1211.0], [1.67903976E12, 1125.0], [1.67903946E12, 1164.0], [1.67904078E12, 1186.0], [1.67904108E12, 420.0]], "isOverall": false, "label": "Median", "isController": false}, {"data": [[1.67903952E12, 1311.0], [1.67904114E12, 1212.0], [1.67904084E12, 1181.0], [1.67904054E12, 1234.0], [1.67904024E12, 1233.0], [1.67903994E12, 1442.0], [1.67903964E12, 1245.0], [1.67904E12, 1359.0], [1.6790397E12, 1237.0], [1.6790394E12, 4266.0], [1.67904102E12, 3594.0], [1.67904072E12, 3684.0], [1.67904042E12, 2537.0], [1.67904012E12, 1153.0], [1.67903982E12, 1126.0], [1.67904048E12, 1277.0], [1.67904018E12, 1167.0], [1.67903988E12, 1201.0], [1.67903958E12, 1170.0], [1.6790409E12, 1725.0], [1.6790412E12, 1112.0], [1.6790406E12, 1138.0], [1.6790403E12, 1101.0], [1.67904096E12, 1197.0], [1.67904066E12, 1213.0], [1.67904036E12, 1202.0], [1.67904006E12, 2608.0], [1.67903976E12, 3048.0], [1.67903946E12, 3307.0], [1.67904078E12, 1216.0], [1.67904108E12, 1220.0]], "isOverall": false, "label": "95th percentile", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.6790412E12, "title": "Response Time Percentiles Over Time (successful requests only)"}},
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
    data: {"result": {"minY": 1143.0, "minX": 1.0, "maxY": 1143.0, "series": [{"data": [[1.0, 1143.0]], "isOverall": false, "label": "Successes", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 1000, "maxX": 1.0, "title": "Response Time Vs Request"}},
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
    data: {"result": {"minY": 1143.0, "minX": 1.0, "maxY": 1143.0, "series": [{"data": [[1.0, 1143.0]], "isOverall": false, "label": "Successes", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 1000, "maxX": 1.0, "title": "Latencies Vs Request"}},
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
        data: {"result": {"minY": 0.05, "minX": 1.6790394E12, "maxY": 0.05, "series": [{"data": [[1.67903952E12, 0.05], [1.67904114E12, 0.05], [1.67904084E12, 0.05], [1.67904054E12, 0.05], [1.67904024E12, 0.05], [1.67903994E12, 0.05], [1.67903964E12, 0.05], [1.67904E12, 0.05], [1.6790397E12, 0.05], [1.6790394E12, 0.05], [1.67904102E12, 0.05], [1.67904072E12, 0.05], [1.67904042E12, 0.05], [1.67904012E12, 0.05], [1.67903982E12, 0.05], [1.67904048E12, 0.05], [1.67904018E12, 0.05], [1.67903988E12, 0.05], [1.67903958E12, 0.05], [1.6790409E12, 0.05], [1.6790406E12, 0.05], [1.6790403E12, 0.05], [1.67904096E12, 0.05], [1.67904066E12, 0.05], [1.67904036E12, 0.05], [1.67904006E12, 0.05], [1.67903976E12, 0.05], [1.67903946E12, 0.05], [1.67904078E12, 0.05], [1.67904108E12, 0.05]], "isOverall": false, "label": "hitsPerSecond", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.67904114E12, "title": "Hits Per Second"}},
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
        data: {"result": {"minY": 0.016666666666666666, "minX": 1.6790394E12, "maxY": 0.05, "series": [{"data": [[1.67903952E12, 0.05], [1.67904114E12, 0.03333333333333333], [1.67904084E12, 0.05], [1.67904054E12, 0.05], [1.67904024E12, 0.05], [1.67903994E12, 0.05], [1.67903964E12, 0.05], [1.67904E12, 0.05], [1.6790397E12, 0.05], [1.6790394E12, 0.05], [1.67904102E12, 0.05], [1.67904072E12, 0.05], [1.67904042E12, 0.05], [1.67904012E12, 0.05], [1.67903982E12, 0.05], [1.67904048E12, 0.05], [1.67904018E12, 0.05], [1.67903988E12, 0.05], [1.67903958E12, 0.05], [1.6790409E12, 0.05], [1.6790412E12, 0.016666666666666666], [1.6790406E12, 0.05], [1.6790403E12, 0.05], [1.67904096E12, 0.05], [1.67904066E12, 0.05], [1.67904036E12, 0.05], [1.67904006E12, 0.05], [1.67903976E12, 0.05], [1.67903946E12, 0.05], [1.67904078E12, 0.05], [1.67904108E12, 0.05]], "isOverall": false, "label": "200", "isController": false}], "supportsControllersDiscrimination": false, "granularity": 60000, "maxX": 1.6790412E12, "title": "Codes Per Second"}},
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
        data: {"result": {"minY": 0.016666666666666666, "minX": 1.6790394E12, "maxY": 0.05, "series": [{"data": [[1.67903952E12, 0.05], [1.67904114E12, 0.03333333333333333], [1.67904084E12, 0.05], [1.67904054E12, 0.05], [1.67904024E12, 0.05], [1.67903994E12, 0.05], [1.67903964E12, 0.05], [1.67904E12, 0.05], [1.6790397E12, 0.05], [1.6790394E12, 0.05], [1.67904102E12, 0.05], [1.67904072E12, 0.05], [1.67904042E12, 0.05], [1.67904012E12, 0.05], [1.67903982E12, 0.05], [1.67904048E12, 0.05], [1.67904018E12, 0.05], [1.67903988E12, 0.05], [1.67903958E12, 0.05], [1.6790409E12, 0.05], [1.6790412E12, 0.016666666666666666], [1.6790406E12, 0.05], [1.6790403E12, 0.05], [1.67904096E12, 0.05], [1.67904066E12, 0.05], [1.67904036E12, 0.05], [1.67904006E12, 0.05], [1.67903976E12, 0.05], [1.67903946E12, 0.05], [1.67904078E12, 0.05], [1.67904108E12, 0.05]], "isOverall": false, "label": "Org_api_Retrieve-success", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.6790412E12, "title": "Transactions Per Second"}},
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
        data: {"result": {"minY": 0.016666666666666666, "minX": 1.6790394E12, "maxY": 0.05, "series": [{"data": [[1.67903952E12, 0.05], [1.67904114E12, 0.03333333333333333], [1.67904084E12, 0.05], [1.67904054E12, 0.05], [1.67904024E12, 0.05], [1.67903994E12, 0.05], [1.67903964E12, 0.05], [1.67904E12, 0.05], [1.6790397E12, 0.05], [1.6790394E12, 0.05], [1.67904102E12, 0.05], [1.67904072E12, 0.05], [1.67904042E12, 0.05], [1.67904012E12, 0.05], [1.67903982E12, 0.05], [1.67904048E12, 0.05], [1.67904018E12, 0.05], [1.67903988E12, 0.05], [1.67903958E12, 0.05], [1.6790409E12, 0.05], [1.6790412E12, 0.016666666666666666], [1.6790406E12, 0.05], [1.6790403E12, 0.05], [1.67904096E12, 0.05], [1.67904066E12, 0.05], [1.67904036E12, 0.05], [1.67904006E12, 0.05], [1.67903976E12, 0.05], [1.67903946E12, 0.05], [1.67904078E12, 0.05], [1.67904108E12, 0.05]], "isOverall": false, "label": "Transaction-success", "isController": false}, {"data": [], "isOverall": false, "label": "Transaction-failure", "isController": false}], "supportsControllersDiscrimination": true, "granularity": 60000, "maxX": 1.6790412E12, "title": "Total Transactions Per Second"}},
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


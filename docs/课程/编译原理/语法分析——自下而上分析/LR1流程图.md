---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
开始 ^JLyyp7A4

从文本文件读入文法G ^QIGuZkqw

获取该文法的拓广文法G' ^wtFnDYCJ

计算拓广文法G'的FIRST集合 ^W2pCkwcj

初始化项目集规范族 ^DELtInrO

将与构造项目集规范族的DFA相关信息输出到json文件中 ^QB2uBES8

解析json文件，并绘制DFA ^g81YCEJD

结束 ^NVQOehnt

开始 ^WL8gLs7F

初始化第一个项目集，并将其添加到C（项目集规范族）中 ^yBdiAP3k

对每个项目集I和每个文法符号X，检查GOTO(I,X)非空且不存在与C中 ^lbVqkDQO

将GOTO(I,X)添加到C中 ^IDTZogOW

不为空且不存在 ^OgTGpRD3

存在或为空 ^AD8Dv2t5

是否添加完毕 ^zdlm6zfg

结束 ^PZYpvCv6

是 ^9SksAeKO

否 ^RCKc3Mdp

开始 ^1HN2roCw

将J初始化为空 ^Csh89vBg

将I中与X对应的项目[A->a •Xβ,α]的下一个项目[A->a X•β,α]添加到J中 ^jOeWinSm

返回J的闭包 ^UB90rXLl

结束 ^d3A8qkLr

%%
# Drawing
```json
{
	"type": "excalidraw",
	"version": 2,
	"source": "https://github.com/zsviczian/obsidian-excalidraw-plugin/releases/tag/1.9.6",
	"elements": [
		{
			"type": "rectangle",
			"version": 49,
			"versionNonce": 1065236657,
			"isDeleted": false,
			"id": "jT-ExIXOtbwpNLK9HsQaa",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -325.3499755859375,
			"y": -278.4124984741211,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122,
			"height": 35,
			"seed": 737944977,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "JLyyp7A4"
				},
				{
					"id": "1qz31nH5S1iNH2ArM9VbU",
					"type": "arrow"
				}
			],
			"updated": 1688092992552,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 5,
			"versionNonce": 87577169,
			"isDeleted": false,
			"id": "JLyyp7A4",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -284.3499755859375,
			"y": -273.4124984741211,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 40,
			"height": 25,
			"seed": 1504067761,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688092943668,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "开始",
			"rawText": "开始",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "jT-ExIXOtbwpNLK9HsQaa",
			"originalText": "开始",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 104,
			"versionNonce": 1863059871,
			"isDeleted": false,
			"id": "Txrlo1OBdgD-iyIzmwUOw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -341.95001220703125,
			"y": -206.01251983642578,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 156,
			"height": 60,
			"seed": 2060628497,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "QIGuZkqw"
				},
				{
					"id": "1qz31nH5S1iNH2ArM9VbU",
					"type": "arrow"
				},
				{
					"id": "_SqXnGRb5KiDGGaXWUqgQ",
					"type": "arrow"
				}
			],
			"updated": 1688093104547,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 82,
			"versionNonce": 862459889,
			"isDeleted": false,
			"id": "QIGuZkqw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -333.95001220703125,
			"y": -201.01251983642578,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 140,
			"height": 50,
			"seed": 615088575,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093081641,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "从文本文件读入\n文法G",
			"rawText": "从文本文件读入文法G",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Txrlo1OBdgD-iyIzmwUOw",
			"originalText": "从文本文件读入文法G",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "arrow",
			"version": 178,
			"versionNonce": 961253311,
			"isDeleted": false,
			"id": "1qz31nH5S1iNH2ArM9VbU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -267.22343235589886,
			"y": -241.62499237060547,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 0.6916287708193636,
			"height": 34.61247253417969,
			"seed": 1954274623,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093081991,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "jT-ExIXOtbwpNLK9HsQaa",
				"gap": 1.787506103515625,
				"focus": 0.04056645856817612
			},
			"endBinding": {
				"elementId": "Txrlo1OBdgD-iyIzmwUOw",
				"gap": 1,
				"focus": -0.05832728241501826
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-0.6916287708193636,
					34.61247253417969
				]
			]
		},
		{
			"type": "rectangle",
			"version": 106,
			"versionNonce": 1542504273,
			"isDeleted": false,
			"id": "1SZOdDIyjHOhZkjS0XkMj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -342.7499542236328,
			"y": -113.62499237060547,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 163,
			"height": 60,
			"seed": 1725595761,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "wtFnDYCJ"
				},
				{
					"id": "o8Q0snwXNulvpXkOQkutQ",
					"type": "arrow"
				}
			],
			"updated": 1688093091149,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 58,
			"versionNonce": 1630036767,
			"isDeleted": false,
			"id": "wtFnDYCJ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -331.2499542236328,
			"y": -108.62499237060547,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 140,
			"height": 50,
			"seed": 611116241,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093079367,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "获取该文法的拓\n广文法G'",
			"rawText": "获取该文法的拓广文法G'",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "1SZOdDIyjHOhZkjS0XkMj",
			"originalText": "获取该文法的拓广文法G'",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 191,
			"versionNonce": 464421425,
			"isDeleted": false,
			"id": "kA7EdZcfSDqhWZx9o17qu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -342.3499755859375,
			"y": -12.624992370605469,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 163,
			"height": 60,
			"seed": 1157584767,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "W2pCkwcj"
				},
				{
					"id": "o8Q0snwXNulvpXkOQkutQ",
					"type": "arrow"
				},
				{
					"id": "tZfXiqMKyvanU1xA9jfzO",
					"type": "arrow"
				}
			],
			"updated": 1688093244188,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 147,
			"versionNonce": 1656061631,
			"isDeleted": false,
			"id": "W2pCkwcj",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -331.3999710083008,
			"y": -7.624992370605469,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 141.09999084472656,
			"height": 50,
			"seed": 524685215,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093073094,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "计算拓广文法G'\n的FIRST集合",
			"rawText": "计算拓广文法G'的FIRST集合",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "kA7EdZcfSDqhWZx9o17qu",
			"originalText": "计算拓广文法G'的FIRST集合",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "arrow",
			"version": 17,
			"versionNonce": 979766961,
			"isDeleted": false,
			"id": "_SqXnGRb5KiDGGaXWUqgQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -266.4499816894531,
			"y": -144.02498626708984,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 0.79998779296875,
			"height": 31.199981689453125,
			"seed": 2126876593,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093086789,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "Txrlo1OBdgD-iyIzmwUOw",
				"focus": 0.04215035566992805,
				"gap": 1.9875335693359375
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					0.79998779296875,
					31.199981689453125
				]
			]
		},
		{
			"type": "arrow",
			"version": 21,
			"versionNonce": 670718527,
			"isDeleted": false,
			"id": "o8Q0snwXNulvpXkOQkutQ",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -268.04998779296875,
			"y": -52.82500457763672,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 2.399993896484375,
			"height": 38.4000244140625,
			"seed": 1693651089,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093091149,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "1SZOdDIyjHOhZkjS0XkMj",
				"focus": 0.10464800372705146,
				"gap": 1
			},
			"endBinding": {
				"elementId": "kA7EdZcfSDqhWZx9o17qu",
				"focus": -0.03373344039147319,
				"gap": 1.79998779296875
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					2.399993896484375,
					38.4000244140625
				]
			]
		},
		{
			"type": "rectangle",
			"version": 72,
			"versionNonce": 289570705,
			"isDeleted": false,
			"id": "iENwxFKNireStEFi2_6sU",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -347.3500061035156,
			"y": 83.7750015258789,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 165,
			"height": 62,
			"seed": 532728049,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "DELtInrO"
				},
				{
					"id": "tZfXiqMKyvanU1xA9jfzO",
					"type": "arrow"
				},
				{
					"id": "XaYfiIZOIeaMMY7pBbVlX",
					"type": "arrow"
				}
			],
			"updated": 1688093252551,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 28,
			"versionNonce": 907788753,
			"isDeleted": false,
			"id": "DELtInrO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -334.8500061035156,
			"y": 89.7750015258789,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 140,
			"height": 50,
			"seed": 1882824657,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093246716,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "初始化项目集规\n范族",
			"rawText": "初始化项目集规范族",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "iENwxFKNireStEFi2_6sU",
			"originalText": "初始化项目集规范族",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 112,
			"versionNonce": 1583570417,
			"isDeleted": false,
			"id": "ACYggtAGdTC1qhMglMwRb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -362.9500274658203,
			"y": 179.1750259399414,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 191,
			"height": 110,
			"seed": 814013841,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "QB2uBES8"
				},
				{
					"id": "XaYfiIZOIeaMMY7pBbVlX",
					"type": "arrow"
				},
				{
					"id": "ySIUVStH_ajTAeKKWAw7D",
					"type": "arrow"
				}
			],
			"updated": 1688093264308,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 71,
			"versionNonce": 1641343103,
			"isDeleted": false,
			"id": "QB2uBES8",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -357.5500183105469,
			"y": 196.6750259399414,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 180.19998168945312,
			"height": 75,
			"seed": 1137956831,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093253675,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "将与构造项目集规范\n族的DFA相关信息输\n出到json文件中",
			"rawText": "将与构造项目集规范族的DFA相关信息输出到json文件中",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ACYggtAGdTC1qhMglMwRb",
			"originalText": "将与构造项目集规范族的DFA相关信息输出到json文件中",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "rectangle",
			"version": 83,
			"versionNonce": 389944255,
			"isDeleted": false,
			"id": "x7cHOPY_ahh28T8-1N6yf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -371.74998474121094,
			"y": 325.87499237060547,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 193,
			"height": 83,
			"seed": 746930961,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "g81YCEJD"
				},
				{
					"id": "ySIUVStH_ajTAeKKWAw7D",
					"type": "arrow"
				},
				{
					"id": "vuC9K29Q_mC7w2RES4wtN",
					"type": "arrow"
				}
			],
			"updated": 1688093281272,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 37,
			"versionNonce": 598229521,
			"isDeleted": false,
			"id": "g81YCEJD",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -364.1699676513672,
			"y": 342.37499237060547,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 177.8399658203125,
			"height": 50,
			"seed": 1179046335,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093266499,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "解析json文件，并绘\n制DFA",
			"rawText": "解析json文件，并绘制DFA",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "x7cHOPY_ahh28T8-1N6yf",
			"originalText": "解析json文件，并绘制DFA",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "rectangle",
			"version": 110,
			"versionNonce": 1793278943,
			"isDeleted": false,
			"id": "raepl9lufEr5IRKyeODvI",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -345.25,
			"y": 449.27503204345703,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 156,
			"height": 41,
			"seed": 1377406001,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "NVQOehnt"
				},
				{
					"id": "vuC9K29Q_mC7w2RES4wtN",
					"type": "arrow"
				}
			],
			"updated": 1688093281272,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 34,
			"versionNonce": 947606239,
			"isDeleted": false,
			"id": "NVQOehnt",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -287.25,
			"y": 457.27503204345703,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 40,
			"height": 25,
			"seed": 363576351,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093272597,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "结束",
			"rawText": "结束",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "raepl9lufEr5IRKyeODvI",
			"originalText": "结束",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "arrow",
			"version": 56,
			"versionNonce": 1103454129,
			"isDeleted": false,
			"id": "tZfXiqMKyvanU1xA9jfzO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -266.7315938830066,
			"y": 48.975013732910156,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1.3368831593926984,
			"height": 32.79998779296875,
			"seed": 1838417663,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093246717,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "kA7EdZcfSDqhWZx9o17qu",
				"focus": 0.09222435497409871,
				"gap": 1.600006103515625
			},
			"endBinding": {
				"elementId": "iENwxFKNireStEFi2_6sU",
				"focus": 0.009554646040394944,
				"gap": 2
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					1.3368831593926984,
					32.79998779296875
				]
			]
		},
		{
			"type": "arrow",
			"version": 63,
			"versionNonce": 732826641,
			"isDeleted": false,
			"id": "XaYfiIZOIeaMMY7pBbVlX",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -270.48074945118515,
			"y": 146.7750015258789,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 0.06700189885947339,
			"height": 31.79998779296875,
			"seed": 1178616209,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093257696,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "iENwxFKNireStEFi2_6sU",
				"focus": 0.06738083585028212,
				"gap": 1
			},
			"endBinding": {
				"elementId": "ACYggtAGdTC1qhMglMwRb",
				"focus": -0.03362278160932805,
				"gap": 1
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-0.06700189885947339,
					31.79998779296875
				]
			]
		},
		{
			"type": "arrow",
			"version": 132,
			"versionNonce": 999593585,
			"isDeleted": false,
			"id": "ySIUVStH_ajTAeKKWAw7D",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -272.124608529124,
			"y": 290.1750259399414,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 0.8401607088531478,
			"height": 32.5999755859375,
			"seed": 1528062449,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093270616,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "ACYggtAGdTC1qhMglMwRb",
				"focus": 0.06312385423611894,
				"gap": 1
			},
			"endBinding": {
				"elementId": "x7cHOPY_ahh28T8-1N6yf",
				"focus": 0.05242374168531995,
				"gap": 3.0999908447265625
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					0.8401607088531478,
					32.5999755859375
				]
			]
		},
		{
			"type": "arrow",
			"version": 13,
			"versionNonce": 304958385,
			"isDeleted": false,
			"id": "vuC9K29Q_mC7w2RES4wtN",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -273.24999321831604,
			"y": 412.44166819254554,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 0.8888753255208144,
			"height": 36.444430881076414,
			"seed": 1818992383,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093281272,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "x7cHOPY_ahh28T8-1N6yf",
				"focus": -0.009238032319871688,
				"gap": 3.5666758219400663
			},
			"endBinding": {
				"elementId": "raepl9lufEr5IRKyeODvI",
				"focus": -0.05861961456885457,
				"gap": 1
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					0.8888753255208144,
					36.444430881076414
				]
			]
		},
		{
			"type": "rectangle",
			"version": 71,
			"versionNonce": 489493727,
			"isDeleted": false,
			"id": "GH_XUw4Xw7VnQG8sbZkcg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 112.10426925595402,
			"y": -280.73887715164386,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 114,
			"height": 47,
			"seed": 1361105777,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "WL8gLs7F"
				},
				{
					"id": "BQrKerP1P7fG9-Ziv4H6e",
					"type": "arrow"
				}
			],
			"updated": 1688093920222,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 41,
			"versionNonce": 1736600721,
			"isDeleted": false,
			"id": "WL8gLs7F",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 149.10426925595402,
			"y": -269.73887715164386,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 40,
			"height": 25,
			"seed": 558764543,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "开始",
			"rawText": "开始",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "GH_XUw4Xw7VnQG8sbZkcg",
			"originalText": "开始",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 78,
			"versionNonce": 1843464991,
			"isDeleted": false,
			"id": "Hmn4TuEKjkEiMM2YKHwSO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 79.05444539865476,
			"y": -193.0213986970523,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 197,
			"height": 110,
			"seed": 969959729,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "yBdiAP3k"
				},
				{
					"id": "BQrKerP1P7fG9-Ziv4H6e",
					"type": "arrow"
				},
				{
					"id": "tMVi0UPQMkjXnI2py0gKx",
					"type": "arrow"
				},
				{
					"id": "DMXZc-IOKPANIsuvOyzHA",
					"type": "arrow"
				}
			],
			"updated": 1688093921290,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 62,
			"versionNonce": 1097247007,
			"isDeleted": false,
			"id": "yBdiAP3k",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 87.55444539865476,
			"y": -175.5213986970523,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 180,
			"height": 75,
			"seed": 528975103,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "初始化第一个项目集\n，并将其添加到C（\n项目集规范族）中",
			"rawText": "初始化第一个项目集，并将其添加到C（项目集规范族）中",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Hmn4TuEKjkEiMM2YKHwSO",
			"originalText": "初始化第一个项目集，并将其添加到C（项目集规范族）中",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "diamond",
			"version": 377,
			"versionNonce": 560040497,
			"isDeleted": false,
			"id": "nJiBv13d7V2vYzODNRDmG",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -48.5883899459323,
			"y": -45.09292536069631,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 449,
			"height": 170,
			"seed": 882148447,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "lbVqkDQO"
				},
				{
					"id": "Q2sJQCdNXCphT-m7x9JNb",
					"type": "arrow"
				},
				{
					"id": "DMXZc-IOKPANIsuvOyzHA",
					"type": "arrow"
				},
				{
					"id": "C4EywvPiQyfctme8NOidu",
					"type": "arrow"
				}
			],
			"updated": 1688093920222,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 454,
			"versionNonce": 1190669663,
			"isDeleted": false,
			"id": "lbVqkDQO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 70.13164179234894,
			"y": 2.407074639303687,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 212.0599365234375,
			"height": 75,
			"seed": 833306673,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "对每个项目集I和每个文\n法符号X，检查GOTO(I\n,X)非空且不存在与C中",
			"rawText": "对每个项目集I和每个文法符号X，检查GOTO(I,X)非空且不存在与C中",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "nJiBv13d7V2vYzODNRDmG",
			"originalText": "对每个项目集I和每个文法符号X，检查GOTO(I,X)非空且不存在与C中",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"type": "rectangle",
			"version": 181,
			"versionNonce": 1285923231,
			"isDeleted": false,
			"id": "e2tvea0aA04tJDgd5GJS-",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 104.83575773817117,
			"y": 189.39888314827988,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 149,
			"height": 60,
			"seed": 790196863,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "IDTZogOW"
				},
				{
					"id": "Q2sJQCdNXCphT-m7x9JNb",
					"type": "arrow"
				},
				{
					"id": "o_ijN6gq5VDyOY7kO_PXp",
					"type": "arrow"
				}
			],
			"updated": 1688093920222,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 165,
			"versionNonce": 1932921809,
			"isDeleted": false,
			"id": "IDTZogOW",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 117.35579252821023,
			"y": 194.39888314827988,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 123.95993041992188,
			"height": 50,
			"seed": 1692090559,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "将GOTO(I,X)\n添加到C中",
			"rawText": "将GOTO(I,X)添加到C中",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "e2tvea0aA04tJDgd5GJS-",
			"originalText": "将GOTO(I,X)添加到C中",
			"lineHeight": 1.25,
			"baseline": 43
		},
		{
			"type": "arrow",
			"version": 91,
			"versionNonce": 351293247,
			"isDeleted": false,
			"id": "BQrKerP1P7fG9-Ziv4H6e",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 166.99231835470025,
			"y": -233.30031440896548,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1.315597406970852,
			"height": 39.90654947424534,
			"seed": 1722044607,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093921290,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "GH_XUw4Xw7VnQG8sbZkcg",
				"focus": 0.050214561684592804,
				"gap": 1
			},
			"endBinding": {
				"elementId": "Hmn4TuEKjkEiMM2YKHwSO",
				"focus": -0.07397902413889643,
				"gap": 1
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					1.315597406970852,
					39.90654947424534
				]
			]
		},
		{
			"type": "arrow",
			"version": 64,
			"versionNonce": 745441329,
			"isDeleted": false,
			"id": "tMVi0UPQMkjXnI2py0gKx",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 176.39116413520844,
			"y": -79.75773440263387,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 0.9263772251763385,
			"height": 41.68602101563454,
			"seed": 1717159551,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093921290,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "Hmn4TuEKjkEiMM2YKHwSO",
				"focus": 0.02464905262829719,
				"gap": 3.263664294418419
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					0.9263772251763385,
					41.68602101563454
				]
			]
		},
		{
			"type": "arrow",
			"version": 148,
			"versionNonce": 1118853649,
			"isDeleted": false,
			"id": "Q2sJQCdNXCphT-m7x9JNb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 179.75628956122102,
			"y": 127.17336745199411,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1.1897327326994258,
			"height": 58.00674180290055,
			"seed": 94680031,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "OgTGpRD3"
				}
			],
			"updated": 1688093921290,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "nJiBv13d7V2vYzODNRDmG",
				"focus": -0.025098142200793105,
				"gap": 3.480822536877909
			},
			"endBinding": {
				"elementId": "e2tvea0aA04tJDgd5GJS-",
				"focus": -0.01958371123961667,
				"gap": 4.218773893385219
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-1.1897327326994258,
					58.00674180290055
				]
			]
		},
		{
			"type": "text",
			"version": 31,
			"versionNonce": 1321890161,
			"isDeleted": false,
			"id": "OgTGpRD3",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 109.1614231948713,
			"y": 143.6767383534444,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 140,
			"height": 25,
			"seed": 327766705,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "不为空且不存在",
			"rawText": "不为空且不存在",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "Q2sJQCdNXCphT-m7x9JNb",
			"originalText": "不为空且不存在",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "arrow",
			"version": 175,
			"versionNonce": 1118227327,
			"isDeleted": false,
			"id": "DMXZc-IOKPANIsuvOyzHA",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 400.5693286646009,
			"y": 45.30032864426977,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 218.62000719136785,
			"height": 112.08909993353518,
			"seed": 176849937,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "AD8Dv2t5"
				}
			],
			"updated": 1688093921290,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "nJiBv13d7V2vYzODNRDmG",
				"focus": 0.9961138018848993,
				"gap": 5.099680712288645
			},
			"endBinding": {
				"elementId": "Hmn4TuEKjkEiMM2YKHwSO",
				"focus": 1.0172605647908517,
				"gap": 16.23262740778688
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-15.748024113541874,
					-82.44570014377058
				],
				[
					-218.62000719136785,
					-112.08909993353518
				]
			]
		},
		{
			"type": "text",
			"version": 23,
			"versionNonce": 473766737,
			"isDeleted": false,
			"id": "AD8Dv2t5",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 334.82130455105903,
			"y": -49.64537149950081,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 100,
			"height": 25,
			"seed": 882877905,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "存在或为空",
			"rawText": "存在或为空",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "DMXZc-IOKPANIsuvOyzHA",
			"originalText": "存在或为空",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "diamond",
			"version": 187,
			"versionNonce": 640794175,
			"isDeleted": false,
			"id": "CPRQtk7J5UdwC_MrN-gLd",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 42.84856057817735,
			"y": 284.5317432027414,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 275,
			"height": 81,
			"seed": 1478174097,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "zdlm6zfg"
				},
				{
					"id": "o_ijN6gq5VDyOY7kO_PXp",
					"type": "arrow"
				},
				{
					"id": "ttlfEALIstmznnSzsw7Jf",
					"type": "arrow"
				},
				{
					"id": "C4EywvPiQyfctme8NOidu",
					"type": "arrow"
				}
			],
			"updated": 1688093920222,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 135,
			"versionNonce": 1568639281,
			"isDeleted": false,
			"id": "zdlm6zfg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 120.59856057817734,
			"y": 312.7817432027414,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 120,
			"height": 25,
			"seed": 1627691327,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "是否添加完毕",
			"rawText": "是否添加完毕",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "CPRQtk7J5UdwC_MrN-gLd",
			"originalText": "是否添加完毕",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 122,
			"versionNonce": 136425713,
			"isDeleted": false,
			"id": "MvFloflpLHuzdfMNaT6Tf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 92.60825737515236,
			"y": 411.9386442647594,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 174,
			"height": 62,
			"seed": 529219039,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "PZYpvCv6"
				},
				{
					"id": "ttlfEALIstmznnSzsw7Jf",
					"type": "arrow"
				}
			],
			"updated": 1688093920222,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 83,
			"versionNonce": 1220727455,
			"isDeleted": false,
			"id": "PZYpvCv6",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 159.60825737515236,
			"y": 430.4386442647594,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 40,
			"height": 25,
			"seed": 1917958239,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "结束",
			"rawText": "结束",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "MvFloflpLHuzdfMNaT6Tf",
			"originalText": "结束",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "arrow",
			"version": 98,
			"versionNonce": 1608450975,
			"isDeleted": false,
			"id": "o_ijN6gq5VDyOY7kO_PXp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 179.17026047305967,
			"y": 254.8883787506546,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 2.7790610001733853,
			"height": 25.937961564414792,
			"seed": 1089517841,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1688093921291,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "e2tvea0aA04tJDgd5GJS-",
				"focus": 0.051057986632043834,
				"gap": 5.489495602374717
			},
			"endBinding": {
				"elementId": "CPRQtk7J5UdwC_MrN-gLd",
				"focus": 0.04608758768807366,
				"gap": 4.006709188913007
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					2.7790610001733853,
					25.937961564414792
				]
			]
		},
		{
			"type": "arrow",
			"version": 84,
			"versionNonce": 1973106623,
			"isDeleted": false,
			"id": "ttlfEALIstmznnSzsw7Jf",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 179.17026047305967,
			"y": 366.05110145901347,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 0,
			"height": 41.68602101563454,
			"seed": 1661032095,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "9SksAeKO"
				}
			],
			"updated": 1688093921291,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "CPRQtk7J5UdwC_MrN-gLd",
				"focus": 0.008569455309946699,
				"gap": 1
			},
			"endBinding": {
				"elementId": "MvFloflpLHuzdfMNaT6Tf",
				"focus": -0.005034447150490387,
				"gap": 4.2015217901113715
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					0,
					41.68602101563454
				]
			]
		},
		{
			"type": "text",
			"version": 23,
			"versionNonce": 427292383,
			"isDeleted": false,
			"id": "9SksAeKO",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 169.17026047305967,
			"y": 374.39411196683074,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 20,
			"height": 25,
			"seed": 1235889009,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "是",
			"rawText": "是",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "ttlfEALIstmznnSzsw7Jf",
			"originalText": "是",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "arrow",
			"version": 207,
			"versionNonce": 1241245663,
			"isDeleted": false,
			"id": "C4EywvPiQyfctme8NOidu",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 46.701320975456504,
			"y": 326.9125736405165,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 226.95720786072698,
			"height": 396.48040592995534,
			"seed": 1530446641,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "RCKc3Mdp"
				}
			],
			"updated": 1688093921291,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "CPRQtk7J5UdwC_MrN-gLd",
				"focus": -0.9765395119430528,
				"gap": 1
			},
			"endBinding": {
				"elementId": "nJiBv13d7V2vYzODNRDmG",
				"focus": 1.2853379392947424,
				"gap": 23.059024310615527
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-97.26736470097504,
					-291.8021824471197
				],
				[
					129.68984315975194,
					-396.48040592995534
				]
			]
		},
		{
			"type": "text",
			"version": 23,
			"versionNonce": 1312015103,
			"isDeleted": false,
			"id": "RCKc3Mdp",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -60.56604372551853,
			"y": 22.610391193396765,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 20,
			"height": 25,
			"seed": 31804433,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093920222,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "否",
			"rawText": "否",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "C4EywvPiQyfctme8NOidu",
			"originalText": "否",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 43,
			"versionNonce": 461140895,
			"isDeleted": false,
			"id": "9nicjB3zzEb7uGlvoMyhe",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 570.0087833887184,
			"y": -290.2537500158419,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 135,
			"height": 59,
			"seed": 185701375,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "1HN2roCw"
				},
				{
					"id": "KStQg10GfoqqlB6feHTjd",
					"type": "arrow"
				}
			],
			"updated": 1688094192869,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 2,
			"versionNonce": 631204543,
			"isDeleted": false,
			"id": "1HN2roCw",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 617.5087833887184,
			"y": -273.2537500158419,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 40,
			"height": 25,
			"seed": 1898813087,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093936983,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "开始",
			"rawText": "开始",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "9nicjB3zzEb7uGlvoMyhe",
			"originalText": "开始",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 81,
			"versionNonce": 2101427825,
			"isDeleted": false,
			"id": "cK2x9TM9D3VAGVFWChzD9",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 554.647698230622,
			"y": -190.05865486792257,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 173,
			"height": 57,
			"seed": 1697851025,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "Csh89vBg"
				},
				{
					"id": "KStQg10GfoqqlB6feHTjd",
					"type": "arrow"
				},
				{
					"id": "SGiZcKd3ABgGkmaBE8DdZ",
					"type": "arrow"
				}
			],
			"updated": 1688094197085,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 49,
			"versionNonce": 573965247,
			"isDeleted": false,
			"id": "Csh89vBg",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 574.8077018927314,
			"y": -174.05865486792257,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 132.67999267578125,
			"height": 25,
			"seed": 1007138143,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688093966094,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "将J初始化为空",
			"rawText": "将J初始化为空",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "cK2x9TM9D3VAGVFWChzD9",
			"originalText": "将J初始化为空",
			"lineHeight": 1.25,
			"baseline": 18
		},
		{
			"type": "rectangle",
			"version": 553,
			"versionNonce": 993535825,
			"isDeleted": false,
			"id": "YwLWFQyt4AAz5_aqyckYb",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 512.8569016364695,
			"y": -95.87003074132852,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 271,
			"height": 125,
			"seed": 828191711,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"type": "text",
					"id": "jOeWinSm"
				},
				{
					"id": "WQkbNpVwR6jB-sb9vpkGz",
					"type": "arrow"
				}
			],
			"updated": 1688094201047,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 833,
			"versionNonce": 1600034065,
			"isDeleted": false,
			"id": "jOeWinSm",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 524.8269257453562,
			"y": -70.87003074132852,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 247.05995178222656,
			"height": 75,
			"seed": 466460913,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688094152410,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "将I中与X对应的项目[A->a \n•Xβ,α]的下一个项目[A->a \nX•β,α]添加到J中",
			"rawText": "将I中与X对应的项目[A->a •Xβ,α]的下一个项目[A->a X•β,α]添加到J中",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "YwLWFQyt4AAz5_aqyckYb",
			"originalText": "将I中与X对应的项目[A->a •Xβ,α]的下一个项目[A->a X•β,α]添加到J中",
			"lineHeight": 1.25,
			"baseline": 68
		},
		{
			"id": "vFNJltUewDTnOCjqbwsYO",
			"type": "rectangle",
			"x": 554.6097896409993,
			"y": 69.26127173166705,
			"width": 181,
			"height": 74,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"seed": 969657073,
			"version": 67,
			"versionNonce": 114746705,
			"isDeleted": false,
			"boundElements": [
				{
					"type": "text",
					"id": "UB90rXLl"
				},
				{
					"id": "WQkbNpVwR6jB-sb9vpkGz",
					"type": "arrow"
				},
				{
					"id": "Og3NQO2SCfZYRfX1vrkqO",
					"type": "arrow"
				}
			],
			"updated": 1688094208656,
			"link": null,
			"locked": false
		},
		{
			"id": "UB90rXLl",
			"type": "text",
			"x": 588.7697933031087,
			"y": 93.76127173166705,
			"width": 112.67999267578125,
			"height": 25,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"seed": 1014501055,
			"version": 37,
			"versionNonce": 603125631,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094179493,
			"link": null,
			"locked": false,
			"text": "返回J的闭包",
			"rawText": "返回J的闭包",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 18,
			"containerId": "vFNJltUewDTnOCjqbwsYO",
			"originalText": "返回J的闭包",
			"lineHeight": 1.25,
			"isFrameName": false
		},
		{
			"id": "6dzSoZv_OGW74lkz1Ag6Y",
			"type": "rectangle",
			"x": 561.1352522586782,
			"y": 196.0131427270884,
			"width": 171,
			"height": 63,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"seed": 516272031,
			"version": 34,
			"versionNonce": 642782001,
			"isDeleted": false,
			"boundElements": [
				{
					"type": "text",
					"id": "d3A8qkLr"
				},
				{
					"id": "Og3NQO2SCfZYRfX1vrkqO",
					"type": "arrow"
				}
			],
			"updated": 1688094208656,
			"link": null,
			"locked": false
		},
		{
			"id": "d3A8qkLr",
			"type": "text",
			"x": 626.6352522586782,
			"y": 215.0131427270884,
			"width": 40,
			"height": 25,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"seed": 2072484817,
			"version": 2,
			"versionNonce": 1621490097,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094185425,
			"link": null,
			"locked": false,
			"text": "结束",
			"rawText": "结束",
			"fontSize": 20,
			"fontFamily": 1,
			"textAlign": "center",
			"verticalAlign": "middle",
			"baseline": 18,
			"containerId": "6dzSoZv_OGW74lkz1Ag6Y",
			"originalText": "结束",
			"lineHeight": 1.25,
			"isFrameName": false
		},
		{
			"id": "KStQg10GfoqqlB6feHTjd",
			"type": "arrow",
			"x": 639.4644535131602,
			"y": -230.11486004163322,
			"width": 2.6075270089959304,
			"height": 37.80973845511642,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 719872511,
			"version": 27,
			"versionNonce": 1064131025,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094192869,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					2.6075270089959304,
					37.80973845511642
				]
			],
			"lastCommittedPoint": null,
			"startBinding": {
				"elementId": "9nicjB3zzEb7uGlvoMyhe",
				"focus": 0.0022625247608635156,
				"gap": 1.1388899742086664
			},
			"endBinding": {
				"elementId": "cK2x9TM9D3VAGVFWChzD9",
				"focus": 0.03441675314568094,
				"gap": 2.2464667185942346
			},
			"startArrowhead": null,
			"endArrowhead": "arrow"
		},
		{
			"id": "SGiZcKd3ABgGkmaBE8DdZ",
			"type": "arrow",
			"x": 639.4644535131602,
			"y": -131.02731677040458,
			"width": 1.3037635044979652,
			"height": 35.20216171073082,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 1562638257,
			"version": 20,
			"versionNonce": 657577215,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094197085,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					1.3037635044979652,
					35.20216171073082
				]
			],
			"lastCommittedPoint": null,
			"startBinding": {
				"elementId": "cK2x9TM9D3VAGVFWChzD9",
				"focus": 0.03213979915662732,
				"gap": 2.031338097517988
			},
			"endBinding": null,
			"startArrowhead": null,
			"endArrowhead": "arrow"
		},
		{
			"id": "WQkbNpVwR6jB-sb9vpkGz",
			"type": "arrow",
			"x": 647.2871340109272,
			"y": 29.33803131693628,
			"width": 0,
			"height": 32.59458496634528,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 1632427295,
			"version": 18,
			"versionNonce": 1362981439,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094201047,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					32.59458496634528
				]
			],
			"lastCommittedPoint": null,
			"startBinding": {
				"elementId": "YwLWFQyt4AAz5_aqyckYb",
				"focus": 0.00789496402614273,
				"gap": 1
			},
			"endBinding": {
				"elementId": "vFNJltUewDTnOCjqbwsYO",
				"focus": 0.024059053811357166,
				"gap": 7.32865544838549
			},
			"startArrowhead": null,
			"endArrowhead": "arrow"
		},
		{
			"id": "Og3NQO2SCfZYRfX1vrkqO",
			"type": "arrow",
			"x": 644.6796070019312,
			"y": 145.37477369128135,
			"width": 0,
			"height": 49.54375920176699,
			"angle": 0,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 443732575,
			"version": 30,
			"versionNonce": 577868863,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094208656,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					0,
					49.54375920176699
				]
			],
			"lastCommittedPoint": null,
			"startBinding": {
				"elementId": "vFNJltUewDTnOCjqbwsYO",
				"focus": 0.0047533993267194164,
				"gap": 2.1135019596142968
			},
			"endBinding": {
				"elementId": "6dzSoZv_OGW74lkz1Ag6Y",
				"focus": -0.02287304393856079,
				"gap": 1.0946098340400567
			},
			"startArrowhead": null,
			"endArrowhead": "arrow"
		},
		{
			"id": "fka2uVRieAyRBd5Dcz3gu",
			"type": "line",
			"x": 197.48186147536225,
			"y": -47.585159362404795,
			"width": 376.7934221051073,
			"height": 243.80750549534065,
			"angle": 0,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dotted",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 1042842897,
			"version": 81,
			"versionNonce": 1904418239,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094268392,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					376.7934221051073,
					-243.80750549534065
				]
			],
			"lastCommittedPoint": null,
			"startBinding": null,
			"endBinding": null,
			"startArrowhead": null,
			"endArrowhead": null
		},
		{
			"id": "lhgjO6c59qbemkpDretVb",
			"type": "line",
			"x": 183.1402639843262,
			"y": 125.81802271147421,
			"width": 392.43878310064133,
			"height": 144.71998709180684,
			"angle": 0,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dotted",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 1507003953,
			"version": 93,
			"versionNonce": 1952180593,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094272998,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					392.43878310064133,
					144.71998709180684
				]
			],
			"lastCommittedPoint": null,
			"startBinding": null,
			"endBinding": null,
			"startArrowhead": null,
			"endArrowhead": null
		},
		{
			"id": "ghA3CsCSS0QcOJELabIYA",
			"type": "line",
			"x": -189.04963007141413,
			"y": 77.9487083487162,
			"width": 301.17394519487453,
			"height": 365.0593764907621,
			"angle": 0,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dotted",
			"roughness": 2,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 970646673,
			"version": 42,
			"versionNonce": 1831187537,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094257863,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					301.17394519487453,
					-365.0593764907621
				]
			],
			"lastCommittedPoint": null,
			"startBinding": null,
			"endBinding": null,
			"startArrowhead": null,
			"endArrowhead": null
		},
		{
			"id": "VnaEoP7I8a406DX_pOkDK",
			"type": "line",
			"x": -189.04963007141413,
			"y": 144.44164178590472,
			"width": 290.74368795272204,
			"height": 337.6798704101034,
			"angle": 0,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"fillStyle": "hachure",
			"strokeWidth": 4,
			"strokeStyle": "dotted",
			"roughness": 1,
			"opacity": 100,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"seed": 461309489,
			"version": 59,
			"versionNonce": 1817154577,
			"isDeleted": false,
			"boundElements": null,
			"updated": 1688094264181,
			"link": null,
			"locked": false,
			"points": [
				[
					0,
					0
				],
				[
					290.74368795272204,
					337.6798704101034
				]
			],
			"lastCommittedPoint": null,
			"startBinding": null,
			"endBinding": null,
			"startArrowhead": null,
			"endArrowhead": null
		},
		{
			"type": "text",
			"version": 2,
			"versionNonce": 378762495,
			"isDeleted": true,
			"id": "RZW3KFtq",
			"fillStyle": "hachure",
			"strokeWidth": 1,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 616.3222782928991,
			"y": -26.72464487809964,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 124.27993774414062,
			"height": 25,
			"seed": 56110,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1688094066540,
			"link": null,
			"locked": false,
			"fontSize": 20,
			"fontFamily": 1,
			"text": "[A->a •Xβ,α]",
			"rawText": "[A->a •Xβ,α]",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "[A->a •Xβ,α]",
			"lineHeight": 1.25,
			"baseline": 18
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#2f9e44",
		"currentItemBackgroundColor": "transparent",
		"currentItemFillStyle": "hachure",
		"currentItemStrokeWidth": 4,
		"currentItemStrokeStyle": "dotted",
		"currentItemRoughness": 2,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 20,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": 466.2631449314655,
		"scrollY": 479.92273813570193,
		"zoom": {
			"value": 0.5635988545536166
		},
		"currentItemRoundness": "round",
		"gridSize": null,
		"currentStrokeOptions": null,
		"previousGridSize": null
	},
	"files": {}
}
```
%%
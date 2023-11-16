local AddonName, Addon = ...;


local ADD_ITEMLEVEL_BONUSID = {
	[-100] = 1372, [-99] = 1373, [-98] = 1374, [-97] = 1375, [-96] = 1376, [-95] = 1377, [-94] = 1378, [-93] = 1379, [-92] = 1380, [-91] = 1381, [-90] = 1382, [-89] = 1383, [-88] = 1384, [-87] = 1385, [-86] = 1386, [-85] = 1387, [-84] = 1388, [-83] = 1389, [-82] = 1390, [-81] = 1391, [-80] = 1392, [-79] = 1393, [-78] = 1394, [-77] = 1395, [-76] = 1396, [-75] = 1397, [-74] = 1398, [-73] = 1399, [-72] = 1400, [-71] = 1401, [-70] = 1402, [-69] = 1403, [-68] = 1404, [-67] = 1405, [-66] = 1406, [-65] = 1407, [-64] = 1408, [-63] = 1409, [-62] = 1410, [-61] = 1411, [-60] = 1412, [-59] = 1413, [-58] = 1414, [-57] = 1415, [-56] = 1416, [-55] = 1417, [-54] = 1418, [-53] = 1419, [-52] = 1420, [-51] = 1421, [-50] = 1422, [-49] = 1423, [-48] = 1424, [-47] = 1425, [-46] = 1426, [-45] = 1427, [-44] = 1428, [-43] = 1429, [-42] = 1430, [-41] = 1431, [-40] = 1432, [-39] = 1433, [-38] = 1434, [-37] = 1435, [-36] = 1436, [-35] = 1437, [-34] = 1438, [-33] = 1439, [-32] = 1440, [-31] = 1441, [-30] = 1442, [-29] = 1443, [-28] = 1444, [-27] = 1445, [-26] = 1446, [-25] = 1447, [-24] = 1448, [-23] = 1449, [-22] = 1450, [-21] = 1451, [-20] = 1452, [-19] = 1453, [-18] = 1454, [-17] = 1455, [-16] = 1456, [-15] = 1457, [-14] = 1458, [-13] = 1459, [-12] = 1460, [-11] = 1461, [-10] = 1462, [-9] = 1463, [-8] = 1464, [-7] = 1465, [-6] = 1466, [-5] = 1467, [-4] = 1468, [-3] = 1469, [-2] = 1470, [-1] = 1471,
	[1] = 1473, [2] = 1474, [3] = 1475, [4] = 1476, [5] = 1477, [6] = 1478, [7] = 1479, [8] = 1480, [9] = 1481, [10] = 1482, [11] = 1483, [12] = 1484, [13] = 1485, [14] = 1486, [15] = 1487, [16] = 1488, [17] = 1489, [18] = 1490, [19] = 1491, [20] = 1492, [21] = 1493, [22] = 1494, [23] = 1495, [24] = 1496, [25] = 1497, [26] = 1498, [27] = 1499, [28] = 1500, [29] = 1501, [30] = 1502, [31] = 1503, [32] = 1504, [33] = 1505, [34] = 1506, [35] = 1507, [36] = 1508, [37] = 1509, [38] = 1510, [39] = 1511, [40] = 1512, [41] = 1513, [42] = 1514, [43] = 1515, [44] = 1516, [45] = 1517, [46] = 1518, [47] = 1519, [48] = 1520, [49] = 1521, [50] = 1522, [51] = 1523, [52] = 1524, [53] = 1525, [54] = 1526, [55] = 1527, [56] = 1528, [57] = 1529, [58] = 1530, [59] = 1531, [60] = 1532, [61] = 1533, [62] = 1534, [63] = 1535, [64] = 1536, [65] = 1537, [66] = 1538, [67] = 1539, [68] = 1540, [69] = 1541, [70] = 1542, [71] = 1543, [72] = 1544, [73] = 1545, [74] = 1546, [75] = 1547, [76] = 1548, [77] = 1549, [78] = 1550, [79] = 1551, [80] = 1552, [81] = 1553, [82] = 1554, [83] = 1555, [84] = 1556, [85] = 1557, [86] = 1558, [87] = 1559, [88] = 1560, [89] = 1561, [90] = 1562, [91] = 1563, [92] = 1564, [93] = 1565, [94] = 1566, [95] = 1567, [96] = 1568, [97] = 1569, [98] = 1570, [99] = 1571, [100] = 1572,
	[101] = 1573, [102] = 1574, [103] = 1575, [104] = 1576, [105] = 1577, [106] = 1578, [107] = 1579, [108] = 1580, [109] = 1581, [110] = 1582, [111] = 1583, [112] = 1584, [113] = 1585, [114] = 1586, [115] = 1587, [116] = 1588, [117] = 1589, [118] = 1590, [119] = 1591, [120] = 1592, [121] = 1593, [122] = 1594, [123] = 1595, [124] = 1596, [125] = 1597, [126] = 1598, [127] = 1599, [128] = 1600, [129] = 1601, [130] = 1602, [131] = 1603, [132] = 1604, [133] = 1605, [134] = 1606, [135] = 1607, [136] = 1608, [137] = 1609, [138] = 1610, [139] = 1611, [140] = 1612, [141] = 1613, [142] = 1614, [143] = 1615, [144] = 1616, [145] = 1617, [146] = 1618, [147] = 1619, [148] = 1620, [149] = 1621, [150] = 1622, [151] = 1623, [152] = 1624, [153] = 1625, [154] = 1626, [155] = 1627, [156] = 1628, [157] = 1629, [158] = 1630, [159] = 1631, [160] = 1632, [161] = 1633, [162] = 1634, [163] = 1635, [164] = 1636, [165] = 1637, [166] = 1638, [167] = 1639, [168] = 1640, [169] = 1641, [170] = 1642, [171] = 1643, [172] = 1644, [173] = 1645, [174] = 1646, [175] = 1647, [176] = 1648, [177] = 1649, [178] = 1650, [179] = 1651, [180] = 1652, [181] = 1653, [182] = 1654, [183] = 1655, [184] = 1656, [185] = 1657, [186] = 1658, [187] = 1659, [188] = 1660, [189] = 1661, [190] = 1662, [191] = 1663, [192] = 1664, [193] = 1665, [194] = 1666, [195] = 1667, [196] = 1668, [197] = 1669, [198] = 1670, [199] = 1671, [200] = 1672,
	[201] = 3130, [202] = 3131, [203] = 3132, [204] = 3133, [205] = 3134, [206] = 3135, [207] = 3136, [208] = 3137, [209] = 3138, [210] = 3139, [211] = 3140, [212] = 3141, [213] = 3142, [214] = 3143, [215] = 3144, [216] = 3145, [217] = 3146, [218] = 3147, [219] = 3148, [220] = 3149, [221] = 3150, [222] = 3151, [223] = 3152, [224] = 3153, [225] = 3154, [226] = 3155, [227] = 3156, [228] = 3157, [229] = 3158, [230] = 3159, [231] = 3160, [232] = 3161, [233] = 3162, [234] = 3163, [235] = 3164, [236] = 3165, [237] = 3166, [238] = 3167, [239] = 3168, [240] = 3169, [241] = 3170, [242] = 3171, [243] = 3172, [244] = 3173, [245] = 3174, [246] = 3175, [247] = 3176, [248] = 3177, [249] = 3178, [250] = 3179, [251] = 3180, [252] = 3181, [253] = 3182, [254] = 3183, [255] = 3184, [256] = 3185, [257] = 3186, [258] = 3187, [259] = 3188, [260] = 3189, [261] = 3190, [262] = 3191, [263] = 3192, [264] = 3193, [265] = 3194, [266] = 3195, [267] = 3196, [268] = 3197, [269] = 3198, [270] = 3199, [271] = 3200, [272] = 3201, [273] = 3202, [274] = 3203, [275] = 3204, [276] = 3205, [277] = 3206, [278] = 3207, [279] = 3208, [280] = 3209, [281] = 3210, [282] = 3211, [283] = 3212, [284] = 3213, [285] = 3214, [286] = 3215, [287] = 3216, [288] = 3217, [289] = 3218, [290] = 3219, [291] = 3220, [292] = 3221, [293] = 3222, [294] = 3223, [295] = 3224, [296] = 3225, [297] = 3226, [298] = 3227, [299] = 3228, [300] = 3229,
	[301] = 3230, [302] = 3231, [303] = 3232, [304] = 3233, [305] = 3234, [306] = 3235, [307] = 3236, [308] = 3237, [309] = 3238, [310] = 3239, [311] = 3240, [312] = 3241, [313] = 3242, [314] = 3243, [315] = 3244, [316] = 3245, [317] = 3246, [318] = 3247, [319] = 3248, [320] = 3249, [321] = 3250, [322] = 3251, [323] = 3252, [324] = 3253, [325] = 3254, [326] = 3255, [327] = 3256, [328] = 3257, [329] = 3258, [330] = 3259, [331] = 3260, [332] = 3261, [333] = 3262, [334] = 3263, [335] = 3264, [336] = 3265, [337] = 3266, [338] = 3267, [339] = 3268, [340] = 3269, [341] = 3270, [342] = 3271, [343] = 3272, [344] = 3273, [345] = 3274, [346] = 3275, [347] = 3276, [348] = 3277, [349] = 3278, [350] = 3279, [351] = 3280, [352] = 3281, [353] = 3282, [354] = 3283, [355] = 3284, [356] = 3285, [357] = 3286, [358] = 3287, [359] = 3288, [360] = 3289, [361] = 3290, [362] = 3291, [363] = 3292, [364] = 3293, [365] = 3294, [366] = 3295, [367] = 3296, [368] = 3297, [369] = 3298, [370] = 3299, [371] = 3300, [372] = 3301, [373] = 3302, [374] = 3303, [375] = 3304, [376] = 3305, [377] = 3306, [378] = 3307, [379] = 3308, [380] = 3309, [381] = 3310, [382] = 3311, [383] = 3312, [384] = 3313, [385] = 3314, [386] = 3315, [387] = 3316, [388] = 3317, [389] = 3318, [390] = 3319, [391] = 3320, [392] = 3321, [393] = 3322, [394] = 3323, [395] = 3324, [396] = 3325, [397] = 3326, [398] = 3327, [399] = 3328, [400] = 3329,
	[401] = 9455, [402] = 9456, [403] = 9457, [404] = 9458, [405] = 9459, [406] = 9460, [407] = 9461, [408] = 9464, [409] = 9465, [410] = 9466, [411] = 9834, [412] = 9835, [413] = 9836, [414] = 9837, [415] = 9838, [416] = 9839, [417] = 9840, [418] = 9841, [419] = 9842, [420] = 9843, [421] = 9844, [422] = 9845, [423] = 9846, [424] = 9847, [425] = 9848, [426] = 9849, [427] = 9850, [428] = 9851, [429] = 9852, [430] = 9874, [431] = 9874, [432] = 9875, [433] = 9876, [434] = 9877, [435] = 9878, [436] = 9879, [437] = 9880, [438] = 9881, [439] = 9882, [440] = 9883, [441] = 9884, [442] = 9885, [443] = 9886, [444] = 9887, [445] = 9888, [446] = 9889, [447] = 9890, [448] = 9891, [449] = 9892, [450] = 9893, [451] = 9918, [452] = 9919, [453] = 9920, [454] = 9921, [455] = 9922
};

local ADD_SUBTITLE_BONUSID = {
	['veteran-1'] = 9552, ['veteran-2'] = 9553, ['veteran-3'] = 9554, ['veteran-4'] = 9555, ['veteran-5'] = 9556, ['veteran-6'] = 9557, ['veteran-7'] = 9558, ['veteran-8'] = 9559,
	['champion-1'] = 9560, ['champion-2'] = 9561, ['champion-3'] = 9562, ['champion-4'] = 9563, ['champion-5'] = 9564, ['champion-6'] = 9565, ['champion-7'] = 9566, ['champion-8'] = 9567,
	['hero-1'] = 9568, ['hero-2'] = 9569, ['hero-3'] = 9570, ['hero-4'] = 9571, ['hero-5'] = 9572, ['hero-6'] = 9581,
	['myth-1'] = 9573, ['myth-2'] = 9574, ['myth-3'] = 9575, ['myth-4'] = 9576
};

local function UpgradeItemTo(targetItemLink, targetItemLevel, targetBonusID)
	if (Addon.SELECTED_SLOT_ID == Enum.ItemSlotFilterType.Other) then
		return targetItemLink;
	end

	local itemID = (targetItemLink):match('item:(%d+)');

	local _, _, baseItemLevel = GetDetailedItemLevelInfo(itemID);
	if (baseItemLevel == nil) then
		return;
	end

	local specID = Addon.SELECTED_SPEC_ID;
	local itemLink = 'item:'..itemID..'::::::::70:'..specID;
	local diffItemLevel = targetItemLevel - baseItemLevel;

	local bonusLevelID = ADD_ITEMLEVEL_BONUSID[diffItemLevel];
	if (bonusLevelID == nil) then
		return itemLink;
	end

	itemLink = itemLink..'::16:5:1674:'..bonusLevelID;

	local bonusTitleID = ADD_SUBTITLE_BONUSID[targetBonusID];
	if (bonusTitleID == nil) then
		return itemLink;
	end

	itemLink = itemLink..':'..bonusTitleID;

	return itemLink;
end
Addon.API.UpgradeItemTo = UpgradeItemTo;
